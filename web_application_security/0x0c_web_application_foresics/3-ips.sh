#!/bin/bash
# Count unique IPs that successfully logged in as root.
awk '/sshd.*Accepted .* for root from / {
    for (i = 1; i < NF; i++)
        if ($i == "from")
            print $(i + 1)
}' "${1:-auth.log}" | sort -u | wc -l
