#!/bin/bash
nmap -p 443,80 --script vuln $1
