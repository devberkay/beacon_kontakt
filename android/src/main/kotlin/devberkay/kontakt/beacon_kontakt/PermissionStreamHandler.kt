package devberkay.kontakt.beacon_kontakt

import android.content.pm.PackageManager
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


class PermissionStreamHandler(binding : ActivityPluginBinding) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private lateinit var permissionResult: MethodChannel.Result

    init {
        binding.addRequestPermissionsResultListener { requestCode, permissions, grantResults ->
            onRequestPermissionsResult(requestCode, permissions, grantResults)
            true
        }
    }

    override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
        eventSink = sink
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        // Stop sending events to the Flutter side
    }

    private fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        if (requestCode == PermissionService.REQUEST_CODE_PERMISSIONS) {
            val granted = grantResults.isNotEmpty()  &&  grantResults.all { it == PackageManager.PERMISSION_GRANTED }
            if (granted) {
                eventSink?.success("PERMISSION_GRANTED")
            } else {
                eventSink?.error("PERMISSION_DENIED", "The user denied the permission request", null)
            }
        }
    }


}
