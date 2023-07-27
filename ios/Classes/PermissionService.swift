import Flutter
import CoreLocation
import KontaktSDK
class PermissionService: NSObject, FlutterStreamHandler, KTKBeaconManagerDelegate  {
    
    private var eventSink: FlutterEventSink? = nil
    private var beaconManager : KTKBeaconManager? = nil
    
    override init() {
        super.init()
        beaconManager = KTKBeaconManager(delegate: self)
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        print("We are in didChangeLocationAuthStatus")
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                eventSink?(true)
            case .notDetermined, .restricted, .denied:
                eventSink?(false)
            default:
                eventSink?(false)
            }

    }
    

   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
       print("We are in locationManagerDidChangeAuthorization")
       if #available(iOS 14.0, *) {
           switch manager.authorizationStatus {
           case .authorizedAlways, .authorizedWhenInUse:
               eventSink?(true)
           case .notDetermined, .restricted, .denied:
               eventSink?(true)
           default:
               eventSink?(true)
           }
       } else {
           // Fallback on earlier versions
       }
   }
    
    
    func checkPermission(onlyCheck : Bool) -> Bool {
       
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .authorizedAlways:
            
            return true
        case .authorizedWhenInUse:
            beaconManager?.requestLocationAlwaysAuthorization()
            return true
        case .notDetermined:
            beaconManager?.requestLocationAlwaysAuthorization()
            return false
        case .restricted:
            beaconManager?.requestLocationAlwaysAuthorization()
            return false
        case .denied:
            beaconManager?.requestLocationAlwaysAuthorization()
            return false
            
        default:
            return false
        }
    }
    
    func emitPermissionStatusString() -> String { //ios-only
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        default:
            return "unknown"
           
        }
    }
    
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        let isGranted = checkPermission(onlyCheck: true)
        eventSink!(isGranted)
        return nil
    }
    
    
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink=nil
        return nil
    }
    
    }

