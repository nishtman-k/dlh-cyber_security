#!/bin/bash
nmap -sV --open -A --script "banner,ssl-enum-ciphers,default,smb-enum-domains" $1 -oN service_enumeration_results.txt
