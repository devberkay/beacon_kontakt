import Flutter
import KontaktSDK

class ActivityService: NSObject,FlutterStreamHandler, CLLocationManagerDelegate, CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    
    private var locationEventSink: FlutterEventSink? = nil
    
    private var centralManager: CBCentralManager!
    private let locationManager = CLLocationManager()
    private var authorizationStatus: CLAuthorizationStatus?
    private var completion: ((Bool) -> Void)?

    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard authorizationStatus != CLLocationManager.authorizationStatus() else { return }
        authorizationStatus = CLLocationManager.authorizationStatus()
        let locationEnabled = CLLocationManager.locationServicesEnabled()
        let authorizationValid = (authorizationStatus == .authorizedAlways) || (authorizationStatus == .authorizedWhenInUse)
        locationEventSink?(locationEnabled && authorizationValid)
        if let completion = completion {
            completion(locationEnabled && authorizationValid)
        }
    }

    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        locationEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationEventSink=nil
        return nil
    }
    
    
    
    
    private var beaconManager : KTKBeaconManager? = KTKBeaconManager()
    
    
    
//
//    func emitLocationStatus() -> Bool {
//        return CLLocationManager.locationServicesEnabled() && ((CLLocationManager.authorizationStatus() == .authorizedAlways) || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse))
//    }
    
    func emitBluetoothStatus() -> Bool {
        return centralManager.state == .poweredOn
    }
    
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        <#code#>
//    }
    
    
    
    
    func openLocationSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

//    func openBluetoothSettings() {
//        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//}

    
    func openBluetoothSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
}
