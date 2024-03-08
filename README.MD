# Research Lab for Household Transportation tasks

Research Lab for Household Transportation tasks.

Binderhub Address:
[![Binder](https://binder.intel4coro.de/badge_logo.svg)](https://binder.intel4coro.de/v2/gh/IntEL4CoRo/COAI/dev?urlpath=lab%2Ftree%2Fnotebooks%2Fhousehold_pr2_setting_table.ipynb)

## Development

Versions of CRAM and Other ROS packages are define in:
https://raw.githubusercontent.com/cram2/cram/devel/cram-20.04-http.rosinstall

The dependencies of the common-lisp kernel:
[common-lisp-jupyter.rosinstall](./binder/common-lisp-jupyter.rosinstall) (copy from https://github.com/cram2/cram_teaching/tree/main/jupyter)

### Test Image Locally (Under repo directory)

- To make the current directory writable inside the jupyterlab:

  ```bash
  chmod -R g+w ./
  ```

- Build and run docker image:

  ```bash
  export GID=$(id -g) && \
  docker compose -f ./binder/docker-compose.yml up --build
  ```

  or

  Build and run with X-forwarding (The pybullet debug window open as a desktop display):

  ```bash
  export GID=$(id -g) && \
  xhost +local:docker && \
  docker compose -f ./binder/docker-compose.yml up --build && \
  xhost -local:docker
  ```

- Open Web browser and go to http://localhost:8888/

- To stop and remove container:

  ```bash
  docker compose -f ./binder/docker-compose.yml down
  ```
