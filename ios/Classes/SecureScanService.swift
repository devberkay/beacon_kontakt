//
//  SecureScanService.swift
//  beacon_kontakt
//
//  Created by Berkay Can on 6/14/23.
//

import Foundation
import Flutter
import KontaktSDK


// This scan service relies on Core Bluetooth and uses Kontakt Secure packages.

class SecureScanService: NSObject,FlutterStreamHandler,KTKDevicesManagerDelegate {
    
//    private var secureProfileDiscoveredEventSink : FlutterEventSink? = nil
    private var secureProfilesUpdatedEventSink : FlutterEventSink? = nil
//    private var secureProfileLostEvenSink : FlutterEventSink? = nil
    
    
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
      
    }
    
    func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]) {
       
    }
    
    
}
