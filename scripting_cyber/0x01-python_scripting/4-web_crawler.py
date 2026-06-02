#!/usr/bin/env python3
"""Module docstring"""
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse


def crawl_website(start_url, max_depth=2):
    visited = set()
    queue = [(start_url, 0)]
    start_domain = urlparse(start_url).netloc

    while queue:
        url, depth = queue.pop(0)
        if url not in visited and depth <= max_depth:
            try:
                response = requests.get(url)
                html = response.text
                visited.add(url)
                soup = BeautifulSoup(html, 'html.parser')

                if depth < max_depth:
                    for link in soup.find_all('a', href=True):
                        absolute_link = urljoin(url, link['href'])
                        link_domain = urlparse(absolute_link).netloc
                        if (link_domain == start_domain
                                and absolute_link not in visited):
                            queue.append((absolute_link, depth + 1))

                print(f"Crawled: {url}")

            except requests.RequestException as e:
                print(f"Failed to fetch {url}: {str(e)}")

    return visited


if __name__ == "__main__":
    import sys
    start_url = sys.argv[1]
    max_depth = int(sys.argv[2]) if len(sys.argv) > 2 else 2
    crawl_website(start_url, max_depth)
