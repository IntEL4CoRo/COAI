#!/bin/bash

source ${HOME}/workspace/ros/devel/setup.bash

roscore &
roslaunch --wait rvizweb rvizweb.launch &

jupyter lab workspaces import  ${REPO_DIR}/binder/jupyterlab-workspace.json

exec "$@"