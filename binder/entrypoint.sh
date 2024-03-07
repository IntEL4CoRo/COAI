#!/bin/bash

source ${HOME}/workspace/ros/devel/setup.bash

roscore &
roslaunch --wait rvizweb rvizweb.launch &

Use xvfb virtual display when there is no display connected.
if [ -n "$DISPLAY" ] && [ "$DISPLAY" != ":100" ]; then
    exec "$@"
else
xvfb-run exec "$@"
fi