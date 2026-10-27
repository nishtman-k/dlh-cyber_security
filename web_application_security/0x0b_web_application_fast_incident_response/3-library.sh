#!/bin/bash
# Print the attacker's most common User-Agent.
log="${1:-logs.txt}"

attacker=$(awk '{print $1}' "$log" | sort | uniq -c | sort -nr | awk 'NR==1 {print $2}')

awk -v ip="$attacker" '$1 == ip' "$log" |
    awk -F '"' '{print $6}' |
    sort | uniq -c | sort -nr |
    sed -n '1s/^[[:space:]]*[0-9]*[[:space:]]*//p'
