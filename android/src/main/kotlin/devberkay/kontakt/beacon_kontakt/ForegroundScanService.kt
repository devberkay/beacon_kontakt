package devberkay.kontakt.beacon_kontakt

import android.content.Context
import com.kontakt.sdk.android.ble.configuration.*
import com.kontakt.sdk.android.ble.filter.ibeacon.IBeaconFilter
import com.kontakt.sdk.android.ble.filter.ibeacon.IBeaconFilters
import com.kontakt.sdk.android.ble.manager.ProximityManager
import com.kontakt.sdk.android.ble.manager.ProximityManagerFactory
import com.kontakt.sdk.android.ble.manager.listeners.simple.SimpleIBeaconListener
import com.kontakt.sdk.android.ble.manager.listeners.simple.SimpleSecureProfileListener
import com.kontakt.sdk.android.ble.rssi.RssiCalculators
import com.kontakt.sdk.android.cloud.KontaktCloudFactory
import com.kontakt.sdk.android.common.profile.IBeaconDevice
import com.kontakt.sdk.android.common.profile.IBeaconRegion
import com.kontakt.sdk.android.common.profile.ISecureProfile
import io.flutter.plugin.common.EventChannel
import java.util.*
import java.util.concurrent.TimeUnit


class ForegroundScanService(private val context: Context, private val apiKey : String, private val scanPeriod: ScanPeriod, private val listenerType: String,private val proximityUUID) : EventChannel.StreamHandler  {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        proximityManager.disconnect()
    }

    private val proximityManager: ProximityManager by lazy {
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
        }
    }

    private val filterList = listOf(
        IBeaconFilters.newProximityUUIDFilter(UUID.fromString("f7826da6-4fa2-4e98-8024-bc5b71e0893e")),
        IBeaconFilters.newMajorFilter(43),
        IBeaconFilters.newMinorFilter(34)
    )

    private val iBeaconListener = object : SimpleIBeaconListener() {
//        override fun onIBeaconDiscovered(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
//            TODO("Not yet implemented")
//        }

        override fun onIBeaconsUpdated(
            iBeacons: MutableList<IBeaconDevice>?,
            region: IBeaconRegion?
        ) {
            eventSink?.success(iBeacons?.map { mapOf("rssi" to it.rssi, "txPower" to it.txPower , "batteryLevel" to it.batteryPower, "name" to it.name, "minor" to it.minor, "major" to it.major, "proximityUUID" to it.proximityUUID,"uniqueUUID" to it.uniqueId ,"proximity" to it.proximity )  })
        }

//        override fun onIBeaconLost(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
//            TODO("Not yet implemented")
//        }
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

            } else {

                if (listenerType == "iBeaconListener") {
                    proximityManager.setIBeaconListener(iBeaconListener)
                } else if (listenerType == "secureProfileListener") {
                    proximityManager.setSecureProfileListener(secureProfileListener)
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
