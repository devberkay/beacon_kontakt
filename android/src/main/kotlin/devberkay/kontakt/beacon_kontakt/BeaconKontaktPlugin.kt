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
import io.flutter.plugin.common.StandardMethodCodec


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

    private lateinit var foregroundScanService : ForegroundScanService
    private lateinit var foregroundScanStatusEventChannel : EventChannel
    private lateinit var foregroundScanIBeaconsUpdatedEventChannel : EventChannel
    private lateinit var foregroundScanIBeaconDiscoveredEventChannel : EventChannel
    private lateinit var foregroundScanIBeaconLostEventChannel : EventChannel
    private lateinit var foregroundScanSecureProfilesUpdatedEventChannel : EventChannel
    private lateinit var foregroundScanSecureProfileDiscoveredEventChannel : EventChannel
    private lateinit var foregroundScanSecureProfileLostEventChannel : EventChannel

    private var apiKey : String? = null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      Log.d("KontaktSDK", "onAttachedToEngine started")

      channel = MethodChannel(flutterPluginBinding.binaryMessenger,
        "beacon_kontakt")
      channel.setMethodCallHandler(this)

      foregroundScanStatusEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_status_event")
      foregroundScanIBeaconsUpdatedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_ibeacons_updated_event")
      foregroundScanIBeaconDiscoveredEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_ibeacon_discovered_event")
      foregroundScanIBeaconLostEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_ibeacon_lost_event")
      foregroundScanSecureProfilesUpdatedEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_secure_profiles_updated_event")
      foregroundScanSecureProfileDiscoveredEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_secure_profile_discovered_event")
      foregroundScanSecureProfileLostEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_secure_profile_lost_event")


      applicationContext = flutterPluginBinding.applicationContext


      Log.d("KontaktSDK", "onAttachedToEngine complete")
    }



      override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        try {
          Log.d("KontaktSDK", "onMethodCall ${call.method}")
          if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
          }
          else if(call.method == "initKontaktSDK") {
            apiKey = call.argument("apiKey") as String?
            Log.d("KontaktSDK","methodCall: initKontaktSDK, apiKey: $apiKey")
            kontaktSDK = KontaktSDK.initialize(apiKey!!)
            var kontaktValid = kontaktSDK != null
            Log.d("KontaktSDK", "initialized: $kontaktValid")
            foregroundScanService = ForegroundScanService(applicationContext,apiKey!!)
            foregroundScanStatusEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanIBeaconsUpdatedEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanIBeaconDiscoveredEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanIBeaconLostEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanSecureProfilesUpdatedEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanSecureProfileDiscoveredEventChannel.setStreamHandler(foregroundScanService)
            foregroundScanSecureProfileLostEventChannel.setStreamHandler(foregroundScanService)
            Log.d("KontaktSDK", "initialization - set stream handlers")
            result.success(null)
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
              foregroundScanService.startScanning(scanPeriodObj, proximityUUID, major,minor,result)
            }
            else {
              result.error("KONTAKT_SDK_NOT_INITIALIZED", "Kontakt SDK is not initialized", null)
            }
          }
          else if(call.method == "stopScanning") {
            if(kontaktSDK!=null) {
              foregroundScanService.stopScanning(result)

            }
            else {
              result.error("SDK_NOT_INITIALIZED", "SDK is not initialized", null)
            }
          }
          else if(call.method == "restartScanning") {
            foregroundScanService.restartScanning(result)

          }
          else if(call.method == "isScanning") {
            val currentStatus = foregroundScanService.isScanning
            Log.d("KontaktSDK", "Current Scanning Status: $currentStatus")
            result.success(currentStatus)
          }
          else {
            result.notImplemented()
          }
        } catch (e: Exception) {
          result.error("PluginGeneralException", e.message, e.stackTrace)
        }
  }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

    override fun onDetachedFromActivity() {
      Log.d("AndroidLifecycle","onDetachedFromActivity-AndroidLifecycle")
      Log.d("KontaktSDK", "onDetachedFromActivity started")
      channel.setMethodCallHandler(null)
      foregroundScanStatusEventChannel.setStreamHandler(null)
      foregroundScanIBeaconDiscoveredEventChannel.setStreamHandler(null)
      foregroundScanIBeaconsUpdatedEventChannel.setStreamHandler(null)
      foregroundScanIBeaconLostEventChannel.setStreamHandler(null)
      foregroundScanSecureProfileDiscoveredEventChannel.setStreamHandler(null)
      foregroundScanSecureProfilesUpdatedEventChannel.setStreamHandler(null)
      foregroundScanSecureProfileLostEventChannel.setStreamHandler(null)
      Log.d("KontaktSDK", "onDetachedFromActivity started")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
      Log.d("AndroidLifecycle","onReattachedToActivityForConfigChanges-AndroidLifecycle")

    }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("AndroidLifecycle","onAttachedToActivity-AndroidLifecycle")
    activity = binding.activity
  }


  override fun onDetachedFromActivityForConfigChanges() {
    Log.d("AndroidLifecycle","onDetachedFromActivityForConfigChanges-AndroidLifecycle")
      // TODO("Not yet implemented")
    }

}
