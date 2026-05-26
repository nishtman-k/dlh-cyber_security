#!/bin/bash
find / -type d -perm -o+w 2>/dev/null -exec echo {} \; -exec chmod go-w {} \;
