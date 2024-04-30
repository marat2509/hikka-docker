#!/bin/bash

if [ ! -e "/app/Hikka" ] ; then
    cd /app
    git clone https://github.com/hikariatama/Hikka -b $BRANCH --depth=1
fi

if [ ! -e "/app/venv" ] ; then
    virtualenv /app/venv
fi

source /app/venv/bin/activate

cd /app/Hikka
python -m hikka
