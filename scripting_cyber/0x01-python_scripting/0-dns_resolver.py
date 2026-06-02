#!/usr/bin/env python3
"""Module docstring"""
import socket


def resolve_domain_to_ipv4(domain: str):
    try:
        ipv4 = socket.gethostbyname(domain)
        return ipv4
    except socket.gaierror:
        return None


if __name__ == "__main__":

    print("DNS Resolver Test")
    print("=" * 60)

    domains = [
        "holbertonschool.com",
        "google.com",
        "github.com",
        "example.com",
        "this-is-not-a-site.com",
    ]

    for domain in domains:
        result = resolve_domain_to_ipv4(domain)
        if result:
            print(f"{domain:40} -> {result}")
        else:
            print(f"{domain:40} -> Failed to resolve")

    print("=" * 60)
