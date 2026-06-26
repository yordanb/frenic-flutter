# FRENIC-MEGA VFD Modbus RTU Dashboard

Flutter dashboard untuk monitoring VFD FRENIC-MEGA via USB-RS485 (Modbus RTU).  
Terintegrasi dengan Python Simulator untuk testing offline.

## Fitur

- **Real-time monitoring** — Frekuensi, Tegangan, Arus, Daya, Hourmeter
- **Modbus RTU via USB** — Komunikasi serial 9600 8N1 dengan FTDI/CH340
- **Trend chart** — Grafik pergerakan Frekuensi & Arus (60 titik)
- **Gauge card** — Visual semi-circular gauge untuk tiap parameter
- **Connection status** — Indikator koneksi hijau/merah
- **Auto-reconnect** — Polling otomatis tiap 2 detik
- **Dynamic simulator** — Python script untuk simulasi data VFD

## Arsitektur

```
┌──────────────┐      USB-RS485       ┌──────────────┐
│  Flutter App │◄────────────────────►│   VFD / Sim  │
│  (Android)   │     9600 8N1         │  (Python)    │
└──────────────┘                      └──────────────┘
```

### Stack

| Layer | Teknologi |
|-------|-----------|
| State | Flutter Riverpod (StreamProvider) |
| Serial | `usb_serial` (FTDI/CH340) |
| Modbus | Custom RTU frame builder + CRC16 |
| Chart | `fl_chart` (line chart) |
| Backend | Python simulator (pyserial) |

### Register Map (FRENIC-MEGA)

| Register | Address | Parameter | Scale | Unit |
|----------|---------|-----------|-------|------|
| M09      | 0x0809  | Output Freq | 0.01 | Hz |
| M12      | 0x080C  | Output Volt | 0.1  | V |
| W05      | 0x0905  | Output Current | 1 | A |
| W22      | 0x0916  | Motor Power | 1 | kW |
| M20      | 0x0814  | Hourmeter | 1 | h |

## Setup & Instalasi

### Prasyarat

- Flutter SDK ≥3.0
- Android device dengan **USB Host (OTG) support**
- Modul USB-RS485 (FTDI FT232 / CH340)
- Python 3.10+ (untuk simulator)

### Android App

```bash
# Clone
git clone git@github.com:yordanb/frenic-flutter.git
cd frenic-flutter

# Install dependencies
flutter pub get

# Build & install ke HP
flutter build apk --release
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

### Python Simulator

```bash
# Simulator dengan data dinamis (berubah setiap detik)
python vfd_sim_dinamis.py
```

Simulator akan menulis nilai sinusoida ke register yang dipoll oleh Flutter app.

### Koneksi Hardware

```
Laptop (Simulator) ─── USB-RS485 ─── kabel (A-B) ─── USB-RS485 ─── Android (Flutter App)
```

**Penting:**
- Pastikan kabel A(A+) ke A, B(B-) ke B
- Jumper GND antar converter untuk stabilitas sinyal
- Android harus klik **Allow** saat pop-up izin USB muncul
- Baudrate: 9600, 8 bit, None Parity, 1 Stop bit

## Struktur Project

```
lib/
├── main.dart
├── app/
│   └── app.dart                        # MaterialApp entry
├── core/
│   ├── constants/
│   │   ├── app_constants.dart          # Port, baudrate, timeout
│   │   └── modbus_registers.dart       # Register addresses
│   ├── theme/app_theme.dart
│   └── utils/logger.dart
├── data/
│   ├── datasources/
│   │   ├── serial_port_service.dart    # USB serial wrapper (usb_serial)
│   │   └── modbus_rtu_frame.dart       # Modbus frame builder + CRC16
│   ├── models/
│   │   ├── vfd_data.dart               # Data model (freezed)
│   │   └── modbus_register.dart
│   └── repositories/
│       └── vfd_repository_impl.dart     # Modbus polling logic
├── domain/
│   └── repositories/
│       └── vfd_repository.dart          # Abstract repository
└── presentation/
    ├── dashboard/
    │   ├── providers/
    │   │   └── vfd_provider.dart        # Riverpod stream provider
    │   ├── screens/
    │   │   └── dashboard_screen.dart    # Main UI
    │   └── widgets/
    │       ├── vfd_gauge_card.dart
    │       ├── vfd_chart.dart
    │       └── connection_status_bar.dart
    └── splash/
        └── screens/
            └── splash_screen.dart
```

## Debugging

### Cek koneksi USB di Android

```bash
# Cek device USB terdeteksi
adb shell ls /dev/tty*

# Lihat log Flutter
adb logcat -s "flutter"

# Cek log dari app
adb logcat -d -s "flutter" | tail -50
```

### Serial Terminal Test

Gunakan *Serial USB Terminal* di HP untuk kirim hex manual:

```
01 03 08 09 00 04 96 6B   # Baca M09-M12 (4 register)
```

Respon sukses: `01 03 08 0B B8 ...`

## Troubleshooting

| Gejala | Penyebab | Solusi |
|--------|----------|--------|
| Status Disconnected | Izin USB belum diberikan | Klik Allow di pop-up Android |
| Tidak ada data | Kabel terbalik | Tukar A/B di salah satu ujung |
| App crash di startup | ProviderScope hilang | Pastikan main() pakai ProviderScope |
| Data statis (tidak bergerak) | Simulator tidak update register | Jalankan `vfd_sim_dinamis.py` |

## License

MIT
