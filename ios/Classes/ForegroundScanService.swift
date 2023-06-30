import Flutter
import KontaktSDK


 class ForegroundScanService: NSObject,FlutterStreamHandler,KTKBeaconManagerDelegate {
    
    
    private var statusEventSink: FlutterEventSink? = nil
    private var iBeaconDiscoveredEventSink : FlutterEventSink? = nil
    private var iBeaconsUpdatedEventSink : FlutterEventSink? = nil
    private var iBeaconLostEventSink : FlutterEventSink? = nil
    private var beaconManager: KTKBeaconManager!
    
    
     override init() {
        super.init()
        self.beaconManager = KTKBeaconManager(delegate: self)
    }
     
     
    
    
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        statusEventSink?(true)
    }

    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        statusEventSink?(true)
        iBeaconsUpdatedEventSink?(beacons.map { beacon in
            if #available(iOS 13.0, *) {
               return  [
                    "timestamp": Int(beacon.timestamp.timeIntervalSince1970 * 1000.0),
                    "rssi": beacon.rssi,
                    "proximityUUID": beacon.ktk_proximityUUID.uuidString,
                    "minor": beacon.minor,
                    "major": beacon.major,
                    "txPower": nil,
                    "batteryLevel": nil,
                    "name" : nil,
                    "uniqueID" : nil
               ] as [String : Any?]
            } else {
               return  [
                    "timestamp": nil,
                    "rssi": beacon.rssi,
                    "proximityUUID": beacon.ktk_proximityUUID.uuidString,
                    "minor": beacon.minor,
                    "major": beacon.major,
                    "txPower": nil,
                    "batteryLevel": nil,
                    "name" : nil,
                    "uniqueID" : nil
                ]
            }
            })
    }
    
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        statusEventSink?(true)
        iBeaconLostEventSink?( [
            "proximityUUID" : region.proximityUUID.uuidString,
                "major":region.major,
                "minor": region.minor,
                "uniqueID" : region.identifier,
                "rssi" : nil,
                "txPower": nil,
                "batteryLevel": nil,
                "name": nil,
                "timestamp": nil
        ] as [String : Any?])
    }
    
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        statusEventSink?(true)
        iBeaconDiscoveredEventSink?([
            "proximityUUID" : region.proximityUUID.uuidString,
            "major":region.major,
            "minor": region.minor,
            "uniqueID" : region.identifier,
            "rssi" : nil,
            "txPower": nil,
            "batteryLevel": nil,
            "name": nil,
            "timestamp": nil
        ] as [String : Any?])
    }
    
    
    func beaconManager(_ manager: KTKBeaconManager, rangingBeaconsDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        print("Ranging beacons failed with error: \(error?.localizedDescription ?? "unknown error")")
    }
    
    
    func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        print("Monitoring failed with error: \(error?.localizedDescription ?? "unknown error")")
    }
       
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        guard let argument = arguments as? String else {
            return FlutterError(code: "invalid_argument", message: "Invalid argument type", details: nil)
        }
        
        switch argument {
        case "statusEventSink":
            statusEventSink = events
            statusEventSink?(false)
        case "iBeaconDiscoveredEventSink":
            iBeaconDiscoveredEventSink = events
        case "iBeaconsUpdatedEventSink":
            iBeaconsUpdatedEventSink = events
        case "iBeaconLostEventSink":
            iBeaconLostEventSink = events
//        case "secureProfileDiscoveredEventSink":
//            secureProfileDiscoveredEventSink = events
//        case "secureProfilesUpdatedEventSink":
//            secureProfilesUpdatedEventSink = events
//        case "secureProfileLostEvenSink":
//            secureProfileLostEvenSink = events
        default:
            return FlutterError(code: "unknown_channel", message: "Unknown event channel", details: argument)
        }
        
        return nil
    }
    
    
    func startScanning(scanPeriod: String?, listenerType: String?, proximityUUID: String?, major: Int?, minor: Int?) {
        
        var scanningRegion : KTKBeaconRegion
        if(major! < 0 || minor! < 0) {
            scanningRegion = KTKBeaconRegion.init(proximityUUID: UUID.init(uuidString: proximityUUID!)!, identifier:"")
        }
        else {
            scanningRegion =   KTKBeaconRegion(proximityUUID: UUID(uuidString: proximityUUID!)!, major: CLBeaconMajorValue(major!), minor: CLBeaconMinorValue(minor!),identifier: "")
        }
        if(scanPeriod == "Ranging") {
            beaconManager.startRangingBeacons(in: scanningRegion) // foreground
        }
        else {
            beaconManager.startMonitoring(for: scanningRegion) // background
        }
    
    }
    
    
    
    func stopScanning() {
        beaconManager.stopRangingBeaconsInAllRegions()
        beaconManager.stopMonitoringForAllRegions()
    }
    
    
    

    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        
        guard let argument = arguments as? String? else {
            return FlutterError(code: "invalid_argument", message: "Invalid argument type", details: nil)
        }
        
        switch argument {
        case "statusEventSink":
            statusEventSink = nil
        case "iBeaconDiscoveredEventSink":
            iBeaconDiscoveredEventSink = nil
        case "iBeaconsUpdatedEventSink":
            iBeaconsUpdatedEventSink = nil
        case "iBeaconLostEventSink":
            iBeaconLostEventSink = nil
//        case "secureProfileDiscoveredEventSink":
//            secureProfileDiscoveredEventSink = nil
//        case "secureProfilesUpdatedEventSink":
//            secureProfilesUpdatedEventSink = nil
//        case "secureProfileLostEvenSink":
//            secureProfileLostEvenSink = nil
        case nil :
            return nil
        default:
            return FlutterError(code: "unknown_channel", message: "Unknown event channel", details: argument)
        }
        
        return nil
        
    }
    
    
   
    
}
