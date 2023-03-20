package devberkay.kontakt.beacon_kontakt



import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
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

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      channel = MethodChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt")
      permissionEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_permission_event")
      foregroundScanEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt_foreground_scan_event")
      channel.setMethodCallHandler(this)
      applicationContext = flutterPluginBinding.applicationContext
      foregroundScanService = ForegroundScanService(applicationContext)
      permissionService = PermissionService(activity,applicationContext)
    }

      override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        else if(call.method == "initKontaktSDK") {
          kontaktSDK = KontaktSDK.initialize(call.argument("apiKey") as String?)
          result.success(null)
        }
        else if(call.method == "checkPermissions") {
          if(kontaktSDK!=null) {
            permissionService.checkPermissions()
          }
          else {
            result.error("SDK_NOT_INITIALIZED", "SDK is not initialized", null)
          }
        }
        else if(call.method == "startScanning") {
         if (kontaktSDK!=null) {
           result.success(foregroundScanService.startScanning())
         }
          else {
           result.error("SDK_NOT_INITIALIZED", "SDK is not initialized", null)
         }
        }
        else if(call.method == "stopScanning") {
          if(kontaktSDK!=null) {
            result.success(foregroundScanService.stopScanning())
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
    permissionEventChannel.setStreamHandler(PermissionStreamHandler(binding))
    foregroundScanEventChannel.setStreamHandler(foregroundScanService)
  }


  override fun onDetachedFromActivityForConfigChanges() {
      TODO("Not yet implemented")
    }








}
