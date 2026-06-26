import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'vfd_data.freezed.dart';
part 'vfd_data.g.dart';

@freezed
class VfdData with _$VfdData {
  const VfdData._();

  const factory VfdData({
    required double frequency,
    required double voltage,
    required double current,
    required double power,
    required int hourmeter,
    @Default(0) int alarmCode,
    @Default(false) bool isConnected,
  }) = _VfdData;

  factory VfdData.initial() => const VfdData(
        frequency: 0,
        voltage: 0,
        current: 0,
        power: 0,
        hourmeter: 0,
        alarmCode: 0,
        isConnected: false,
      );

  factory VfdData.fromJson(Map<String, dynamic> json) =>
      _$VfdDataFromJson(json);

  String get frequencyText => '${frequency.toStringAsFixed(1)} Hz';
  String get voltageText => '${voltage.toStringAsFixed(0)} V';
  String get currentText => '${current.toStringAsFixed(1)} A';
  String get powerText => '${power.toStringAsFixed(2)} kW';
  String get hourText => NumberFormat('#,###').format(hourmeter);

  String get alarmText {
    switch (alarmCode) {
      case 0:
        return 'Normal';
      case 1:
        return 'OC (Overcurrent)';
      case 3:
        return 'OV (Overvoltage)';
      case 5:
        return 'OH (Overheat)';
      case 7:
        return 'OL (Overload)';
      default:
        return 'Alarm #$alarmCode';
    }
  }
}
