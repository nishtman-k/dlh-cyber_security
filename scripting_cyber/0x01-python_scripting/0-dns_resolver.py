#!/usr/bin/env python3
"""Module docstring"""
from socket import gethostbyname, gaierror


def resolve_domain_to_ipv4(domain: str):
    try:
        ipv4 = gethostbyname(domain)
        print(ipv4)
    except gaierror:
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
