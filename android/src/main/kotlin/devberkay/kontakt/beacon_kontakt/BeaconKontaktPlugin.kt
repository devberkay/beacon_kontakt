package devberkay.kontakt.beacon_kontakt



import android.app.Activity
import android.content.Context
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
    private lateinit var permissionEventChannel : EventChannel
    private lateinit var applicationContext : Context
    private lateinit var activity : Activity
    private var kontaktSDK : KontaktSDK? = null
    private lateinit var permissionService : PermissionService
    private lateinit var foregroundScanService : ForegroundScanService
    private lateinit var foregroundScanEventChannel : EventChannel
    private var apiKey : String? = null
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      channel = MethodChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt")
      permissionEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_permission_event")
      foregroundScanEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_event")
      channel.setMethodCallHandler(this)
      applicationContext = flutterPluginBinding.applicationContext
    }

      override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        else if(call.method == "initKontaktSDK") {
          apiKey = call.argument("apiKey") as String?
          kontaktSDK = KontaktSDK.initialize(apiKey)
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
          var scanPeriod = call.argument("scanPeriod") as String? // Monitoring or Ranging
          var listenerType = call.argument("listenerType") as String? // iBeacon or SecureProfile
          var scanPeriodObj = if(scanPeriod=="Monitoring") ScanPeriod.MONITORING else ScanPeriod.RANGING
          var minor = call.argument("minor") as Int?
          var major = call.argument("major") as Int?
          var proximityUUID = call.argument("proximityUUID") as String?
         if (kontaktSDK!=null) {
           foregroundScanService = ForegroundScanService(applicationContext,apiKey!!,scanPeriodObj,listenerType!!,proximityUUID!!,major,minor)
           foregroundScanService.startScanning()
         }
          else {
           result.error("SDK_NOT_INITIALIZED", "SDK is not initialized", null)
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
        else {
          result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

    override fun onDetachedFromActivity() {
      TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
      TODO("Not yet implemented")
    }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    permissionService = PermissionService(activity,applicationContext)
    permissionEventChannel.setStreamHandler(PermissionStreamHandler(binding,permissionService))
    foregroundScanEventChannel.setStreamHandler(foregroundScanService)
  }


  override fun onDetachedFromActivityForConfigChanges() {
      TODO("Not yet implemented")
    }








}
