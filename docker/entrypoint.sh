#!/bin/bash

if [ ! -e "/app/Hikka" ] ; then
    cd /app
    git clone https://github.com/hikariatama/Hikka -b $BRANCH --depth=1 /app
fi

python -m hikka
read -p