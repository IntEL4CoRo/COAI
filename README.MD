# Research Lab for Household Transportation tasks

Research Lab for Household Transportation tasks.

> Note: This branch copied a ROS workspace contain CRAM under commit [6f009f71b36bdf6c1fc58d61f151a0c78f4b68db](https://github.com/cram2/cram/tree/6f009f71b36bdf6c1fc58d61f151a0c78f4b68db) from Arthur's docker image [arthurniedz/cram:devel](https://hub.docker.com/layers/arthurniedz/cram/devel/images/sha256-5f41d9ce7cff175101f71b34f385b9ec35ee3033f1fb3c87e3fcca0a937abedf?context=explore), the following demos can not run on a newer CRAM version:
>
> - making popcorn demo under LISP package (cram-pr2-popcorn-demo > with-simulated-robot)
> - retail under LISP package (cram-projection-demos > retail-demo)

Binderhub Addresses:
- Popcorn-making:https://binder.intel4coro.de/v2/gh/IntEL4CoRo/COAI/legacy?urlpath=lab%2Ftree%2Fnotebooks%2Fpopcorn.ipynb

- Retail-demo: 
  - PR2: https://binder.intel4coro.de/v2/gh/IntEL4CoRo/COAI/legacy?urlpath=lab%2Ftree%2Fnotebooks%2Fretail.ipynb?robot=pr2
  - Donbot: https://binder.intel4coro.de/v2/gh/IntEL4CoRo/COAI/legacy?urlpath=lab%2Ftree%2Fnotebooks%2Fretail.ipynb?robot=donbot

## Development

### Test Image Locally (Under repo directory)

- Build and run docker image:

  ```bash
  docker compose -f ./binder/docker-compose.yml up --build
  ```

  or

  Build and run with X-forwarding (The pybullet debug window open as a desktop display):

  ```bash
  xhost +local:docker && \
  docker compose -f ./binder/docker-compose.yml up --build && \
  xhost -local:docker
  ```

- Open Web browser and go to http://localhost:8888/

- To stop and remove container:

  ```bash
  docker compose -f ./binder/docker-compose.yml down
  ```
