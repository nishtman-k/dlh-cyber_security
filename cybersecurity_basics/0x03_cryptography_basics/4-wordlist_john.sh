john --wordlist=rockyou.txt --format=raw-md5 "$1"
john --show --format=raw-md5 "$1" | cut -d: -f2 > 4-password.txt
