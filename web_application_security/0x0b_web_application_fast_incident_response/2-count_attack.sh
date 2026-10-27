#!/bin/bash
# Print the highest number of requests from one IP.
awk '{print $1}' "${1:-logs.txt}" | sort | uniq -c | sort -nr | awk 'NR==1 {print $1}'
