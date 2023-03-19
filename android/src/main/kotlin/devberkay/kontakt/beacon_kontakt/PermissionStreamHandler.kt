package devberkay.kontakt.beacon_kontakt

import io.flutter.plugin.common.EventChannel


class PermissionStreamHandler : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
        eventSink = sink
        // Start sending events to the Flutter side
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        // Stop sending events to the Flutter side
    }

    // ...
}
