/// Represents a single Modbus register read result
class ModbusRegister {
  final int address;
  final int value;

  const ModbusRegister({required this.address, required this.value});

  @override
  String toString() => 'M${address.toRadixString(16).padLeft(4, '0')} = $value';
}
