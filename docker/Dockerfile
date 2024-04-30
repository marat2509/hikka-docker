FROM python:3.12-slim

RUN pip install --upgrade pip
RUN apt update
RUN apt install -y --no-install-recommends git python3-pip git python3-dev python3-virtualenv libwebp-dev libz-dev libjpeg-dev libopenjp2-7 ffmpeg libffi-dev libcairo2 build-essential
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY entrypoint.sh /entrypoint.sh

# Hikka specific settings
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet

# Python specific settings
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# User customizable settings
ENV BRANCH=master

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE ${PORT}
