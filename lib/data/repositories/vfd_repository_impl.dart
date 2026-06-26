import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import '../datasources/serial_port_service.dart';
import '../datasources/modbus_rtu_frame.dart';
import 'package:frenic_mega_dashboard/domain/repositories/vfd_repository.dart';

class VfdRepositoryImpl implements VfdRepository {
  final SerialPortService _serial;
  StreamSubscription<Uint8List>? _subscription;
  Completer<Uint8List>? _responseCompleter;
  final List<int> _buffer = [];
  int _expectedLength = 0;

  VfdRepositoryImpl({required SerialPortService serial}) : _serial = serial;

  @override
  Future<bool> connect(String portName, {int baudRate = 9600}) async {
    return _serial.connect(portName: portName);
  }

  @override
  Future<void> disconnect() async {
    await _subscription?.cancel();
    await _serial.disconnect();
  }

  @override
  bool get isConnected => _serial.isConnected;

  @override
  Future<List<int>> readHoldingRegisters({
    required int slaveId,
    required int startAddress,
    int count = 1,
  }) async {
    if (!_serial.isConnected) {
      throw Exception('Serial port not connected');
    }

    final request = ModbusRtuFrame.buildReadHoldingRegisters(
      slaveId: slaveId,
      startAddress: startAddress,
      count: count,
    );

    final sent = await _serial.write(request);
    if (!sent) throw Exception('Failed to send request');

    _expectedLength = 3 + (count * 2) + 2;
    _responseCompleter = Completer<Uint8List>();
    _buffer.clear();

    _subscription = _serial.inputStream!.listen((data) {
      debugPrint('[Modbus-DEBUG] Received: ${data.toList()}');
      _buffer.addAll(data);
      if (_buffer.length >= _expectedLength) {
        if (_responseCompleter != null && !_responseCompleter!.isCompleted) {
          _responseCompleter!.complete(Uint8List.fromList(_buffer.take(_expectedLength).toList()));
        }
      }
    });

    final response = await _responseCompleter!.future.timeout(
      const Duration(milliseconds: 500),
      onTimeout: () => Uint8List(0),
    );

    await _subscription?.cancel();

    if (response.isEmpty) throw Exception('No response from device');

    try {
      return ModbusRtuFrame.parseReadResponse(response);
    } catch (e) {
      debugPrint('[Modbus] Parse error: $e, raw: ${response.toList()}');
      rethrow;
    }
  }

  @override
  Future<bool> writeSingleRegister({
    required int slaveId,
    required int address,
    required int value,
  }) async {
    if (!_serial.isConnected) return false;
    final request = ModbusRtuFrame.buildWriteSingleRegister(
      slaveId: slaveId,
      address: address,
      value: value,
    );
    return _serial.write(request);
  }
}
