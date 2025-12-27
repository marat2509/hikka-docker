FROM python:3.10-slim

# Hikka specific settings
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet

# Python specific settings
ENV PIP_NO_CACHE_DIR=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100

# AIOHTTP specific settings
ENV AIOHTTP_NO_EXTENSIONS=1


RUN apt update
RUN apt install -y --fix-missing --no-install-recommends --no-install-suggests git build-essential libmagic1 python3-dev gcc curl libcairo2 ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/*

COPY scripts/entrypoint.sh /docker/entrypoint.sh
COPY scripts/util_functions.sh /docker/util_functions.sh

ENTRYPOINT ["bash", "/docker/entrypoint.sh"]

EXPOSE 8080
