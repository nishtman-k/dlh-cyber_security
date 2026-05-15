#!/bin/bash
password=$(openssl rand -base64 16)
echo -n "$1$password" | openssl dgst -sha512 > 3_hash.txt
