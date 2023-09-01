# Running CRAM on BinderHub

## Quick Start

### Option 1: Run Image Locally (Under repo directory)

- Run Docker image with X-forwarding

  ```bash
  ./binder/run_local.sh
  ```

- Open Web browser and go to http://localhost:8888/

- Force rebuilding image

  ```bash
  docker build ./ -f ./binder/Dockerfile -t cramteaching:binderhub
  ```

### Option 2: Run on BinderHub

- Link to the binderhub: https://binder.intel4coro.de/v2/gh/IntEL4CoRo/cram_teaching.git/main

## Usage

## Files Descriptions

1. ***[Dockerfile](./Dockerfile):*** A Jupyterlab Docker image with cram installed.
1. ***[entrypoint.sh](./entrypoint.sh):*** Entrypoint of the docker image, start roscore and visualization tools.
1. ***[workspace.json](./iros.jupyterlab-workspace):*** Custom JupyterLab workspace.
1. ***[docker-compose.yml](./docker-compose.yml):*** For testing the docker image locally.
1. ***[run_local.sh](./run_local.sh):*** For testing the docker image locally.
