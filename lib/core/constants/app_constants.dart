class AppConstants {
  AppConstants._();

  // Serial Port — Android auto-detect via UsbSerial.listDevices()
  static const String defaultPort = 'USB/RS485';
  static const int defaultBaudrate = 9600;
  static const int defaultDataBits = 8;
  static const int defaultStopBits = 1;
  static const String defaultParity = 'none';
  static const int slaveId = 1;
  static const int readTimeoutMs = 500;
  static const int writeTimeoutMs = 200;
  static const int reconnectDelayMs = 3000;

  // Polling
  static const int pollingIntervalMs = 2000;

  // UI
  static const String appTitle = 'FRENIC-MEGA Dashboard';
  static const double cardMinHeight = 120;
  static const double gaugeSize = 140;
  static const int chartPointCount = 60;
}
