#!/bin/bash
sed '$!N; /^\(.*\)\n\1$/!P; D' "$1" > "$1.tmp"
mv "$1.tmp" "$1"
