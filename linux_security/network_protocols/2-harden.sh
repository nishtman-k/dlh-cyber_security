#!/bin/bash
find / -type d -perm -o+w -print -exec chmod go-w {} \;
