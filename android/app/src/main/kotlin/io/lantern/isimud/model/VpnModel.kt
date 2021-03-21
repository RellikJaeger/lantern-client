package io.lantern.isimud.model

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class VpnModel(
    flutterEngine: FlutterEngine? = null,
    private var switchLanternHandler: ((vpnOn: Boolean) -> Unit)? = null,
) : Model("vpn", flutterEngine) {

    companion object {
        const val PATH_VPN_STATUS = "/vpn_status"
        const val PATH_SERVER_INFO = "/server_info"
        const val PATH_BANDWIDTH = "/bandwidth"
    }

    init {
        observableModel.mutate { tx ->
            // initialize vpn status for fresh install
            tx.put(
                namespacedPath(PATH_VPN_STATUS),
                tx.get<String>(namespacedPath(PATH_VPN_STATUS)) ?: "disconnected"
            )
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "switchVPN" -> {
                val on = call.argument<Boolean>("on") ?: false
                saveVpnStatus(if (on) "connecting" else "disconnecting")
                switchLantern(on)
            }
            else -> super.onMethodCall(call, result)
        }
    }

    fun isConnectedToVpn(): Boolean {
        val vpnStatus = vpnStatus()
        return vpnStatus == "connected" || vpnStatus == "disconnecting"
    }

    private fun vpnStatus(): String {
        return observableModel.get(namespacedPath(PATH_VPN_STATUS)) ?: ""
    }

    private fun switchLantern(value: Boolean) {
        switchLanternHandler?.invoke(value)
    }

    fun setVpnOn(vpnOn: Boolean) {
        val vpnStatus = if (vpnOn) "connected" else "disconnected"
        saveVpnStatus(vpnStatus)
    }

    fun saveVpnStatus(vpnStatus: String) {
        observableModel.mutate { tx ->
            tx.put(namespacedPath(PATH_VPN_STATUS), vpnStatus)
        }
    }

    fun saveServerInfo(serverInfo: Vpn.ServerInfo) {
        observableModel.mutate { tx ->
            tx.put(namespacedPath(PATH_SERVER_INFO), serverInfo)
        }
    }

    fun saveBandwidth(bandwidth: Vpn.Bandwidth) {
        observableModel.mutate { tx ->
            tx.put(namespacedPath(PATH_BANDWIDTH), bandwidth)
        }
    }
}