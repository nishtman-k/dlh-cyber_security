#!/usr/bin/env python3
"""Module docstring"""
import socket


def resolve_domain_to_ipv4(domain: str):
    try:
        ipv4 = socket.gethostbyname(domain)
        print(ipv4)
    except socket.gaierror:
        print(" ")


if __name__ == "__main__":
    domains = [
        "holbertonschool.com",
        "google.com",
        "github.com",
        "example.com",
        "this-is-not-a-site.com",
    ]
    for d in domains:
        resolve_domain_to_ipv4(d)
