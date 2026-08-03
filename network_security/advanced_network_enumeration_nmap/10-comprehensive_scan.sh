#!/bin/bash
nmap --script "http-vuln-cve2017-5638" --script "ssl-enum-ciphers" --script "ftp-anon" $1 -oN comprehensive_scan_results.txt
