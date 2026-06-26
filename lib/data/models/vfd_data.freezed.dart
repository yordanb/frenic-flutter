// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vfd_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VfdData _$VfdDataFromJson(Map<String, dynamic> json) {
  return _VfdData.fromJson(json);
}

/// @nodoc
mixin _$VfdData {
  double get frequency => throw _privateConstructorUsedError;
  double get voltage => throw _privateConstructorUsedError;
  double get current => throw _privateConstructorUsedError;
  double get power => throw _privateConstructorUsedError;
  int get hourmeter => throw _privateConstructorUsedError;
  int get alarmCode => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;

  /// Serializes this VfdData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VfdData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VfdDataCopyWith<VfdData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VfdDataCopyWith<$Res> {
  factory $VfdDataCopyWith(VfdData value, $Res Function(VfdData) then) =
      _$VfdDataCopyWithImpl<$Res, VfdData>;
  @useResult
  $Res call(
      {double frequency,
      double voltage,
      double current,
      double power,
      int hourmeter,
      int alarmCode,
      bool isConnected});
}

/// @nodoc
class _$VfdDataCopyWithImpl<$Res, $Val extends VfdData>
    implements $VfdDataCopyWith<$Res> {
  _$VfdDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VfdData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? voltage = null,
    Object? current = null,
    Object? power = null,
    Object? hourmeter = null,
    Object? alarmCode = null,
    Object? isConnected = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      voltage: null == voltage
          ? _value.voltage
          : voltage // ignore: cast_nullable_to_non_nullable
              as double,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double,
      power: null == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as double,
      hourmeter: null == hourmeter
          ? _value.hourmeter
          : hourmeter // ignore: cast_nullable_to_non_nullable
              as int,
      alarmCode: null == alarmCode
          ? _value.alarmCode
          : alarmCode // ignore: cast_nullable_to_non_nullable
              as int,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VfdDataImplCopyWith<$Res> implements $VfdDataCopyWith<$Res> {
  factory _$$VfdDataImplCopyWith(
          _$VfdDataImpl value, $Res Function(_$VfdDataImpl) then) =
      __$$VfdDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double frequency,
      double voltage,
      double current,
      double power,
      int hourmeter,
      int alarmCode,
      bool isConnected});
}

/// @nodoc
class __$$VfdDataImplCopyWithImpl<$Res>
    extends _$VfdDataCopyWithImpl<$Res, _$VfdDataImpl>
    implements _$$VfdDataImplCopyWith<$Res> {
  __$$VfdDataImplCopyWithImpl(
      _$VfdDataImpl _value, $Res Function(_$VfdDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VfdData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? voltage = null,
    Object? current = null,
    Object? power = null,
    Object? hourmeter = null,
    Object? alarmCode = null,
    Object? isConnected = null,
  }) {
    return _then(_$VfdDataImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      voltage: null == voltage
          ? _value.voltage
          : voltage // ignore: cast_nullable_to_non_nullable
              as double,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double,
      power: null == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as double,
      hourmeter: null == hourmeter
          ? _value.hourmeter
          : hourmeter // ignore: cast_nullable_to_non_nullable
              as int,
      alarmCode: null == alarmCode
          ? _value.alarmCode
          : alarmCode // ignore: cast_nullable_to_non_nullable
              as int,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VfdDataImpl extends _VfdData {
  const _$VfdDataImpl(
      {required this.frequency,
      required this.voltage,
      required this.current,
      required this.power,
      required this.hourmeter,
      this.alarmCode = 0,
      this.isConnected = false})
      : super._();

  factory _$VfdDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$VfdDataImplFromJson(json);

  @override
  final double frequency;
  @override
  final double voltage;
  @override
  final double current;
  @override
  final double power;
  @override
  final int hourmeter;
  @override
  @JsonKey()
  final int alarmCode;
  @override
  @JsonKey()
  final bool isConnected;

  @override
  String toString() {
    return 'VfdData(frequency: $frequency, voltage: $voltage, current: $current, power: $power, hourmeter: $hourmeter, alarmCode: $alarmCode, isConnected: $isConnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VfdDataImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.voltage, voltage) || other.voltage == voltage) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.power, power) || other.power == power) &&
            (identical(other.hourmeter, hourmeter) ||
                other.hourmeter == hourmeter) &&
            (identical(other.alarmCode, alarmCode) ||
                other.alarmCode == alarmCode) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency, voltage, current,
      power, hourmeter, alarmCode, isConnected);

  /// Create a copy of VfdData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VfdDataImplCopyWith<_$VfdDataImpl> get copyWith =>
      __$$VfdDataImplCopyWithImpl<_$VfdDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VfdDataImplToJson(
      this,
    );
  }
}

abstract class _VfdData extends VfdData {
  const factory _VfdData(
      {required final double frequency,
      required final double voltage,
      required final double current,
      required final double power,
      required final int hourmeter,
      final int alarmCode,
      final bool isConnected}) = _$VfdDataImpl;
  const _VfdData._() : super._();

  factory _VfdData.fromJson(Map<String, dynamic> json) = _$VfdDataImpl.fromJson;

  @override
  double get frequency;
  @override
  double get voltage;
  @override
  double get current;
  @override
  double get power;
  @override
  int get hourmeter;
  @override
  int get alarmCode;
  @override
  bool get isConnected;

  /// Create a copy of VfdData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VfdDataImplCopyWith<_$VfdDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
