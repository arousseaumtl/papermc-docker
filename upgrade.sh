#!/bin/sh

if docker images 2>&1 | grep -q 'papermc'; then docker run -it papermc /srv/papermc/compile.sh; else docker build .; fi
