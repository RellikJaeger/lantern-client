package org.getlantern.lantern.notification

import android.annotation.TargetApi
import android.app.Activity
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.ContextWrapper
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.view.View
import android.widget.RemoteViews
import org.getlantern.lantern.R
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class NotificationHelper(private val activity: Activity, private val receiver: NotificationReceiver) : ContextWrapper(activity) {

    // Used to notify a user of events that happen in the background
    private val manager: NotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
    private val builder: Notification.Builder
    //private val dropDown: DropDownNav
    private lateinit var dataUsageNotificationChannel: NotificationChannel
    private lateinit var vpnNotificationChannel: NotificationChannel

    @TargetApi(Build.VERSION_CODES.O)
    private fun initChannels() {
        dataUsageNotificationChannel = NotificationChannel(
            CHANNEL_DATA_USAGE,
            DATA_USAGE_DESC,
            NotificationManager.IMPORTANCE_HIGH,
        )
        vpnNotificationChannel = NotificationChannel(
            CHANNEL_VPN,
            VPN_DESC,
            NotificationManager.IMPORTANCE_HIGH,
        )
        val channels: Array<NotificationChannel> = arrayOf(
            dataUsageNotificationChannel,
            vpnNotificationChannel,
        )
        channels.forEach { setChannelOptions(it) }
    }

    private fun setChannelOptions(notificationChannel: NotificationChannel) {
        notificationChannel.enableLights(true)
        notificationChannel.lightColor = Color.GREEN
        notificationChannel.enableVibration(false)
        manager.createNotificationChannel(notificationChannel)
    }

    private fun disconnectBroadcast(): PendingIntent {
        val intent = Intent(activity, NotificationReceiver::class.java)
        val packageName = activity.packageName
        intent.action = "$packageName.intent.VPN_DISCONNECTED"
        // Retrieve a PendingIntent that will perform a broadcast
        return PendingIntent.getBroadcast(
            activity,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        )
    }

    private fun createContentView(): RemoteViews {
        var contentView: RemoteViews = RemoteViews(packageName, R.layout.notification)
        contentView.setImageViewResource(R.id.image, R.drawable.lantern_notification_icon)
        contentView.setTextViewText(R.id.title, baseContext.getText(R.string.service_connected))
        contentView.setOnClickPendingIntent(R.id.disconnect, disconnectBroadcast())
        contentView.setTextViewText(R.id.time, LocalDateTime.now().format(DateTimeFormatter.ofPattern("h:mm a")))
        return contentView
    }

    public fun vpnConnectedNotification() {
        builder.setChannelId(CHANNEL_VPN)
        manager.notify(1234, builder.build())
    }

    public fun dataUsageNotification() {
        builder.setChannelId(CHANNEL_DATA_USAGE)
        manager.notify(1234, builder.build())
    }



    fun clearNotification() {
        manager.cancelAll()
    }

    companion object {
        private val TAG = NotificationHelper::class.java.simpleName
        private const val LANTERN_NOTIFICATION = "lantern.notification"
        private const val DATA_USAGE = 36
        private const val VPN_CONNECTED = 37
        private const val VPN_DISCONNECTED = 38
        private const val CHANNEL_VPN = "vpn"
        private const val CHANNEL_DATA_USAGE = "data_usage"
        private const val VPN_DESC = "VPN"
        private const val DATA_USAGE_DESC = "Data Usage"
    }

    init {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            initChannels()
        }
        builder = Notification.Builder(this)
            .setContent(createContentView())
            .setSmallIcon(R.drawable.lantern_notification_icon)
            .setVisibility(Notification.VISIBILITY_PUBLIC)
    }
}