import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/modbus_registers.dart';
import '../../../data/datasources/serial_port_service.dart';
import '../../../data/models/vfd_data.dart';
import '../../../data/repositories/vfd_repository_impl.dart';
import '../../../domain/repositories/vfd_repository.dart';

// ─── Providers ───

final serialPortServiceProvider = Provider<SerialPortService>((ref) {
  return SerialPortService();
});

final vfdRepositoryProvider = Provider<VfdRepository>((ref) {
  final serial = ref.watch(serialPortServiceProvider);
  return VfdRepositoryImpl(serial: serial);
});

// ─── VFD Data Stream Provider ───

final vfdDataProvider = StreamProvider<VfdData>((ref) {
  final repository = ref.watch(vfdRepositoryProvider);
  ref.onDispose(() => repository.disconnect());
  return _pollVfdData(repository);
});

Stream<VfdData> _pollVfdData(VfdRepository repository) async* {
  final connected = await repository.connect(AppConstants.defaultPort);

  if (!connected) {
    yield VfdData.initial().copyWith(isConnected: false);
    return;
  }

  await for (final _ in Stream.periodic(
    Duration(milliseconds: AppConstants.pollingIntervalMs),
  )) {
    VfdData data;
    try {
      data = await _readAllRegisters(repository);
    } catch (e) {
      data = VfdData.initial().copyWith(isConnected: false);
    }
    yield data;
  }
}

Future<VfdData> _readAllRegisters(VfdRepository repository) async {
  final slaveId = AppConstants.slaveId;

  // ─── Read each register individually (more reliable) ───

  List<int> reg(int addr, [int count = 1]) => repository.readHoldingRegisters(
    slaveId: slaveId, startAddress: addr, count: count,
  ) as List<int>? ?? [];

final freqRegs = await repository.readHoldingRegisters(
slaveId: slaveId, startAddress: ModbusRegisters.outputFreqAddr, count: 1,
);
final voltRegs = await repository.readHoldingRegisters(
slaveId: slaveId, startAddress: ModbusRegisters.outputVoltageAddr, count: 1,
);
final currRegs = await repository.readHoldingRegisters(
slaveId: slaveId, startAddress: ModbusRegisters.outputCurrentAddr, count: 1,
);
final powrRegs = await repository.readHoldingRegisters(
slaveId: slaveId, startAddress: ModbusRegisters.motorPowerAddr, count: 1,
);
final hourRegs = await repository.readHoldingRegisters(
slaveId: slaveId, startAddress: ModbusRegisters.cumOpTimeAddr, count: 1,
);

final freq = freqRegs.isNotEmpty ? freqRegs[0] / 100.0 : 0.0;
final voltage = voltRegs.isNotEmpty ? voltRegs[0] / 10.0 : 0.0;
final current = currRegs.isNotEmpty ? currRegs[0].toDouble() : 0.0;
final power = powrRegs.isNotEmpty ? powrRegs[0].toDouble() : 0.0;
final hour = hourRegs.isNotEmpty ? hourRegs[0] : 0;

return VfdData(
  frequency: freq,
  voltage: voltage,
  current: current,
  power: power,
  hourmeter: hour,
  isConnected: true,
);
}
