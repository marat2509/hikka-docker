FROM python:3.11-slim

WORKDIR /app

RUN apt update
RUN apt install -y --no-install-recommends git gcc libc6-dev
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/*

# Hikka specific settings
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet

# Python specific settings
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# User customizable settings
ENV BRANCH=master
ENV USE_VENV=true

COPY scripts/entrypoint.sh /docker/entrypoint.sh
COPY scripts/util_functions.sh /docker/util_functions.sh
CMD ["bash", "/docker/entrypoint.sh"]
EXPOSE 8080
