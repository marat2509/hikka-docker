#!/bin/bash

create_venv() {
    python3 -m venv /venv
    echo `python3 -c "import sys; print('.'.join(map(str, sys.version_info[:2])))"` > /venv/version
}

python_version() {
    python3 -c "import sys; print('.'.join(map(str, sys.version_info[:2])))"
}
