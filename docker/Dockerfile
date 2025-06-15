FROM python:3.10-slim

ENV PIP_NO_CACHE_DIR=1

RUN apt update
RUN apt install -y --fix-missing --no-install-recommends --no-install-suggests git build-essential libmagic1 python3-dev gcc curl libcairo2 ffmpeg libmagic1 libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev neofetch wkhtmltopdf
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/*

# Hikka specific settings
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet

# Python specific settings
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

COPY scripts/entrypoint.sh /docker/entrypoint.sh
COPY scripts/util_functions.sh /docker/util_functions.sh
CMD ["bash", "/docker/entrypoint.sh"]
EXPOSE 8080
