#!/usr/bin/env python3
"""Bateria de pruebas en hardware (Basys3 programada con uart_alu_top).

    python hw_test.py COM3

Pruebas: dirigidas, aleatorias por operacion, op invalida, bits altos de OP,
comando partido en pausas, rafagas sin esperar respuesta y estres.
"""
import random
import sys
import time

import serial

from alu_uart_client import OPS, model

errors = 0
checks = 0


def check(name, got, exp):
    global errors, checks
    checks += 1
    if got != exp:
        errors += 1
        print(f"  FALLO {name}: recibido {got!r}, esperado {exp!r}")


def cmd(ser, a, b, opbyte):
    ser.write(bytes([a & 0xFF, b & 0xFF, opbyte & 0xFF]))


def read_n(ser, n):
    return list(ser.read(n))


def main():
    port = sys.argv[1] if len(sys.argv) > 1 else "COM3"
    random.seed(1234)
    with serial.Serial(port, 19200, timeout=2.0) as ser:
        ser.reset_input_buffer()

        print("1) Dirigidas (una por operacion)")
        directed = [
            ("ADD", 100, 27), ("ADD", 200, 100), ("ADD", 255, 1), ("SUB", 5, 10), ("SUB", 0, 0),
            ("AND", 0xF0, 0x3C), ("OR", 0xF0, 0x0F), ("XOR", 0xFF, 0x0F), ("NOR", 0xF0, 0x0F),
            ("SRL", 3, 0xF0), ("SRA", 3, 0xF0), ("SRA", 3, 0x70), ("SRL", 8, 0xFF), ("SRA", 7, 0x80),
        ]
        for op, a, b in directed:
            cmd(ser, a, b, OPS[op])
            check(f"{a} {op} {b}", read_n(ser, 1), [model(op, a, b)])

        print("2) Valores extremos para todas las operaciones")
        for op in OPS:
            for a, b in [(0, 0), (0xFF, 0xFF), (0x80, 0x7F), (0x7F, 0x80), (1, 0xFF)]:
                cmd(ser, a, b, OPS[op])
                check(f"{a} {op} {b}", read_n(ser, 1), [model(op, a, b)])

        print("3) Codigo de operacion invalido -> 0x00; bits altos de OP se ignoran")
        for bad in (0x00, 0x01, 0x3F, 0x21, 0x28):
            cmd(ser, 12, 34, bad)
            check(f"op invalida {bad:#04x}", read_n(ser, 1), [0])
        cmd(ser, 7, 8, 0xE0 | OPS["ADD"])
        check("op 0xE0|ADD (bits altos ignorados)", read_n(ser, 1), [15])

        print("4) Comando enviado en pausas (byte a byte, sin respuesta hasta el ultimo)")
        ser.write(bytes([40])); time.sleep(0.2)
        ser.write(bytes([2])); time.sleep(0.2)
        check("sin respuesta con 2 de 3 bytes", read_n(ser, 1), [])
        ser.write(bytes([OPS["SUB"]]))
        check("40 SUB 2 al completar", read_n(ser, 1), [38])

        print("5) Aleatorias: 100 por operacion, de a una")
        for op in OPS:
            for _ in range(100):
                a, b = random.randrange(256), random.randrange(256)
                cmd(ser, a, b, OPS[op])
                check(f"{a} {op} {b}", read_n(ser, 1), [model(op, a, b)])

        print("6) Rafagas: 8 comandos (24 bytes) de una sola vez, respuestas en orden")
        for _ in range(20):
            batch = [(random.choice(list(OPS)), random.randrange(256), random.randrange(256)) for _ in range(8)]
            ser.write(b"".join(bytes([a, b, OPS[op]]) for op, a, b in batch))
            check("rafaga de 8", read_n(ser, 8), [model(op, a, b) for op, a, b in batch])

        print("7) Estres: 2000 comandos en tandas de 12 (36 bytes), mas que la FIFO de 16 bytes")
        total = 0
        t0 = time.time()
        for _ in range(167):
            batch = [(random.choice(list(OPS)), random.randrange(256), random.randrange(256)) for _ in range(12)]
            ser.write(b"".join(bytes([a, b, OPS[op]]) for op, a, b in batch))
            check("tanda de 12", read_n(ser, 12), [model(op, a, b) for op, a, b in batch])
            total += 12
        print(f"   {total} comandos en {time.time() - t0:.1f} s")

        extra = ser.read(1)
        check("sin bytes sobrantes al final", list(extra), [])

    print(f"\nRESULTADO: {'PASO' if errors == 0 else 'FALLO'} ({checks} chequeos, {errors} errores)")
    sys.exit(1 if errors else 0)


if __name__ == "__main__":
    main()
