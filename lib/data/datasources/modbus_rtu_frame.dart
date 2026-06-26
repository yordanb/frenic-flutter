import 'dart:math';
import 'dart:typed_data';

/// MODBUS RTU Frame Builder & CRC16 Calculator
class ModbusRtuFrame {
  /// CRC16-IBM / MODBUS: polynomial 0xA001
  static int _crc16(Uint8List data) {
    int crc = 0xFFFF;
    for (final byte in data) {
      crc ^= byte;
      for (int i = 0; i < 8; i++) {
        if ((crc & 0x0001) != 0) {
          crc = (crc >> 1) ^ 0xA001;
        } else {
          crc >>= 1;
        }
      }
    }
    return crc;
  }

  /// Build Modbus RTU frame with CRC16 appended (little-endian CRC)
  static Uint8List buildFrame(Uint8List data) {
    final crc = _crc16(data);
    final result = Uint8List(data.length + 2);
    result.setAll(0, data);
    result[data.length] = crc & 0xFF; // CRC low byte
    result[data.length + 1] = (crc >> 8) & 0xFF; // CRC high byte
    return result;
  }

  /// Validate CRC16 on received frame. Returns true if valid.
  static bool validateFrame(Uint8List frame) {
    if (frame.length < 4) return false; // Min: addr(1)+fc(1)+crc(2)
    final data = frame.sublist(0, frame.length - 2);
    final expectedCrc = _crc16(data);
    final receivedCrc = (frame[frame.length - 2]) | (frame[frame.length - 1] << 8);
    return expectedCrc == receivedCrc;
  }

  // ─── Read Holding Registers (FC 0x03) ───

  /// Build request: [slaveId, 0x03, startAddrHi, startAddrLo, countHi, countLo]
  static Uint8List buildReadHoldingRegisters({
    required int slaveId,
    required int startAddress,
    int count = 1,
  }) {
    final data = Uint8List(6);
    data[0] = slaveId;
    data[1] = 0x03;
    data[2] = (startAddress >> 8) & 0xFF;
    data[3] = startAddress & 0xFF;
    data[4] = (count >> 8) & 0xFF;
    data[5] = count & 0xFF;
    return buildFrame(data);
  }

  /// Parse response: [slaveId, 0x03, byteCount, dataHi, dataLo, ..., crcLo, crcHi]
  /// Returns list of 16-bit register values
  static List<int> parseReadResponse(Uint8List response) {
    if (response.length < 5) return [];
    if (!validateFrame(response)) {
      throw Exception('CRC validation failed');
    }
    final byteCount = response[2];
    final values = <int>[];
    for (int i = 0; i < byteCount; i += 2) {
      final hi = response[3 + i];
      final lo = response[4 + i];
      values.add((hi << 8) | lo);
    }
    return values;
  }

  // ─── Preset Single Register (FC 0x06) ───

  /// Build request: [slaveId, 0x06, addrHi, addrLo, valueHi, valueLo]
  static Uint8List buildWriteSingleRegister({
    required int slaveId,
    required int address,
    required int value,
  }) {
    final data = Uint8List(6);
    data[0] = slaveId;
    data[1] = 0x06;
    data[2] = (address >> 8) & 0xFF;
    data[3] = address & 0xFF;
    data[4] = (value >> 8) & 0xFF;
    data[5] = value & 0xFF;
    return buildFrame(data);
  }
}
