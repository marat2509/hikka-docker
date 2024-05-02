#!/bin/sh

if [ ! -e "/app/.git" ] ; then
    git clone https://github.com/hikariatama/Hikka -b $BRANCH --depth=1 /app
fi

python3 -m hikka
