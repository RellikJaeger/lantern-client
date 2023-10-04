//  VpnModel.swift
//  Runner
//  Created by jigar fumakiya on 01/09/23.

import DBModule
import Flutter
import Foundation
import Internalsdk

class VpnModel: BaseModel, InternalsdkVPNManagerProtocol {
  let vpnManager: VPNBase
  let vpnHelper = VpnHelper.shared

  init(flutterBinary: FlutterBinaryMessenger, vpnBase: VPNBase) throws {
    logger.log("Initializing VPNModel")
    self.vpnManager = vpnBase
    var error: NSError?
    guard let model = InternalsdkNewVPNModel(try BaseModel.getDB(), &error) else {
      throw error!
    }
    try super.init(flutterBinary, model)
    model.setManager(self)
  }

  private func saveVPNStatus(status: String) {
    do {
      let result = try invoke("saveVpnStatus", status)
      logger.log("Sucessfully set VPN status with  \(status)")
    } catch {
      logger.log("Error while setting VPN status")
    }
  }

  func startVPN() {
    self.saveVPNStatus(status: "connected")
    vpnHelper.startVPN(
      onError: { error in
        // in case of error, reset switch position
        self.saveVPNStatus(status: "disconnected")
        logger.debug("VPN not started \(error)")
      },
      onSuccess: {
        logger.debug("VPN started")
        self.saveVPNStatus(status: "connected")
      })
  }

  func stopVPN() {
    vpnHelper.stopVPN()
    logger.debug("VPN Successfully stoped")
    self.saveVPNStatus(status: "disconnected")
  }

}