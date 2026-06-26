"""
FRENIC-MEGA Modbus RTU Simulator — Manual Serial, Data Dinamis
"""
import time, math, struct, serial

PORT = 'COM15'
BAUDRATE = 9600
SLAVE_ID = 1

# --- Register map (initial values) ---
registers = {
    0x0809: 3000,  # M09 — Output Frequency (0.01 Hz)
    0x080C: 4000,  # M12 — Output Voltage   (0.1 V)
    0x0905: 12,    # W05 — Output Current   (A)
    0x0916: 3,     # W22 — Motor Power      (kW)
    0x0814: 1234,  # M20 — Hourmeter        (h)
}

def crc16(data: bytes) -> int:
    crc = 0xFFFF
    for byte in data:
        crc ^= byte
        for _ in range(8):
            if crc & 0x0001:
                crc = (crc >> 1) ^ 0xA001
            else:
                crc >>= 1
    return crc

def build_response(slave: int, values: list[int]) -> bytes:
    """Build Modbus RTU response frame for FC=0x03."""
    data = struct.pack(f'>{len(values)}H', *values)
    frame = bytes([slave, 0x03, len(data)]) + data
    crc = crc16(frame)
    return frame + struct.pack('<H', crc)

def handle_request(frame: bytes) -> bytes | None:
    """Parse and respond to Modbus RTU Read Holding Registers (FC 0x03)."""
    if len(frame) < 8:
        return None
    slave, func, addr_h, addr_l, cnt_h, cnt_l = frame[:6]
    if slave != SLAVE_ID or func != 0x03:
        return None
    if crc16(frame[:-2]) != struct.unpack('<H', frame[-2:])[0]:
        return None

    addr = (addr_h << 8) | addr_l
    count = (cnt_h << 8) | cnt_l
    values = [registers.get(addr + i, 0) for i in range(count)]
    return build_response(slave, values)

# --- Main ---
ser = serial.Serial(PORT, BAUDRATE, timeout=0.1)
print(f"\n  FRENIC-MEGA Simulator (manual serial, data DINAMIS)")
print(f"  Listening: {PORT} @ {BAUDRATE} 8N1\n")

t = 0
while True:
    # ── Update register values every ~100 ms ──
    registers[0x0809] = int(3000 + 500 * math.sin(t * 0.1))
    registers[0x080C] = int(3800 + 200 * math.sin(t * 0.12))
    registers[0x0905] = max(0, int(12 + 5 * math.sin(t * 0.1)))
    registers[0x0916] = max(0, int(3 + 2 * math.sin(t * 0.08)))
    registers[0x0814] = 1234 + (t // 200)   # hourmeter (≈ 2 s per tick)

    # Print status every 100 loops (≈10 s)
    if t % 100 == 0:
        print(f"[{time.strftime('%H:%M:%S')}] "
              f"Freq={registers[0x0809]/100:.2f} Hz  "
              f"V={registers[0x080C]/10:.1f} V  "
              f"I={registers[0x0905]} A  "
              f"P={registers[0x0916]} kW  "
              f"Hr={registers[0x0814]} h")
    t += 1

    # ── Handle incoming request ──
    if ser.in_waiting >= 8:
        raw = ser.read(ser.in_waiting)
        idx = raw.find(bytes([SLAVE_ID]))
        if idx != -1 and len(raw[idx:]) >= 8:
            frame = raw[idx:idx+8]
            resp = handle_request(frame)
            if resp:
                ser.write(resp)
                print(f"  Req: {frame.hex(' ')[:23]}  →  Res: {resp.hex(' ')}")

    time.sleep(0.1)
