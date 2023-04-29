package devberkay.kontakt.beacon_kontakt

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.location.LocationManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.EventChannel

class ActivityService(private val context: Context)  {



    fun emitLocationStatus(): Boolean {
        return try {
            val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
        } catch (e: SecurityException) {
            false
        }
    }


    fun emitBluetoothStatus(): Boolean {
        return BluetoothAdapter.getDefaultAdapter()?.isEnabled ?: false
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
