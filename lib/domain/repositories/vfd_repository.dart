/// Abstract repository for VFD Modbus communication
abstract class VfdRepository {
  /// Connect to serial port
  Future<bool> connect(String portName, {int baudRate = 9600});

  /// Disconnect serial port
  Future<void> disconnect();

  /// Connection state
  bool get isConnected;

  /// Read holding registers via FC 0x03
  Future<List<int>> readHoldingRegisters({
    required int slaveId,
    required int startAddress,
    int count = 1,
  });

  /// Write single register via FC 0x06
  Future<bool> writeSingleRegister({
    required int slaveId,
    required int address,
    required int value,
  });
}
