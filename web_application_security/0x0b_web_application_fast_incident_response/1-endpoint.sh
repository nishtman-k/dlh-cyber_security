#!/bin/bash
# Print the endpoint with the most requests.
awk '{print $7}' logs.txt | sort | uniq -c | sort -nr | awk 'NR==1 {print $2}'
