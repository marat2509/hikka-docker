# Hikka for Docker Image

## Overview

[Hikka](https://github.com/hikariatama/Hikka) is a powerful and efficient userbot. This repository provides the necessary configuration and instructions to build and deploy the Hikka userbot using Docker.

## Features

- **Automatic Repository Cloning**: Clones the Hikka repository (or any custom fork) on startup if not present.
- **Smart Virtual Environment Management**: Automatically creates and manages a Python virtual environment, recreating it if the Python version changes.
- **Dependency Management**: Automatically installs dependencies from `requirements.txt` upon startup.
- **Custom System Packages**: Allows installing additional system packages via environment variables.
- **Flexible Configuration**: Highly configurable behavior via environment variables.

## Usage

### Directly from `docker run`

To run the Hikka Docker image:

```sh
docker run -p 8080:8080 -v ./hikka_data:/app -v ./hikka_venv:/venv ghcr.io/marat2509/hikka-docker
```

### Using Docker Compose

1. Ensure you have Docker Compose installed. [Install Docker Compose](https://docs.docker.com/compose/install/)
2. Use the `compose.yaml` from the repository.
3. Start the services:

    ```shell
    docker compose up -d
    ```

4. To stop the services:

    ```shell
    docker compose down
    ```

## Configuration

Configuration options can be set using environment variables.

### Repository & Application

| Variable               | Description                                                    | Default                                |
| ---------------------- | -------------------------------------------------------------- | -------------------------------------- |
| `REPO_URL`             | URL of the repository to clone.                                | `https://github.com/hikariatama/Hikka` |
| `REPO_BRANCH`          | Branch to clone.                                               | `master`                               |
| `REPO_DEPTH`           | Depth for git clone (shallow clone).                           | `1`                                    |
| `APP_PATH`             | Directory where the application is stored and run.             | `/app`                                 |
| `APP_MODULE`           | Python module to start.                                        | `hikka`                                |
| `APT_INSTALL_PACKAGES` | Space-separated list of additional system packages to install. | *(empty)*                              |

### Environment & Python

| Variable    | Description                                         | Default |
| ----------- | --------------------------------------------------- | ------- |
| `USE_VENV`  | Enable or disable the use of a virtual environment. | `true`  |
| `VENV_PATH` | Path to the virtual environment.                    | `/venv` |

## Volumes

For persistence, it is recommended to mount the following volumes:

- **`/app`** (`APP_PATH`): Stores the application code and local data. Mounting this ensures that your session and configuration are saved.
- **`/venv`** (`VENV_PATH`): Stores the Python virtual environment. Mounting this speeds up container restarts by avoiding package reinstallation.

## Building the Docker Image

To build the image locally:

1. Clone this repository:

    ```shell
    git clone https://github.com/marat2509/hikka-docker.git
    cd hikka-docker
    ```

2. Build the Docker image:

    ```shell
    docker build -t hikka-docker .
    ```

3. Run the Docker container:

    ```shell
    docker run -p 8080:8080 hikka-docker
    ```

## License

This project is licensed under the GNU General Public License - see the [LICENSE.md](/LICENSE.md) file.
