package devberkay.kontakt.beacon_kontakt

import android.content.Context
import android.util.Log
import com.kontakt.sdk.android.ble.configuration.*
import com.kontakt.sdk.android.ble.connection.OnServiceReadyListener
import com.kontakt.sdk.android.ble.device.BeaconRegion
import com.kontakt.sdk.android.ble.exception.ScanError
import com.kontakt.sdk.android.ble.filter.ibeacon.IBeaconFilters
import com.kontakt.sdk.android.ble.manager.ProximityManager
import com.kontakt.sdk.android.ble.manager.ProximityManagerFactory
import com.kontakt.sdk.android.ble.manager.listeners.IBeaconListener
import com.kontakt.sdk.android.ble.manager.listeners.ScanStatusListener
import com.kontakt.sdk.android.ble.manager.listeners.SecureProfileListener
import com.kontakt.sdk.android.ble.manager.listeners.simple.SimpleSecureProfileListener
import com.kontakt.sdk.android.ble.rssi.RssiCalculators
import com.kontakt.sdk.android.cloud.KontaktCloudFactory
import com.kontakt.sdk.android.common.profile.IBeaconDevice
import com.kontakt.sdk.android.common.profile.IBeaconRegion
import com.kontakt.sdk.android.common.profile.ISecureProfile
import io.flutter.plugin.common.EventChannel
import java.util.*
import java.util.concurrent.TimeUnit

//

class ForegroundScanService(private val context: Context, private val apiKey : String) : EventChannel.StreamHandler  {
    private var statusEventSink: EventChannel.EventSink? = null
    private var iBeaconDiscoveredEventSink : EventChannel.EventSink? = null
    private var iBeaconsUpdatedEventSink : EventChannel.EventSink? = null
    private var iBeaconLostEventSink : EventChannel.EventSink? = null
    private var secureProfileDiscoveredEventSink : EventChannel.EventSink? = null
    private var secureProfilesUpdatedEventSink : EventChannel.EventSink? = null
    private var secureProfileLostEvenSink : EventChannel.EventSink? = null
    private  val proximityManager: ProximityManager = ProximityManagerFactory.create(context, KontaktCloudFactory.create(apiKey))


    private val iBeaconListener = object : IBeaconListener {
        override fun onIBeaconDiscovered(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            statusEventSink?.success(true)
            Log.d("onIBeaconDiscovered", "onIBeaconDiscovered ${iBeacon.toString()}")
            iBeaconDiscoveredEventSink?.success(iBeacon?.let { mapOf("timestamp" to it.timestamp,"rssi" to it.rssi, "txPower" to it.txPower , "batteryLevel" to it.batteryPower, "name" to it.name, "proximityUUID" to it.proximityUUID.toString(),"uniqueID" to it.uniqueId, "minor" to it.minor, "major" to it.major )  })
        }

        override fun onIBeaconsUpdated(
            iBeacons: MutableList<IBeaconDevice>?,
            region: IBeaconRegion?
        ) {
            statusEventSink?.success(true)
            Log.d("onIBeaconsUpdated", "onIBeaconsUpdated ${iBeacons.toString()}")
            iBeaconsUpdatedEventSink?.success(iBeacons?.map { mapOf("timestamp" to it.timestamp,"rssi" to it.rssi, "txPower" to it.txPower , "batteryLevel" to it.batteryPower, "name" to it.name, "proximityUUID" to it.proximityUUID.toString(),"uniqueID" to it.uniqueId, "minor" to it.minor, "major" to it.major  )  })
        }

        override fun onIBeaconLost(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            statusEventSink?.success(true)
           Log.d("onIBeaconLost", "onIBeaconLost ${iBeacon.toString()}")
            iBeaconLostEventSink?.success(iBeacon?.let { mapOf("timestamp" to it.timestamp,"rssi" to it.rssi, "txPower" to it.txPower , "batteryLevel" to it.batteryPower, "name" to it.name, "proximityUUID" to it.proximityUUID.toString(),"uniqueID" to it.uniqueId, "minor" to it.minor, "major" to it.major )  })
        }
    }

    private val secureProfileListener = object : SecureProfileListener {
        override fun onProfileDiscovered(iSecureProfile: ISecureProfile) {

            statusEventSink?.success(true)
            Log.i(TAG, "onSecureProfileDiscovered: " + iSecureProfile.toString())
            secureProfileDiscoveredEventSink?.success(iSecureProfile.let { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "batteryLevel" to it.batteryLevel, "name" to it.name, "instanceId" to it.instanceId, "macAdress" to it.macAddress  ) })
        }

        override fun onProfilesUpdated(list: List<ISecureProfile>) {
            statusEventSink?.success(true)
            secureProfilesUpdatedEventSink?.success(list.map { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "batteryLevel" to it.batteryLevel, "name" to it.name, "instanceId" to it.instanceId, "macAdress" to it.macAddress  ) })
        }

        override fun onProfileLost(iSecureProfile: ISecureProfile) {
            statusEventSink?.success(true)
            Log.e(TAG, "onSecureProfileLost: " + iSecureProfile.toString())
            secureProfileLostEvenSink?.success( iSecureProfile.let { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "batteryLevel" to it.batteryLevel, "name" to it.name, "instanceId" to it.instanceId, "macAdress" to it.macAddress  ) })
        }
    }

    private val scanStatusListener = object : ScanStatusListener {
        override fun onScanStart() {
            Log.d("onScanStart", "onScanStart")
            statusEventSink?.success(true)
        }

        override fun onScanStop() {
            Log.d("onScanStop", "onScanStop")
            statusEventSink?.success(false)
        }

        override fun onScanError(scanError: ScanError?) {
            Log.d("onScanError", "onScanError")
            statusEventSink?.error("onScanError", scanError?.message, scanError)
        }

        override fun onMonitoringCycleStart() {
            Log.d("onMonitoringCycleStart", "onMonitoringCycleStart")
            statusEventSink?.success(true)
        }

        override fun onMonitoringCycleStop() {
            Log.d("onMonitoringCycleStop", "onMonitoringCycleStop")
            statusEventSink?.success(true)
        }
    }




//
//    private val filterList = listOfNotNull(
//        IBeaconFilters.newProximityUUIDFilter(UUID.fromString(proximityUUID)),
//        major?.let { IBeaconFilters.newMajorFilter(it) },
//        minor?.let { IBeaconFilters.newMinorFilter(it) }
//    )



    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        when (arguments) {
            "statusEventSink" -> {
                statusEventSink = events
                statusEventSink?.success(proximityManager.isScanning)
            }
            "iBeaconDiscoveredEventSink" -> iBeaconDiscoveredEventSink = events
            "iBeaconsUpdatedEventSink" -> iBeaconsUpdatedEventSink = events
            "iBeaconLostEventSink" -> iBeaconLostEventSink = events
            "secureProfileDiscoveredEventSink" -> secureProfileDiscoveredEventSink = events
            "secureProfilesUpdatedEventSink" -> secureProfilesUpdatedEventSink = events
            "secureProfileLostEvenSink" -> secureProfileLostEvenSink = events
            else -> throw IllegalArgumentException("Unknown event channel onListen: $arguments")
        }
    }


    override fun onCancel(arguments: Any?) {
        when (arguments) {
            "statusEventSink" -> {
                statusEventSink?.endOfStream()
                statusEventSink = null
            }
            "iBeaconDiscoveredEventSink" -> {
                iBeaconDiscoveredEventSink?.endOfStream()
                iBeaconDiscoveredEventSink = null
            }
            "iBeaconsUpdatedEventSink" -> {
                iBeaconsUpdatedEventSink?.endOfStream()
                iBeaconDiscoveredEventSink = null

            }
            "iBeaconLostEventSink" -> {
                iBeaconLostEventSink?.endOfStream()
                iBeaconLostEventSink = null
            }
            "secureProfileDiscoveredEventSink" -> {
                secureProfileDiscoveredEventSink?.endOfStream()
                secureProfileDiscoveredEventSink = null
            }
            "secureProfilesUpdatedEventSink" -> {
                secureProfilesUpdatedEventSink?.endOfStream()
                secureProfilesUpdatedEventSink = null
            }
            "secureProfileLostEvenSink" -> {
                secureProfileLostEvenSink?.endOfStream()
                secureProfileLostEvenSink = null
            }
            null -> {
                // The channel implementation may call this method with null arguments to separate a pair of two consecutive set up requests. Such request pairs may occur during Flutter hot restart.
            }
            else -> throw IllegalArgumentException("Unknown event channel onCancel: $arguments")
        }

    }



    fun startScanning(scanPeriod: ScanPeriod?, listenerType: String?, proximityUUID:String?, major:Int?,  minor:Int?) {


         val primaryRegion : IBeaconRegion = BeaconRegion.Builder()
            .identifier("primaryRegion")
            .proximity(UUID.fromString(proximityUUID))
            .major(major ?: BeaconRegion.ANY_MAJOR)
            .minor(minor ?: BeaconRegion.ANY_MINOR)
            .build()

        proximityManager.connect(object : OnServiceReadyListener {
            override fun onServiceReady() {

                proximityManager.configuration()
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

                proximityManager.setScanStatusListener(scanStatusListener)
                proximityManager.setIBeaconListener(iBeaconListener)
                proximityManager.setSecureProfileListener(secureProfileListener)
                proximityManager.spaces().iBeaconRegions(listOf(primaryRegion))
                // Bluetooth adapter is ready, start scanning
                proximityManager.startScanning()
            }

            override fun onServiceBindError(message: String?) {
                Log.d(TAG, "onServiceBindError: $message")
                super.onServiceBindError(message)
            }
        })
    }

    fun stopScanning() {
        if (proximityManager.isScanning) {
            proximityManager.stopScanning()
        }
    }

    fun restartScanning() {
        if (proximityManager.isScanning) {
            proximityManager.restartScanning()
        }
    }

    val isScanning: Boolean
        get() = proximityManager.isScanning

    companion object {
        private const val TAG = "ForegroundScanService"
    }
}
