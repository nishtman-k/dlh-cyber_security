#!/bin/bash
# Extract newly created usernames, sort them, and join with commas.
sed -n 's/.*new user: name=\([^,]*\),.*/\1/p' "${1:-auth.log}" |
    LC_ALL=C sort -u |
    paste -sd ',' -
