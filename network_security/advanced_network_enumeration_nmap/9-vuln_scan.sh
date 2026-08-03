#!/bin/bash
nmap --script vulners "http-vuln-cve2017-5638" $1 -oN vuln_scan_results.txt
