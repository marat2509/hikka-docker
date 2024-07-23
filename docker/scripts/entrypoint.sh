#!/bin/bash

. /docker/util_functions.sh

if [ "$USE_VENV" = "true" ]; then
    if [ ! -e "/venv/version" ]; then
        rm -rf /venv/*
        create_venv
    fi

    if [ $(python_version) != `cat /venv/version` ]; then
        rm -rf /venv/*
        create_venv
    fi

    . /venv/bin/activate
fi

if [ ! -e "/app/.git" ]; then
    git clone https://github.com/hikariatama/Hikka -b $BRANCH --depth=1 /app
fi

python3 -m hikka
