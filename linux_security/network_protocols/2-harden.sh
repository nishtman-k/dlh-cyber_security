#!/bin/bash
find / -xdev -type d -perm -o+w -print -exec chmod go-w {} \; 2>/dev/null
