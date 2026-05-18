#!/bin/bash
john --wordlist=rockyou.txt --format=NT "$1"
john --show --format=NT "$1" | grep ':' | cut -d: -f2 > 5-password.txt
