#!/bin/bash
nmap -p 443,80 --script "vulners" $1
