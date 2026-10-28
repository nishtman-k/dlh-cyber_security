#!/bin/bash
# Extract the operating system and kernel information.
grep -m 1 'Linux version' "${1:-dmesg}"
