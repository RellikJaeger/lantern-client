package internalsdk

import (
	"fmt"
	"net"
	"net/http"
	"net/url"
	"strconv"
	"sync"
	"time"

	"github.com/getlantern/flashlight"
	"github.com/getlantern/flashlight/common"
	"github.com/getlantern/flashlight/config"
	"github.com/getlantern/flashlight/geolookup"
	"github.com/getlantern/flashlight/ops"
	"github.com/getlantern/flashlight/proxied"
	replicaServer "github.com/getlantern/replica/server"
	replicaService "github.com/getlantern/replica/service"
	"github.com/gorilla/mux"
)

// Replica HTTP Server that handles Replica API requests on localhost at a random port.
type ReplicaServer struct {
	ConfigDir  string
	Flashlight *flashlight.Flashlight
	Session    Session
	UserConfig common.UserConfig

	startOnce sync.Once
}

// Checks whether Replica should be enabled and lazily starts the server if necessary.
//
// If enabled, the server is started lazily and the server's random address is reported to Session.SetReplicaAddr.
// If disabled after having been enabled, the server keeps running and ReplicaAddr remains set to its old value.
func (s *ReplicaServer) CheckEnabled() {
	if !s.Session.ForceReplica() && !s.Flashlight.FeatureEnabled(config.FeatureReplica) {
		// Replica is not enabled
		log.Debug("Replica not enabled")
		return
	}

	log.Debug("Replica enabled")
	s.startOnce.Do(func() {
		log.Debug("Starting Replica server")
		h, err := s.newHandler()
		if err != nil {
			log.Errorf(
				"Failed to start replica server. Will continue without it. Err: %v", err)
			return
		}

		l, srv, err := NewReplicaServer(h)
		if err != nil {
			log.Errorf(
				"Failed to start replica server. Will continue without it. Err: %v", err)
			return
		}
		go srv.Serve(l)
		addr := l.Addr().String()
		log.Debugf("Replica started at address: %v", addr)

		// We need to use localhost instead of 127.0.0.1 as the address. If we don't, ExoPlayer on
		// newer versions of Android (9.0 or newer) will fail to load media with the below error:
		//
		// "Cleartext HTTP traffic to 127.0.0.1 not permitted"
		//
		// The ExoPlayer documentation points to some Android network security configuration specifics,
		// see https://exoplayer.dev/troubleshooting.html#fixing-cleartext-http-traffic-not-permitted-errors.
		//
		// However, if we use "localhost" instead of an IP address, the problem goes away.
		_, port, _ := net.SplitHostPort(addr)
		s.Session.SetReplicaAddr(fmt.Sprintf("localhost:%s", port))
	})
}

// NewReplicaServer uses 'handler' to setup a new net.Listener for Replica
// on localhost over the next available TCP port.
//
// Returns an http.Server configured with a Replica http.Handler and a TCP
// listener bound to a random port
func NewReplicaServer(handler *replicaServer.HttpHandler) (net.Listener, *http.Server, error) {
	r := mux.NewRouter()
	r.PathPrefix("/replica").HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		http.StripPrefix("/replica", handler).ServeHTTP(w, r)
	})
	r.Handle("/", r)
	// Listen on a random TCP port
	l, err := net.Listen("tcp", "localhost:0")
	if err != nil {
		return nil, nil, log.Errorf("replica net.Listen: %v")
	}
	srv := &http.Server{
		Handler: r,
		// Serve over localhost, not for all interfaces, since we don't want
		// the device to broadcast a Replica server
		Addr:              "localhost:" + strconv.Itoa(l.Addr().(*net.TCPAddr).Port),
		ReadHeaderTimeout: 15 * time.Second,
	}
	return l, srv, nil
}

// newHandler constructs a replicaServer.HttpHandler.
func (s *ReplicaServer) newHandler() (*replicaServer.HttpHandler, error) {
	if s.Flashlight == nil {
		return nil, log.Errorf("Flashlight is nil")
	}
	if s.Session == nil {
		return nil, log.Errorf("Session is nil")
	}
	if s.UserConfig == nil {
		return nil, log.Errorf("UserConfig is nil")
	}

	log.Debugf("Starting replica with configDir [%v] and userConfig [%+v]\n", s.ConfigDir, s.UserConfig)
	optsFunc := func() *config.ReplicaOptions {
		var opts config.ReplicaOptions
		err := s.Flashlight.FeatureOptions(config.FeatureReplica, &opts)
		if err != nil {
			log.Errorf("Error on getting feature options, this should never happen in practice: %v", err)
			return nil
		}
		return &opts
	}

	input := replicaServer.NewHttpHandlerInput{}
	input.SetDefaults()
	// XXX <30-11-21, soltzen> Since this is mobile, disable seeding and makes
	// the dht node passive
	input.ReadOnlyNode = true
	input.RootUploadsDir = s.ConfigDir
	// XXX <16-12-21, soltzen> Those three flags make sure that uploads are not
	// saved to the torrent client, saved locally, or have any metadata
	// generated for them. This decision is only for android-lantern to protect
	// the privacy of uploaders
	input.AddUploadsToTorrentClient = false
	input.StoreUploadsLocally = false
	input.StoreMetainfoFileAndTokenLocally = false
	// TODO: should probably use Android's cache dir here since this stuff presumably is okay to delete
	input.CacheDir = s.ConfigDir
	input.AddCommonHeaders = func(r *http.Request) {
		common.AddCommonHeaders(s.UserConfig, r)
	}
	input.GlobalConfig = func() replicaServer.ReplicaOptions {
		return optsFunc()
	}
	input.ProxiedRoundTripper = proxied.ParallelForIdempotent()
	input.ProcessCORSHeaders = common.ProcessCORS
	input.InstrumentResponseWriter = func(w http.ResponseWriter,
		label string) replicaServer.InstrumentedResponseWriter {
		return ops.InitInstrumentedResponseWriter(w, label)
	}
	input.HttpClient = &http.Client{
		Transport: proxied.AsRoundTripper(
			func(req *http.Request) (*http.Response, error) {
				chained, err := proxied.ChainedNonPersistent("")
				if err != nil {
					return nil, log.Errorf("connecting to proxy: %w", err)
				}
				return chained.RoundTrip(req)
			},
		),
	}

	input.ReplicaServiceClient = replicaService.ServiceClient{
		HttpClient: input.HttpClient,
		ReplicaServiceEndpoint: func() *url.URL {
			// Fetch options
			opts := optsFunc()
			if opts == nil {
				log.Errorf("ReplicaOptions is not ready yet: triggering geolookup.Refresh() and using default endpoint: %v",
					replicaService.GlobalChinaDefaultServiceUrl)
				geolookup.Refresh()
				return replicaService.GlobalChinaDefaultServiceUrl
			}

			// Fetch country: if country wasn't fetch-able, use the default endpoint
			raw := opts.ReplicaRustDefaultEndpoint
			country, err := s.Session.GetCountryCode()
			if err != nil {
				log.Errorf("Failed to fetch country while configuring new replica-rust endpoint: re-running geolookup and defaulting to %q: %v", opts.ReplicaRustDefaultEndpoint, err)
				geolookup.Refresh()
			}
			if countryRaw := opts.ReplicaRustEndpoints[country]; countryRaw != "" {
				raw = countryRaw
			} else {
				log.Debugf("No custom replica endpoint for %v. Using default one: %v", country, raw)
			}

			// Parse endpoint
			url, err := url.Parse(raw)
			if err != nil {
				log.Errorf("Could not parse replica rust URL %v", err)
				return replicaService.GlobalChinaDefaultServiceUrl
			}
			log.Debugf("parsed new endpoint for country %s successfully: %v", country, url.String())
			return url
		},
	}
	input.GlobalConfig = func() replicaServer.ReplicaOptions {
		return optsFunc()
	}
	replicaHandler, err := replicaServer.NewHTTPHandler(input)
	if err != nil {
		return nil, log.Errorf("creating replica http server: %v", err)
	}
	return replicaHandler, nil
}
