#!/bin/bash
# Count logged iptables commands that add firewall rules.
grep -Ec 'iptables.*[[:space:]](-A|-I|--append|--insert)[[:space:]]' "${1:-auth.log}"
