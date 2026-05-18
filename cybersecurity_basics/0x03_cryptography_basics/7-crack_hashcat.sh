#!/bin/bash
hashcat -m 0 -a 0 "$1" rockyou.txt --outfile-format=2 -o 7-password.txt
