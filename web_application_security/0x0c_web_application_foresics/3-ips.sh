#!/bin/bash
# Count unique IP addresses with successful SSH logins.
awk '/sshd.*Accepted / {
    for (i = 1; i < NF; i++)
        if ($i == "from")
            print $(i + 1)
}' "${1:-auth.log}" | sort -u | wc -l
