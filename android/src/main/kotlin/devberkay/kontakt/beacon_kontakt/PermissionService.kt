package devberkay.kontakt.beacon_kontakt

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.EventChannel

class PermissionService(private val activity: Activity,private val context: Context) {


    fun checkPermissions(onlyCheck:Boolean) : Boolean {
        val requiredPermissions = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_COARSE_LOCATION) // some android 12 devices requires coarse_location with fine_location
        } else {
            arrayOf(Manifest.permission.BLUETOOTH_SCAN, Manifest.permission.BLUETOOTH_CONNECT, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION)
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

//    private fun isAnyOfPermissionsNotGranted(requiredPermissions: Array<String>): Boolean {
//        for (permission in requiredPermissions) {
//            val checkSelfPermissionResult = ContextCompat.checkSelfPermission(context, permission)
//            if (PackageManager.PERMISSION_GRANTED != checkSelfPermissionResult) {
//                return true
//            }
//        }
//        return false
//    }



    companion object {
        const val REQUEST_CODE_PERMISSIONS = 315
    }



}