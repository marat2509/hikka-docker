FROM python:3.10-slim

WORKDIR /app
COPY entrypoint.sh /entrypoint.sh

RUN apt update
RUN apt install -y --no-install-recommends git build-essential python3-dev
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

ENTRYPOINT ["bash", "/entrypoint.sh"]
EXPOSE ${PORT}
