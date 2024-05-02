FROM python:3.11-slim

WORKDIR /app

RUN apt update
RUN apt install -y --no-install-recommends git
# RUN apk update
# RUN apk add git build-base linux-headers
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/*
# RUN rm -rf /var/cache/apk/* /tmp/*

# Hikka specific settings
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet

# Python specific settings
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# User customizable settings
ENV BRANCH=master

COPY entrypoint.sh /entrypoint.sh
CMD ["sh", "/entrypoint.sh"]
EXPOSE 8080
