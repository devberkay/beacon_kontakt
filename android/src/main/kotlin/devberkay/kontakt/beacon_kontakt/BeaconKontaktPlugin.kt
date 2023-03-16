package devberkay.kontakt.beacon_kontakt



import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import com.kontakt.sdk.android.ble.manager.ProximityManagerFactory
import com.kontakt.sdk.android.common.KontaktSDK
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** BeaconKontaktPlugin */
  class BeaconKontaktPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel
    private lateinit var applicationContext : Context
    private lateinit var activity : Activity
    private lateinit var kontaktSDK : KontaktSDK
    private lateinit var permissionService : PermissionService
    private lateinit var foregroundScanService : ForegroundScanService

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      channel = MethodChannel(flutterPluginBinding.binaryMessenger, "beacon_kontakt")
      channel.setMethodCallHandler(this)
      applicationContext = flutterPluginBinding.applicationContext
      foregroundScanService = ForegroundScanService(applicationContext)
      permissionService = PermissionService(activity,applicationContext)
      kontaktSDK = KontaktSDK.initialize("dgSRGSjPdKlgymeNiratRYxucDqGOCtj");
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    else if(call.method == "checkPermissions") {

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

  }


  override fun onDetachedFromActivityForConfigChanges() {
      TODO("Not yet implemented")
    }




  }
