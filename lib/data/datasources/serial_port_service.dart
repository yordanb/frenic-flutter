import "dart:async";
import "dart:typed_data";
import "package:usb_serial/usb_serial.dart";
import "package:flutter/foundation.dart";

class SerialPortService {
  UsbPort? _port;
  bool _isOpen = false;

  bool get isConnected => _isOpen;

  Future<bool> connect({required String portName}) async {
    try {
      List<UsbDevice> devices = await UsbSerial.listDevices();
      debugPrint("[USB] Found ${devices.length} device(s)");

      if (devices.isEmpty) {
        debugPrint("[USB] No USB serial devices found");
        return false;
      }

      // Log all found devices
      for (var d in devices) {
        debugPrint("[USB] Device: vid=${d.vid} pid=${d.pid} name=${d.deviceName}");
      }

      // Try to find FTDI (0x0403) or CH340 (0x1a86) first
      UsbDevice? target;
      for (var dev in devices) {
        if (dev.vid == 0x0403 || dev.vid == 0x1a86) {
          target = dev;
          debugPrint("[USB] Matched FTDI/CH340 device");
          break;
        }
      }

      // Fallback to first device
      target ??= devices[0];
      debugPrint("[USB] Using device: ${target.deviceName}");

      _port = await target.create();
      if (_port == null) {
        debugPrint("[USB] Failed to create port");
        return false;
      }

      bool opened = await _port!.open();
      if (!opened) {
        debugPrint("[USB] Failed to open port (permission denied?)");
        return false;
      }

      await _port!.setDTR(true);
      await _port!.setRTS(true);
      await _port!.setPortParameters(
        9600,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      _isOpen = true;
      debugPrint("[USB] Connected successfully @ 9600 8N1");
      return true;
    } catch (e) {
      debugPrint("[USB] Connect error: $e");
      _isOpen = false;
      return false;
    }
  }

  Future<bool> write(Uint8List data) async {
    if (!_isOpen || _port == null) return false;
    try {
      await _port!.write(data);
      return true;
    } catch (e) {
      debugPrint("[USB] Write error: $e");
      return false;
    }
  }

  Stream<Uint8List>? get inputStream {
    if (_port == null) return null;
    return _port!.inputStream;
  }

  Future<void> disconnect() async {
    try {
      if (_port != null) await _port!.close();
    } catch (_) {}
    _isOpen = false;
    debugPrint("[USB] Disconnected");
  }
}
