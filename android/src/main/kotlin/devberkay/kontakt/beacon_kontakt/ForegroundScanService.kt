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
import io.flutter.plugin.common.MethodChannel
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
    private var secureProfileLostEventSink : EventChannel.EventSink? = null
    private  val proximityManager: ProximityManager = ProximityManagerFactory.create(context, KontaktCloudFactory.create(apiKey))

    private val iBeaconListener = object : IBeaconListener {
        override fun onIBeaconDiscovered(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            statusEventSink?.success(true)
            Log.d("onIBeaconDiscovered", "onIBeaconDiscovered ${iBeacon.toString()}")
            iBeaconDiscoveredEventSink?.success(iBeacon?.let { mapOf("timestamp" to it.timestamp,"rssi" to it.rssi, "proximityUUID" to it.proximityUUID.toString().uppercase(),"minor" to it.minor, "major" to it.major, "uniqueId" to it.uniqueId  )  })
        }

        override fun onIBeaconsUpdated(
            iBeacons: MutableList<IBeaconDevice>?,
            region: IBeaconRegion?
        ) {
            Log.d("updatedEventSinks","${iBeaconsUpdatedEventSink.toString()} ve ${statusEventSink.toString()} ah size eventsink diyeni")
            statusEventSink?.success(true)
            Log.d("onIBeaconsUpdated", "onIBeaconsUpdated-0 ${iBeacons.toString()}")
            val iBeaconsList = iBeacons?.map { mapOf("timestamp" to it.timestamp,"rssi" to it.rssi, "proximityUUID" to it.proximityUUID.toString().uppercase(), "minor" to it.minor, "major" to it.major,"uniqueId" to it.uniqueId   )  }
            Log.d("onIBeaconsUpdated", "onIBeaconsUpdated-1 ${iBeaconsList.toString()}")
            iBeaconsUpdatedEventSink?.success(iBeaconsList)

        }

        override fun onIBeaconLost(iBeacon: IBeaconDevice?, region: IBeaconRegion?) {
            Log.d("onIBeaconLost", "onIBeaconLost ${iBeacon.toString()}")
            statusEventSink?.success(true)
            iBeaconLostEventSink?.success(iBeacon?.let { mapOf("timestamp" to it.timestamp,"rssi" to it.rssi,  "proximityUUID" to it.proximityUUID.toString().uppercase(), "minor" to it.minor, "major" to it.major,  "uniqueId" to it.uniqueId )  })
        }
    }

    private val secureProfileListener = object : SecureProfileListener {
        override fun onProfileDiscovered(iSecureProfile: ISecureProfile) {

            statusEventSink?.success(true)
            Log.d(TAG, "onSecureProfileDiscovered: " + iSecureProfile.toString())
            secureProfileDiscoveredEventSink?.success(iSecureProfile.let { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "mac" to it.macAddress, "uniqueId" to it.uniqueId ) })
        }

        override fun onProfilesUpdated(list: List<ISecureProfile>) {
            statusEventSink?.success(true)
            Log.d(TAG, "onSecureProfileUpdated: " + list.toString())
            secureProfilesUpdatedEventSink?.success(list.map { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "mac" to it.macAddress, "uniqueId" to it.uniqueId  ) })
        }

        override fun onProfileLost(iSecureProfile: ISecureProfile) {
            statusEventSink?.success(true)
            Log.d(TAG, "onSecureProfileLost: " + iSecureProfile.toString())
            secureProfileLostEventSink?.success( iSecureProfile.let { mapOf("rssi" to it.rssi, "txPower" to it.txPower, "mac" to it.macAddress, "uniqueId" to it.uniqueId   ) })
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
        // log inputs
        Log.d("onListen", "arguments: $arguments")
        Log.d("onListen", "events: $events")

        when (arguments) {
            "statusEventSink" -> {
                statusEventSink = events
                statusEventSink?.success(proximityManager.isScanning)
            }
            "iBeaconDiscoveredEventSink" -> {
                iBeaconDiscoveredEventSink = events
                Log.d("onListen", "iBeaconDiscoveredEventSink-onListen")
            }
            "iBeaconsUpdatedEventSink" -> {
                iBeaconsUpdatedEventSink = events
                Log.d("onListen", "iBeaconsUpdatedEventSink-onListen")
            }
            "iBeaconLostEventSink" -> {
                iBeaconLostEventSink = events
                Log.d("onListen", "iBeaconLostEventSink-onListen")
            }
            "secureProfileDiscoveredEventSink" -> {
                secureProfileDiscoveredEventSink = events
            }
            "secureProfilesUpdatedEventSink" -> {
                secureProfilesUpdatedEventSink = events
            }
            "secureProfileLostEventSink" -> {
                secureProfileLostEventSink = events
            }
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
                Log.d("onCancel", "iBeaconDiscoveredEventSink-onCancel")
            }
            "iBeaconsUpdatedEventSink" -> {
                iBeaconsUpdatedEventSink?.endOfStream()
                iBeaconsUpdatedEventSink = null
                Log.d("onCancel", "iBeaconsUpdatedEventSink-onCancel")
            }
            "iBeaconLostEventSink" -> {
                iBeaconLostEventSink?.endOfStream()
                iBeaconLostEventSink = null
                Log.d("onCancel", "iBeaconLostEventSink-onCancel")
            }
            "secureProfileDiscoveredEventSink" -> {
                secureProfileDiscoveredEventSink?.endOfStream()
                secureProfileDiscoveredEventSink = null
            }
            "secureProfilesUpdatedEventSink" -> {
                secureProfilesUpdatedEventSink?.endOfStream()
                secureProfilesUpdatedEventSink = null
            }
            "secureProfileLostEventSink" -> {
                secureProfileLostEventSink?.endOfStream()
                secureProfileLostEventSink = null
            }
            null -> {

                proximityManager.disconnect();
                // The channel implementation may call this method with null arguments to separate a pair of two consecutive set up requests. Such request pairs may occur during Flutter hot restart.
            }
            else -> throw IllegalArgumentException("Unknown event channel onCancel: $arguments")
        }

    }



    fun startScanning(scanPeriod: ScanPeriod?, proximityUUID:String?, major:Int?,  minor:Int?, resultObject:  MethodChannel.Result) {

         Log.d("startScanning","Scanning Handler started")
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
                    .deviceUpdateCallbackInterval(TimeUnit.SECONDS.toMillis(3))
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
                Log.d("startScanning","Scanning started.")
                resultObject.success(null)
            }

            override fun onServiceBindError(message: String?) {
                Log.d("onServiceBindError","onServiceBindError.")

                super.onServiceBindError(message)
                resultObject.error("onServiceBindError", message, null)
            }
        })
        Log.d("startScanning","Scanning started. ScanPeriod: ${scanPeriod}")
    }

    fun stopScanning(resultObject:  MethodChannel.Result) {
        proximityManager.stopScanning()

        resultObject.success(null)
    }

    fun restartScanning(resultObject:  MethodChannel.Result) {
        proximityManager.restartScanning()
        resultObject.success(null)
    }

    val isScanning: Boolean
        get() = proximityManager.isScanning

    companion object {
        private const val TAG = "ForegroundScanService"
    }
}
