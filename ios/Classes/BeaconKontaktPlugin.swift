import Flutter
import UIKit
import KontaktSDK


public class BeaconKontaktPlugin: NSObject, FlutterPlugin {
    
     var channel : FlutterMethodChannel? = nil
     var activityLocationEventChannel : FlutterEventChannel? = nil
     var permissionEventChannel : FlutterEventChannel? = nil
     var foregroundScanStatusEventChannel : FlutterEventChannel? = nil
     var foregroundScanIBeaconsUpdatedEventChannel : FlutterEventChannel? = nil
     var foregroundScanIBeaconDiscoveredEventChannel : FlutterEventChannel? = nil
     var foregroundScanIBeaconLostEventChannel : FlutterEventChannel? = nil
     var foregroundScanSecureProfilesUpdatedEventChannel : FlutterEventChannel? = nil
     var foregroundScanSecureProfileDiscoveredEventChannel : FlutterEventChannel? = nil
     var foregroundScanSecureProfileLostEventChannel : FlutterEventChannel? = nil
     
     var permissionService : PermissionService? = nil
     var activityService : ActivityService? = nil
     var foregroundScanService : ForegroundScanService? = nil
    
    var instance: BeaconKontaktPlugin? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BeaconKontaktPlugin()
        instance.instance = instance
        instance.permissionService = PermissionService()
        instance.activityService = ActivityService()
        instance.foregroundScanService = ForegroundScanService()
        
        
        instance.channel = FlutterMethodChannel(name: "beacon_kontakt", binaryMessenger: registrar.messenger())
        
        instance.activityLocationEventChannel = FlutterEventChannel(name: "beacon_kontakt_activity_location_event", binaryMessenger: registrar.messenger())
        
        instance.permissionEventChannel = FlutterEventChannel(name: "beacon_kontakt_permission_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanStatusEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_status_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanIBeaconsUpdatedEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_ibeacons_updated_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanIBeaconDiscoveredEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_ibeacon_discovered_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanIBeaconLostEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_ibeacon_lost_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanSecureProfilesUpdatedEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_secure_profiles_updated_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanSecureProfileDiscoveredEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_secure_profile_discovered_event", binaryMessenger: registrar.messenger())
        
        instance.foregroundScanSecureProfileLostEventChannel = FlutterEventChannel(name: "beacon_kontakt_foreground_scan_secure_profile_lost_event", binaryMessenger: registrar.messenger())
        
        instance.activityLocationEventChannel?.setStreamHandler(instance.activityService)
        instance.permissionEventChannel?.setStreamHandler(instance.permissionService)
        instance.foregroundScanStatusEventChannel?.setStreamHandler(instance.foregroundScanService)
        instance.foregroundScanIBeaconsUpdatedEventChannel?.setStreamHandler(instance.foregroundScanService)
        instance.foregroundScanIBeaconDiscoveredEventChannel?.setStreamHandler(instance.foregroundScanService)
        instance.foregroundScanIBeaconLostEventChannel?.setStreamHandler(instance.foregroundScanService)
        instance.foregroundScanSecureProfilesUpdatedEventChannel?.setStreamHandler(instance.foregroundScanService)
        instance.foregroundScanSecureProfileDiscoveredEventChannel?.setStreamHandler(instance.foregroundScanService)
        instance.foregroundScanSecureProfileLostEventChannel?.setStreamHandler(instance.foregroundScanService)
        
        
        
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let instance = BeaconKontaktPlugin()
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "initKontaktSDK":
            if let args = call.arguments as? [String: Any], let apiKey = args["apiKey"] as? String {
                Kontakt.setAPIKey(apiKey)
                result(nil)
            } else {
                result(FlutterError(code: "initKontaktSDK", message: "initKontaktSDK Invalid arguments", details: nil))
            }
        case "checkPermissions":
            result(instance!.permissionService!.checkPermission(onlyCheck: false))
        case "emitPermissionStatusString": //ios-only
            result(instance!.permissionService!.emitPermissionStatusString())
        case "startScanning":
            guard let args = call.arguments as? [String: Any],
                let scanPeriod = args["scanPeriod"] as? String,
                let listenerType = args["listenerType"] as? String,
                let minor = args["minor"] as? Int,
                let major = args["major"] as? Int,
                let proximityUUID = args["proximityUUID"] as? String
            else {
                result(FlutterError(code: "startScanning", message: "Invalid arguments", details: nil))
                return
            }
            print("SWIFT: Scan Period: \(scanPeriod)")
            print("SWIFT: Listener Type: \(listenerType)")
            print("SWIFT: Minor: \(minor) ")
            print("SWIFT: Major: \(major)")
            print("SWIFT: Proximity UUID: \(proximityUUID) ")
            do {
                try instance!.foregroundScanService!.startScanning(scanPeriod : scanPeriod, listenerType: listenerType, proximityUUID: proximityUUID, major: major, minor: minor)
                print("SWIFT: Scanning started -SWIFT")
                result(nil)
            } catch {
                print("SWIFT: Error starting scanning: \(error)")
                result(FlutterError(code: "startScanning", message: "Error starting scanning", details: "\(error)"))
            }
        case "stopScanning":
            do {
                try instance!.foregroundScanService!.stopScanning()
                print("SWIFT: Scanning stopped")
                result(nil)
            } catch {
                print("SWIFT: Error stopping scanning: \(error)")
                result(FlutterError(code: "stopScanning", message: "Error stopping scanning", details: "\(error)"))
            }
        
        case "emitBluetoothStatus":
            result(instance?.activityService?.emitBluetoothStatus()
)
        case "openLocationSettings":
            instance?.activityService?.openLocationSettings()
            result(nil)
        case "openBluetoothSettings":
            instance?.activityService?.openBluetoothSettings()
            result(nil)


            
        
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
}
