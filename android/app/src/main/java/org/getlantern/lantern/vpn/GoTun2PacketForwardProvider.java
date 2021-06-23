package org.getlantern.lantern.vpn;

import android.app.PendingIntent;
import android.content.Intent;
import android.net.VpnService;
import android.os.ParcelFileDescriptor;

import internalsdk.Internalsdk; // Lantern's go android package

import org.getlantern.lantern.MainActivity;
import org.getlantern.mobilesdk.Logger;

import java.util.Locale;

public class GoTun2PacketForwardProvider implements Provider {
  private static final String TAG = "GoTun2PacketForwardProvider";

  private final static String sessionName = "LanternVpn";

  private final static String privateAddress = "10.0.0.2";
  private final static String gwAddress = "10.0.0.1";
  private final static String dnsIP = "8.8.8.8";
  private final static String dnsAddr = dnsIP + ":53";

  private final static int VPN_MTU = 1500;

  private ParcelFileDescriptor mInterface;

  private synchronized ParcelFileDescriptor createBuilder(final VpnService vpnService,
      final VpnService.Builder builder) {
    // Set the locale to English
    // since the VpnBuilder encounters
    // issues with non-English numerals
    // See https://code.google.com/p/android/issues/detail?id=61096
    Locale.setDefault(new Locale("en"));

    // Configure a builder while parsing the parameters.
    builder.setMtu(VPN_MTU);

    builder.addAddress(privateAddress, 24);
    builder.addRoute("0.0.0.0", 0);
    builder.addDnsServer(dnsIP);

    Intent intent = new Intent(vpnService, MainActivity.class);
    PendingIntent pendingIntent = PendingIntent.getActivity(vpnService, 0, intent, 0);
    builder.setConfigureIntent(pendingIntent);

    builder.setSession(sessionName);

    // Create a new mInterface using the builder and save the parameters.
    mInterface = builder.establish();
    Logger.d(TAG, "New mInterface: " + mInterface);
    return mInterface;
  }

  public void run(final VpnService vpnService, final VpnService.Builder builder, final String socksAddr, final String dnsGrabAddr)
      throws Exception {
    Logger.d(TAG, "run");

    if (socksAddr == null || socksAddr.length() == 0) {
      throw new RuntimeException("No SocksAddr!");
    }

    final Locale defaultLocale = Locale.getDefault();
    try {
      ParcelFileDescriptor intf = createBuilder(vpnService, builder);
      Internalsdk.tun2PacketForward((long) intf.getFd(), (long) VPN_MTU);
    } catch (Throwable t) {
      Logger.e(TAG, "Exception while handling TUN device", t);
    } finally {
      Locale.setDefault(defaultLocale);
    }
  }

  public synchronized void stop() throws Exception {
    Logger.d(TAG, "stop");
    Internalsdk.stopTun2PacketForward();
    if (mInterface != null) {
      Logger.d(TAG, "closing interface");
      mInterface.close();
      mInterface = null;
    }
  }
}
