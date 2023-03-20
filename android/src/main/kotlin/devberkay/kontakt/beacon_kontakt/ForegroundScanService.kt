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
import com.kontakt.sdk.android.ble.manager.listeners.IBeaconListener
import com.kontakt.sdk.android.ble.manager.listeners.SecureProfileListener
import com.kontakt.sdk.android.cloud.KontaktCloudFactory
import com.kontakt.sdk.android.common.profile.IBeaconDevice
import com.kontakt.sdk.android.common.profile.IBeaconRegion
import com.kontakt.sdk.android.common.profile.ISecureProfile
import io.flutter.plugin.common.EventChannel
import java.util.concurrent.TimeUnit

class ForegroundScanService(private val context: Context, private val listenerType : String) : EventChannel.StreamHandler  {
    private var eventSink: EventChannel.EventSink? = null
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        proximityManager.disconnect()
    }

    private val proximityManager: ProximityManager by lazy {
        ProximityManagerFactory.create(context, KontaktCloudFactory.create("dgSRGSjPdKlgymeNiratRYxucDqGOCtj")).apply {
            configuration()
                .scanPeriod(ScanPeriod.MONITORING)
                .scanMode(ScanMode.BALANCED)
                .deviceUpdateCallbackInterval(TimeUnit.SECONDS.toMillis(8))
        }
    }

    private val iBeaconListener = object : IBeaconListener {
        override fun onIBeaconDiscovered(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            TODO("Not yet implemented")
        }

        override fun onIBeaconsUpdated(
            iBeacons: MutableList<IBeaconDevice>?,
            region: IBeaconRegion?
        ) {
            eventSink?.success(iBeacons.map {   })
        }

        override fun onIBeaconLost(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            TODO("Not yet implemented")
        }
    }

    private val secureProfileListener = object : SecureProfileListener {
        override fun onProfileDiscovered(iSecureProfile: ISecureProfile) {

            Log.i(TAG, "onProfileDiscovered: " + iSecureProfile.toString())
        }

        override fun onProfilesUpdated(list: List<ISecureProfile>) {
            for (profile in list) {

            }
        }

        override fun onProfileLost(iSecureProfile: ISecureProfile) {
            Log.e(TAG, "onProfileLost: " + iSecureProfile.toString())
        }
    }

    init {
        if(listenerType=="iBeacon") {
            proximityManager.setIBeaconListener(iBeaconListener)
        }
        else if(listenerType=="SecureProfile") {
            proximityManager.setSecureProfileListener(secureProfileListener)
        }
        else {

        }

    }

    fun startScanning() {
        proximityManager.connect {
            if (proximityManager.isScanning) {

            } else {
                proximityManager.startScanning()
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
