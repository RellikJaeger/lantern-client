package app

import (
	"github.com/getlantern/flashlight/v7/stats"

	"github.com/getlantern/lantern-client/desktop/ws"
)

type statsTracker struct {
	stats.Tracker
	service *ws.Service
}

func NewStatsTracker() *statsTracker {
	return &statsTracker{
		Tracker: stats.NewTracker(),
	}
}

func (s *statsTracker) StartService(channel ws.UIChannel) (err error) {
	helloFn := func(write func(interface{})) {
		log.Debugf("Sending Lantern stats to new client")
		write(s.Latest())
	}

	s.service, err = channel.Register("stats", helloFn)
	if err == nil {
		s.AddListener(func(newStats stats.Stats) {
			select {
			case s.service.Out <- newStats:
				// ok
			default:
				// don't block if no-one is listening
			}
		})
	}
	return
}
