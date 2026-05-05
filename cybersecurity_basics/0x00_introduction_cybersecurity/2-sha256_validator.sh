#!/bin/bash
echo "$1: $(sha256sum "$1" | awk -v h="$2" '{print ($1==h)?"OK":"FAILED"}')"
