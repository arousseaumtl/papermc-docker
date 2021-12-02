#!/bin/sh

java -jar $(ls *.jar | python -c 'import sys; print(sorted(sys.stdin, reverse=True)[0].strip())')
