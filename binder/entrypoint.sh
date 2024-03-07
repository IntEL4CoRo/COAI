#!/bin/bash

source ${HOME}/workspace/ros/devel/setup.bash

roscore &
roslaunch --wait rvizweb rvizweb.launch &

# Create a symbolic link to the ROS workspace
ln -s ${ROS_WS} $PWD/ros_ws

# Use xvfb virtual display when there is no display connected.
if [ -n "$DISPLAY" ]; then
    exec "$@"
else
    xvfb-run exec "$@"
fi