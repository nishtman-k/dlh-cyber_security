#!/bin/bash
sudo nmap -sM -vv -p 80,443,21,22,23 "$1"
