/// FRENIC-MEGA Modbus Register Map
class ModbusRegisters {
  ModbusRegisters._();

  // ─── S-Codes (Command) ───
  static const int freqRefAddr = 0x0705; // S05: Freq ref (0.01Hz)

  // ─── M-Codes (Monitor) ───
  static const int outputFreqAddr = 0x0809; // M09: Output freq (0.01Hz)
  static const int outputVoltageAddr = 0x080C; // M12: Output volt (0.1V)

  // ─── W-Codes (Keypad Monitor) ───
  static const int outputCurrentAddr = 0x0905; // W05: Output current (A)
  static const int motorPowerAddr = 0x0916; // W22: Motor output (kW)
  static const int cumOpTimeAddr = 0x0946; // W70: Cum op time (h)

  // ─── Batch Read ───
  /// Example: read M09, M10, M11, M12 in one batch
  static const int monitorBatchStart = 0x0809;
  static const int monitorBatchCount = 4;

  /// Example: read W05, W06, W07, W08 in one batch
  static const int keypadBatchStart = 0x0905;
  static const int keypadBatchCount = 4;

  // ─── Data Formats ───
  static const double freqScale = 100.0; // M09 /100
  static const double voltageScale = 10.0; // M12 /10
  static const double currentScale = 1.0; // W05 raw
  static const double powerScale = 1.0; // W22 raw
  static const double hourScale = 1.0; // W70 raw
}
