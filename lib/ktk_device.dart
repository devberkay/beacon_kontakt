import 'dart:convert';
// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'ktk_device.freezed.dart';
// optional: Since our KTKDevice class is serializable, we must add this line.
// But if KTKDevice was not serializable, we could skip it.
part 'ktk_device.g.dart';


@freezed
class KTKDevice with _$KTKDevice {
  const factory KTKDevice({
    required String proximityUUID,
    required String major,
    required String macAdress,
    required int minor,
    required int updatedAt, // msSinceEpoch
    String? rssi,
    String? txPower // only android
  }) = _KTKDevice;

  factory KTKDevice.fromJson(Map<String, Object?> json)
      => _$KTKDeviceFromJson(json);
}