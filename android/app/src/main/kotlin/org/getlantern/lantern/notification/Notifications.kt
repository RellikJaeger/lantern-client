package org.getlantern.lantern.notification

import android.annotation.TargetApi
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import org.getlantern.lantern.Actions
import org.getlantern.lantern.LanternApp
import org.getlantern.lantern.MainActivity
import org.getlantern.lantern.R

class Notifications() {
    companion object {
        private val TAG = Notifications::class.java.simpleName
        const val notificationId = 1
        private const val CHANNEL_VPN = "service-vpn"

        init {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                initChannels()
            }
        }

        val builder: (Service) -> NotificationCompat.Builder by lazy {
            {
                val context = it as Context
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    0,
                    Intent(context, MainActivity::class.java),
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                )
                NotificationCompat.Builder(it as Context, CHANNEL_VPN)
                    .setContentTitle(context.getString(R.string.service_connected))
                    .setContentIntent(pendingIntent)
                    .addAction(
                        android.R.drawable.ic_delete,
                        context.getString(R.string.disconnect),
                        PendingIntent.getBroadcast(
                            context,
                            0,
                            Intent(Actions.DISCONNECT_VPN).setPackage(it.packageName),
                            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                        ),
                    )
                    .setOngoing(true)
                    .setShowWhen(true)
                    .setSmallIcon(R.drawable.lantern_notification_icon)
                    .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            }
        }

        @TargetApi(Build.VERSION_CODES.O)
        private fun initChannels() {
            LanternApp.notificationManager.createNotificationChannel(
                NotificationChannel(
                    CHANNEL_VPN,
                    LanternApp.getAppContext().resources.getString(R.string.lantern_service),
                    NotificationManager.IMPORTANCE_HIGH,
                ),
            )
        }
    }
}
