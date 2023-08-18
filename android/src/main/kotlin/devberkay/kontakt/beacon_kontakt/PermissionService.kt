package devberkay.kontakt.beacon_kontakt

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class PermissionService(private val activity: Activity,private val binding: ActivityPluginBinding,private val context: Context) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    init {
        binding.addRequestPermissionsResultListener { requestCode, permissions, grantResults ->
            onRequestPermissionsResult(requestCode, permissions, grantResults)
            true
        }
    }


    override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
        eventSink = sink

        eventSink?.success(checkPermissions(true))
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        // Stop sending events to the Flutter side
    }


    private fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        if (requestCode == PermissionService.REQUEST_CODE_PERMISSIONS) {
            val granted = grantResults.isNotEmpty()  &&  grantResults.all { it == PackageManager.PERMISSION_GRANTED }
            if (granted) {
                eventSink?.success(true)
            } else {
                eventSink?.success(false)
            }
        }
    }

    fun checkPermissions(onlyCheck:Boolean,resultObject:  MethodChannel.Result?) : Boolean {
        val requiredPermissions = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION)
        } else {
            arrayOf(Manifest.permission.BLUETOOTH_SCAN, Manifest.permission.BLUETOOTH_CONNECT, Manifest.permission.ACCESS_FINE_LOCATION)
        }

        if (requiredPermissions.any { ContextCompat.checkSelfPermission(context, it) != PackageManager.PERMISSION_GRANTED }) {
            if(onlyCheck) {
                return false
            }
            ActivityCompat.requestPermissions(activity, requiredPermissions, REQUEST_CODE_PERMISSIONS)
            return false
        }
        else {
            return true
        }
    }

    companion object {
        const val REQUEST_CODE_PERMISSIONS = 315
    }



}