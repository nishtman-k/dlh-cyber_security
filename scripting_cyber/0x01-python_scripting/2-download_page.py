#!/usr/bin/env python3
"""Module docstring"""
import requests
from bs4 import BeautifulSoup


def download_page(url):
    try:
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        return soup.prettify()
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"


if __name__ == "__main__":
    import sys
    url = sys.argv[1]
    print(download_page(url))
