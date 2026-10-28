#!/bin/bash
# Count authentication log messages.
awk '{print $6}' "${1:-auth.log}" | sort | uniq -c | sort -nr
