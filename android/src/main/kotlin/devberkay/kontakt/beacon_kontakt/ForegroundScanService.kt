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

class ForegroundScanService(private val context: Context) {

    private val proximityManager: ProximityManager by lazy {
        ProximityManagerFactory.create(context, KontaktCloudFactory.create("dgSRGSjPdKlgymeNiratRYxucDqGOCtj")).apply {
            configuration()
                .scanPeriod(ScanPeriod.MONITORING)
                .scanMode(ScanMode.BALANCED)
                .deviceUpdateCallbackInterval(TimeUnit.SECONDS.toMillis(8))
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
                "Already scanning"
            } else {
                proximityManager.startScanning()
                "Scanning started"
            }
        }
    }

    fun stopScanning() {
        if (proximityManager.isScanning) {
            proximityManager.stopScanning()
            Log.i(TAG, "Scanning stopped")
        }
    }

    companion object {
        private const val TAG = "ForegroundScanService"
    }
}
