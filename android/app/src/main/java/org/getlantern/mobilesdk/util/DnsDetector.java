package org.getlantern.mobilesdk.util;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.Network;
import android.net.NetworkInfo;

import org.getlantern.mobilesdk.Logger;

import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

import static android.content.Context.CONNECTIVITY_SERVICE;

/**
 * Provides a facility for detecting the current DNS server.
 * <p>
 * Based on work by Madalin Grigore-Enescu on 2/24/18.
 */

public class DnsDetector {

    private static final String TAG = "DnsServersDetector";
    private static final String DEFAULT_DNS_SERVER = "8.8.8.8";
    private static final int[] NETWORK_PRIORITY = new int[]{
            ConnectivityManager.TYPE_ETHERNET,
            ConnectivityManager.TYPE_WIFI,
            ConnectivityManager.TYPE_MOBILE
    };

    private final String fakeDnsIP;
    private final ConnectivityManager connectivityManager;

    /**
     * Constructor
     */
    public DnsDetector(Context context, String fakeDnsIP) {
        this.fakeDnsIP = fakeDnsIP;
        connectivityManager = (ConnectivityManager) context.getSystemService(CONNECTIVITY_SERVICE);
    }

    public String getDnsServer() {
        String dnsServer = doGetDnsServer();
        Logger.debug(TAG, "Using DNS server " + dnsServer);
        return dnsServer;
    }

    private String doGetDnsServer() {
        Network network = findActiveNetwork();
        if (network == null) {
            return DEFAULT_DNS_SERVER;
        }

        LinkProperties linkProperties = connectivityManager.getLinkProperties(network);
        for (InetAddress address : linkProperties.getDnsServers()) {
            String ip = address.getHostAddress();
            if (!fakeDnsIP.equals(ip)) {
                try {
                    if (address instanceof Inet6Address) {
                        Inet6Address ipv6Address = (Inet6Address) address;
                        if (ipv6Address.isLinkLocalAddress()) {
                            // For IPv6, the DNS server address can be a link-local address.
                            // For Go to know how to route this, it needs to know the zone
                            // (interface ID). In some cases, that's missing, in other cases it's a
                            // name rather than an interface ID (which our Go code can't handle).
                            // This fixes that.
                            NetworkInterface intf = NetworkInterface.getByInetAddress(
                                    linkProperties.getLinkAddresses().get(0).getAddress());
                            ip = ip.split("%")[0] + "%" + intf.getIndex();
                        }
                    }
                    return ip;
                } catch (SocketException se) {
                    Logger.debug(TAG, "Unable to get NetworkInterface", se);
                }
            }
        }

        return DEFAULT_DNS_SERVER;
    }

    private Network findActiveNetwork() {
        Network[] networks = connectivityManager.getAllNetworks();
        List<NetworkInfo> networkInfos = new ArrayList<>();
        for (Network network : networks) {
            networkInfos.add(connectivityManager.getNetworkInfo(network));
        }

        // search order goes ETHERNET -> WIFI -> MOBILE
        for (int type : NETWORK_PRIORITY) {
            Network activeNetwork = availableNetworkOfType(
                    networks,
                    networkInfos,
                    type);
            if (activeNetwork != null) {
                return activeNetwork;
            }
        }

        return null;
    }

    private Network availableNetworkOfType(Network[] networks, List<NetworkInfo> networkInfos, int type) {
        for (int i = 0; i < networkInfos.size(); i++) {
            NetworkInfo info = networkInfos.get(i);
            if (info.isAvailable() && info.getType() == type) {
                return networks[i];
            }
        }
        return null;
    }
}