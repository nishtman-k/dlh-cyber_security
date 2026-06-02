#!/usr/bin/env python3
"""Module docstring"""
import socket


def check_port(host, port):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(2)
        result = s.connect_ex((host, port))
        s.close()
        return result == 0
    except socket.error:
        return False


if __name__ == "__main__":
    import sys

    if len(sys.argv) != 3:
        print("Usage: python3 5-port_scanner.py <host> <port>")
        sys.exit(1)

    host = sys.argv[1]
    port = int(sys.argv[2])

    status = "OPEN" if check_port(host, port) else "CLOSED"
    print(f"Port {port} on {host}: {status}")
