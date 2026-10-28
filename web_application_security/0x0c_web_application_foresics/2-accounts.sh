#!/bin/bash
# Find accounts with a failed SSH password login followed by success.
tail -n 1000 "${1:-auth.log}" | awk '
/sshd.*Failed password for/ && $9 != "invalid" {
    failed[$9, $11] = 1
}
/sshd.*Accepted password for/ {
    if (failed[$9, $11] && !printed[$9]++)
        print $9
}'





 





