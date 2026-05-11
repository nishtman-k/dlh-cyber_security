#!/bin/bash
sudo find "$1" -perm -2000 -type f 2>/dev/null
