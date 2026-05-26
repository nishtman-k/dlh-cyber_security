#!/bin/bash
hping3 -S "$1" -p 80 -c 3
