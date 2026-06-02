#!/usr/bin/env python3
"""Module docstring"""
import requests


def get_http_headers(url):
    try:
        response = requests.get(url)
        return {
            'status_code': response.status_code,
            'headers': dict(response.headers)
        }
    except requests.exceptions.RequestException:
        return None


if __name__ == "__main__":
    import sys
    url = sys.argv[1]
    result = get_http_headers(url)
    print(result)
