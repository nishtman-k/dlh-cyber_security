#!/bin/bash
hashcat -m 0 -a 0 "$1" rockyou.txt
hashcat -m 0 "$1" --show | cut -d: -f2 > 7-password.txt
