// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vfd_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VfdDataImpl _$$VfdDataImplFromJson(Map<String, dynamic> json) =>
    _$VfdDataImpl(
      frequency: (json['frequency'] as num).toDouble(),
      voltage: (json['voltage'] as num).toDouble(),
      current: (json['current'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      hourmeter: (json['hourmeter'] as num).toInt(),
      alarmCode: (json['alarmCode'] as num?)?.toInt() ?? 0,
      isConnected: json['isConnected'] as bool? ?? false,
    );

Map<String, dynamic> _$$VfdDataImplToJson(_$VfdDataImpl instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'voltage': instance.voltage,
      'current': instance.current,
      'power': instance.power,
      'hourmeter': instance.hourmeter,
      'alarmCode': instance.alarmCode,
      'isConnected': instance.isConnected,
    };
