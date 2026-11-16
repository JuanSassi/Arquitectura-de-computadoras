#!/usr/bin/env python3
"""Cliente de prueba para la ALU por UART (Basys3, 19200 8N1).

Protocolo: se envian 3 bytes [A][B][OP] y la FPGA responde 1 byte = A (op) B.

Requiere pyserial:   pip install pyserial

Ejemplos:
    python alu_uart_client.py COM4 --op ADD --a 100 --b 27
    python alu_uart_client.py COM4 --selftest        # prueba todas las operaciones con valores al azar
"""
import argparse
import random
import sys

try:
    import serial
except ImportError:
    sys.exit("Falta pyserial: pip install pyserial")

OPS = {
    "ADD": 0b100000, "SUB": 0b100010, "AND": 0b100100, "OR": 0b100101,
    "XOR": 0b100110, "NOR": 0b100111, "SRL": 0b000010, "SRA": 0b000011,
}


def model(op, a, b):
    """Modelo de referencia de la ALU de 8 bits (mismo criterio que alu.v del TP1)."""
    sh = a & 0x7
    signed_b = b - 256 if b & 0x80 else b
    return {
        "ADD": (a + b) & 0xFF,
        "SUB": (a - b) & 0xFF,
        "AND": a & b,
        "OR": a | b,
        "XOR": a ^ b,
        "NOR": ~(a | b) & 0xFF,
        "SRL": b >> sh,
        "SRA": (signed_b >> sh) & 0xFF,
    }[op]


def run(ser, op, a, b):
    ser.reset_input_buffer()
    ser.write(bytes([a & 0xFF, b & 0xFF, OPS[op]]))
    resp = ser.read(1)
    if len(resp) != 1:
        raise TimeoutError("la FPGA no respondio (revisar puerto, reset y baudrate)")
    return resp[0]


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("port", help="puerto serie, ej. COM4 o /dev/ttyUSB1")
    ap.add_argument("--baud", type=int, default=19200)
    ap.add_argument("--op", choices=OPS.keys())
    ap.add_argument("--a", type=lambda x: int(x, 0))
    ap.add_argument("--b", type=lambda x: int(x, 0))
    ap.add_argument("--selftest", action="store_true")
    args = ap.parse_args()

    with serial.Serial(args.port, args.baud, timeout=1.0) as ser:
        if args.selftest:
            bad = 0
            for op in OPS:
                for _ in range(20):
                    a, b = random.randrange(256), random.randrange(256)
                    got, exp = run(ser, op, a, b), model(op, a, b)
                    if got != exp:
                        bad += 1
                        print(f"FALLO {op} a={a} b={b}: recibido {got}, esperado {exp}")
            print("selftest OK" if bad == 0 else f"selftest con {bad} errores")
        else:
            if args.op is None or args.a is None or args.b is None:
                ap.error("indicar --op, --a y --b (o usar --selftest)")
            res = run(ser, args.op, args.a, args.b)
            print(f"{args.a} {args.op} {args.b} = {res} (0x{res:02X}, esperado {model(args.op, args.a & 0xFF, args.b & 0xFF)})")


if __name__ == "__main__":
    main()
