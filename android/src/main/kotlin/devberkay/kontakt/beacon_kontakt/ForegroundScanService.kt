package devberkay.kontakt.beacon_kontakt

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.kontakt.sdk.android.ble.configuration.ScanMode
import com.kontakt.sdk.android.ble.configuration.ScanPeriod
import com.kontakt.sdk.android.ble.manager.ProximityManager
import com.kontakt.sdk.android.ble.manager.ProximityManagerFactory
import com.kontakt.sdk.android.ble.manager.listeners.SecureProfileListener
import com.kontakt.sdk.android.cloud.KontaktCloudFactory
import com.kontakt.sdk.android.common.profile.ISecureProfile
import java.util.concurrent.TimeUnit

class ForegroundScanService(private val activity: Activity, private val context: Context) {

    private val proximityManager: ProximityManager by lazy {
        ProximityManagerFactory.create(context, KontaktCloudFactory.create("dgSRGSjPdKlgymeNiratRYxucDqGOCtj")).apply {
            configuration()
                .scanPeriod(ScanPeriod.RANGING)
                .scanMode(ScanMode.BALANCED)
                .deviceUpdateCallbackInterval(TimeUnit.SECONDS.toMillis(5))
        }
    }

    private val secureProfileListener = object : SecureProfileListener {
        override fun onProfileDiscovered(iSecureProfile: ISecureProfile) {
            Log.i(TAG, "onProfileDiscovered: " + iSecureProfile.toString())
        }

        override fun onProfilesUpdated(list: List<ISecureProfile>) {
            for (profile in list) {
                Log.i(TAG, "onProfileUpdated: " + profile.toString())
            }
        }

        override fun onProfileLost(iSecureProfile: ISecureProfile) {
            Log.e(TAG, "onProfileLost: " + iSecureProfile.toString())
        }
    }

    fun startScanning() {
    proximityManager.connect {
        if (proximityManager.isScanning) {
            Log.i(TAG, "Already scanning")
        } else {
            proximityManager.startScanning()
            Log.i(TAG, "Scanning started")
        }
    }
}

    fun stopScanning() {
        if (proximityManager.isScanning) {
            proximityManager.stopScanning()
            Log.i(TAG, "Scanning stopped")
        }
    }




    // Permission related methods are below :


     fun checkPermissions() {
        val requiredPermissions = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_COARSE_LOCATION) // ACCESS_FINE_LOCATION must be requested with ACCESS_COARSE_LOCATION.

        } else {
            arrayOf(Manifest.permission.BLUETOOTH_SCAN, Manifest.permission.BLUETOOTH_CONNECT, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION)
        }

        if (isAnyOfPermissionsNotGranted(requiredPermissions)) {
            ActivityCompat.requestPermissions(activity, requiredPermissions, REQUEST_CODE_PERMISSIONS)
        }
    }

            private fun isAnyOfPermissionsNotGranted(requiredPermissions: Array<String>): Boolean {
                for (permission in requiredPermissions) {
                    val checkSelfPermissionResult = ContextCompat.checkSelfPermission(context, permission)
                    if (PackageManager.PERMISSION_GRANTED != checkSelfPermissionResult) {
                        return true
                    }
                }
                return false
    }


    companion object {
        private const val TAG = "ForegroundScanService"
        const val REQUEST_CODE_PERMISSIONS = 100
    }
}
