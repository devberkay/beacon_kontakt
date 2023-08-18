package devberkay.kontakt.beacon_kontakt



import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.kontakt.sdk.android.ble.configuration.ScanPeriod
import com.kontakt.sdk.android.common.KontaktSDK
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** BeaconKontaktPlugin */
  class BeaconKontaktPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel
    private lateinit var applicationContext : Context
    private lateinit var activity : Activity
    private var kontaktSDK : KontaktSDK? = null
    private lateinit var permissionService : PermissionService
    private lateinit var foregroundScanService : ForegroundScanService
    private lateinit var permissionEventChannel : EventChannel
    private lateinit var foregroundScanStatusEventChannel : EventChannel
    private lateinit var foregroundScanIBeaconsUpdatedEventChannel : EventChannel
    private lateinit var foregroundScanIBeaconDiscoveredEventChannel : EventChannel
    private lateinit var foregroundScanIBeaconLostEventChannel : EventChannel
    private lateinit var foregroundScanSecureProfilesUpdatedEventChannel : EventChannel
    private lateinit var foregroundScanSecureProfileDiscoveredEventChannel : EventChannel
    private lateinit var foregroundScanSecureProfileLostEventChannel : EventChannel
    private lateinit var activityService: ActivityService
    private var apiKey : String? = null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      channel = MethodChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt")
      permissionEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_permission_event")
      foregroundScanStatusEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_status_event")
      foregroundScanIBeaconsUpdatedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_ibeacons_updated_event")
      foregroundScanIBeaconDiscoveredEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_ibeacon_discovered_event")
      foregroundScanIBeaconLostEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_ibeacon_lost_event")
      foregroundScanSecureProfilesUpdatedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_secure_profiles_updated_event")
      foregroundScanSecureProfileDiscoveredEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_secure_profile_discovered_event")
      foregroundScanSecureProfileLostEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_secure_profile_lost_event")
      channel.setMethodCallHandler(this)
      applicationContext = flutterPluginBinding.applicationContext
      activityService = ActivityService(flutterPluginBinding.applicationContext)
    }

      override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        else if(call.method == "initKontaktSDK") {
            apiKey = call.argument("apiKey") as String?
            kontaktSDK = KontaktSDK.initialize(apiKey!!)
            foregroundScanService = ForegroundScanService(applicationContext,apiKey!!)
            foregroundScanStatusEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanIBeaconsUpdatedEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanIBeaconDiscoveredEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanIBeaconLostEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanSecureProfilesUpdatedEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanSecureProfileDiscoveredEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanSecureProfileLostEventChannel.setStreamHandler(foregroundScanService)
          result.success(null)
        }
        else if(call.method == "checkPermissions") {
          if(kontaktSDK!=null) {
            permissionService.checkPermissions(false)
          }
          else {
            result.error("SDK_NOT_INITIALIZED", "SDK is not initialized", null)
          }
        }
        else if(call.method == "startScanning") {

          val scanPeriod = call.argument("scanPeriod") as String? // Monitoring or Ranging
          Log.d("KontaktSDK", "Scan Period: $scanPeriod")

          val scanPeriodObj = if(scanPeriod=="Monitoring") ScanPeriod.MONITORING else ScanPeriod.RANGING

          val minor = call.argument("minor") as Int?
          Log.d("KontaktSDK", "Minor: $minor")
          val major = call.argument("major") as Int?
          Log.d("KontaktSDK", "Major: $major")
          val proximityUUID = call.argument("proximityUUID") as String?
          Log.d("KontaktSDK", "Proximity UUID: $proximityUUID")
         if (kontaktSDK!=null) {
             foregroundScanService.startScanning(scanPeriodObj, proximityUUID, major,minor)
             Log.d("KontaktSDK", "Scanning started")
         }
          else {
           result.error("KONTAKT_SDK_NOT_INITIALIZED", "Kontakt SDK is not initialized", null)
         }
        }
        else if(call.method == "stopScanning") {
          if(kontaktSDK!=null) {
            foregroundScanService.stopScanning()

          }
          else {
            result.error("SDK_NOT_INITIALIZED", "SDK is not initialized", null)
          }
        }
        else if(call.method == "restartScanning") {
          result.success(foregroundScanService.restartScanning())
        }
        else if(call.method == "isScanning") {
          val currentStatus = foregroundScanService.isScanning
          Log.d("KontaktSDK", "Current Scanning Status: $currentStatus")
          result.success(currentStatus)
        }
        else if(call.method == "emitLocationStatus") {
          result.success(activityService.emitLocationStatus())
        }
        else if(call.method=="emitBluetoothStatus") {
          result.success(activityService.emitBluetoothStatus())
        }
        else if (call.method == "openBluetoothSettings") {
          result.success(activityService.openBluetoothSettings())
        }
        else if(call.method == "openLocationSettings") {
          result.success(activityService.openLocationSettings())
        }


        else {
          result.notImplemented()
    }
  }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
      channel.setMethodCallHandler(null)
      permissionEventChannel.setStreamHandler(null)
      foregroundScanStatusEventChannel.setStreamHandler(null)
      foregroundScanIBeaconDiscoveredEventChannel.setStreamHandler(null)
      foregroundScanIBeaconsUpdatedEventChannel.setStreamHandler(null)
      foregroundScanIBeaconLostEventChannel.setStreamHandler(null)
      foregroundScanSecureProfileDiscoveredEventChannel.setStreamHandler(null)
      foregroundScanSecureProfilesUpdatedEventChannel.setStreamHandler(null)
      foregroundScanSecureProfileLostEventChannel.setStreamHandler(null)
  }

    override fun onDetachedFromActivity() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    permissionService = PermissionService(activity,binding,applicationContext)
    permissionEventChannel.setStreamHandler(permissionService)
  }


  override fun onDetachedFromActivityForConfigChanges() {
      TODO("Not yet implemented")
    }

}
