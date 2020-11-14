#!/bin/bash
# Generates a random password using only non-ambiguous alphanumeric characters
# Usage: genpasswd.sh [length]

length=16

if [[ -n "$1" ]]; then
  length="$1"
fi

head -c $(( 2 * $length)) /dev/urandom | base64 | sed -E 's/[^23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ]//g' | head -c $length

echo
