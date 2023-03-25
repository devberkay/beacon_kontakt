package devberkay.kontakt.beacon_kontakt

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.location.LocationManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.EventChannel

class ServiceActivityStreamHandler(private val context: Context) : EventChannel.StreamHandler {

    private var locationStatusStreamHandler: EventChannel.EventSink? = null
    private var bluetoothStatusStreamHandler: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        when (arguments) {
            "locationStatus" -> locationStatusStreamHandler = eventSink
            "bluetoothStatus" -> bluetoothStatusStreamHandler = eventSink
        }
    }

    override fun onCancel(arguments: Any?) {
        when (arguments) {
            "locationStatus" -> locationStatusStreamHandler = null
            "bluetoothStatus" -> bluetoothStatusStreamHandler = null
        }
    }

    fun emitLocationStatus() {
        val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val isEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
        locationStatusStreamHandler?.success(isEnabled)
    }

    fun emitBluetoothStatus() {
        val adapter = BluetoothAdapter.getDefaultAdapter()
        val isEnabled = adapter?.isEnabled ?: false
        bluetoothStatusStreamHandler?.success(isEnabled)
    }

    fun openLocationSettings() {
        val intent = Intent(android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }

    fun openBluetoothSettings() {
        val intent = Intent(android.provider.Settings.ACTION_BLUETOOTH_SETTINGS)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }
}
