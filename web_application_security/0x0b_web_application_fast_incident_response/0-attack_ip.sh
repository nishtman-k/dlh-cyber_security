#!/bin/bash
# Print the IP address with the most requests.
awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | awk 'NR==1 {print $2}'
