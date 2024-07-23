# Hikka for Docker Image

## Overview

[Hikka](https://github.com/hikariatama/Hikka) is a powerful and efficient userbot. This repository provides the necessary configuration and instructions to build and deploy the Hikka userbot using Docker.

## Usage

### Directly from `docker run`

To run the Hikka Docker image, use the following command:

```sh
docker run -p 8080:8080 ghcr.io/marat2509/hikka-docker
```

### Using Docker Compose

1. Ensure you have Docker Compose installed. [Install Docker Compose](https://docs.docker.com/compose/install/)
1. Start the services defined in compose.yaml file:

    ```shell
    docker-compose up -d
    ```

1. To stop the services:

    ```shell
    docker-compose down
    ```

## Building the Docker image

If you need to build the Docker image, use the following steps:

1. Clone the repository:

    ```shell
    git clone https://github.com/marat2509/hikka-docker.git
    ```

1. Build the Docker image:

    ```shell
    docker build -t hikka-docker .
    ```

1. Run the Docker container:

    ```shell
    docker run -p 8080:8080 hikka-docker
    ```

## Configuration

Configuration options can be set using environment variables. Here are some of the common configuration options:

- `USE_VENV`: Set to `true` to use a virtual environment within the container. (default: `true`)
- `BRANCH`: Specify the branch of the Hikka repository to clone (default: `main`).

## License

This project is licensed under the GNU General Public License - see the [LICENSE.md](/LICENSE.md) file.

