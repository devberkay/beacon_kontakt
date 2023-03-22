package devberkay.kontakt.beacon_kontakt

import android.content.Context
import android.util.Log
import com.kontakt.sdk.android.ble.configuration.*
import com.kontakt.sdk.android.ble.device.BeaconRegion
import com.kontakt.sdk.android.ble.filter.ibeacon.IBeaconFilters
import com.kontakt.sdk.android.ble.manager.ProximityManager
import com.kontakt.sdk.android.ble.manager.ProximityManagerFactory
import com.kontakt.sdk.android.ble.manager.listeners.IBeaconListener
import com.kontakt.sdk.android.ble.manager.listeners.simple.SimpleSecureProfileListener
import com.kontakt.sdk.android.ble.rssi.RssiCalculators
import com.kontakt.sdk.android.cloud.KontaktCloudFactory
import com.kontakt.sdk.android.common.profile.IBeaconDevice
import com.kontakt.sdk.android.common.profile.IBeaconRegion
import com.kontakt.sdk.android.common.profile.ISecureProfile
import io.flutter.plugin.common.EventChannel
import java.util.*
import java.util.concurrent.TimeUnit


class ForegroundScanService(private val context: Context, private val apiKey : String, private val scanPeriod: ScanPeriod, private val listenerType: String,private val proximityUUID:String,private val major:Int?, private val minor:Int? ) : EventChannel.StreamHandler  {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        proximityManager.disconnect()
    }




    private val proximityManager: ProximityManager by lazy {
        val filterList = listOfNotNull(
            IBeaconFilters.newProximityUUIDFilter(UUID.fromString(proximityUUID)),
            major?.let { IBeaconFilters.newMajorFilter(it) },
            minor?.let { IBeaconFilters.newMinorFilter(it) }
        )
        Log.d(TAG, "proximityManager filterList: $filterList")
        ProximityManagerFactory.create(context, KontaktCloudFactory.create(apiKey)).apply {
            configuration()
                .scanMode(ScanMode.BALANCED)
                .scanPeriod(scanPeriod)
                .activityCheckConfiguration(ActivityCheckConfiguration.DISABLED)
                .forceScanConfiguration(ForceScanConfiguration.DISABLED)
                .deviceUpdateCallbackInterval(TimeUnit.SECONDS.toMillis(5))
                .rssiCalculator(RssiCalculators.DEFAULT)
                .cacheFileName("BLE_CACHE")
                .resolveShuffledInterval(3)
                .monitoringEnabled(true)
                .monitoringSyncInterval(10)
                .kontaktScanFilters(KontaktScanFilter.DEFAULT_FILTERS_LIST)


            when (listenerType) {
                "iBeaconListener" -> this.setIBeaconListener(iBeaconListener)
                "secureProfileListener" -> this.setSecureProfileListener(secureProfileListener)
            }

            proximityManager.spaces().iBeaconRegions(listOf(primaryRegion));


        }
    }



    private val primaryRegion : IBeaconRegion = BeaconRegion.Builder()
        .identifier("primaryRegion")
        .proximity(UUID.fromString(proximityUUID))
        .major(BeaconRegion.ANY_MAJOR)
        .minor(BeaconRegion.ANY_MINOR)
        .build()

    private val iBeaconListener = object : IBeaconListener {
        override fun onIBeaconDiscovered(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            Log.d("onIBeaconsDiscovered", "${iBeacon?.proximityUUID.toString()} + ${iBeacon?.major} + ${iBeacon?.minor} + ${iBeacon?.rssi}")
            eventSink?.success(iBeacon?.let { mapOf("rssi" to it.rssi, "txPower" to it.txPower , "batteryLevel" to it.batteryPower, "name" to it.name, "minor" to it.minor, "major" to it.major, "proximityUUID" to it.proximityUUID,"uniqueUUID" to it.uniqueId ,"proximity" to it.proximity )  })
        }

        override fun onIBeaconsUpdated(
            iBeacons: MutableList<IBeaconDevice>?,
            region: IBeaconRegion?
        ) {
            val iBeacon = iBeacons?.first()
            Log.d("onIBeaconsUpdated", "${iBeacon?.proximityUUID.toString()} + ${iBeacon?.major} + ${iBeacon?.minor} + ${iBeacon?.rssi}")
            eventSink?.success(iBeacons?.map { mapOf("rssi" to it.rssi, "txPower" to it.txPower , "batteryLevel" to it.batteryPower, "name" to it.name, "minor" to it.minor, "major" to it.major, "proximityUUID" to it.proximityUUID,"uniqueUUID" to it.uniqueId ,"proximity" to it.proximity )  })
        }

        override fun onIBeaconLost(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            TODO("Not yet implemented")
        }
    }

    private val secureProfileListener = object : SimpleSecureProfileListener() {
//        override fun onProfileDiscovered(iSecureProfile: ISecureProfile) {
//
//            Log.i(TAG, "onProfileDiscovered: " + iSecureProfile.toString())
//        }

        override fun onProfilesUpdated(list: List<ISecureProfile>) {

            eventSink?.success(list.map { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "batteryLevel" to it.batteryLevel, "name" to it.name, "instanceId" to it.instanceId, "macAdress" to it.macAddress  ) })

        }

//        override fun onProfileLost(iSecureProfile: ISecureProfile) {
//            Log.e(TAG, "onProfileLost: " + iSecureProfile.toString())
//        }
    }


    fun startScanning() {
        proximityManager.connect {

            if (proximityManager.isScanning) {
                Log.d(TAG, "startScanning: ALREADY FUCKING SCANNING")
                if (listenerType == "iBeaconListener") {
                    proximityManager.setIBeaconListener(iBeaconListener)
                    Log.d(TAG, "startScanning: SETTING IBEACON LISTENER")
                } else if (listenerType == "secureProfileListener") {
                    proximityManager.setSecureProfileListener(secureProfileListener)
                    Log.d(TAG, "startScanning: SETTING SECURE PROFILE LISTENER")
                }
            } else {
                Log.d(TAG, "startScanning: WAS NOT FUCKING SCANNING")
                if (listenerType == "iBeaconListener") {
                    proximityManager.setIBeaconListener(iBeaconListener)
                    Log.d(TAG, "WAS NOT startScanning: SETTING IBEACON LISTENER")
                } else if (listenerType == "secureProfileListener") {
                    proximityManager.setSecureProfileListener(secureProfileListener)
                    Log.d(TAG, "WAS NOT startScanning: SETTING IBEACON LISTENER")
                }
                proximityManager.startScanning()
            }
        }
    }

    fun stopScanning() {
        if (proximityManager.isScanning) {
            proximityManager.stopScanning()

        }
    }

    companion object {
        private const val TAG = "ForegroundScanService"
    }
}
