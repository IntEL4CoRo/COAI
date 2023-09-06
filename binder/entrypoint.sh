#!/bin/bash

source ${HOME}/workspace/ros/devel/setup.bash

roscore &
roslaunch --wait rvizweb rvizweb.launch &

jupyter lab workspaces import ${HOME}/.binder/workspace.json

# Use xvfb virtual display when there is no display connected.
if [ -n "$DISPLAY" ]; then
    exec "$@"
else
    xvfb-run exec "$@"
fi