#!/bin/bash

source ${ROS_WS}/devel/setup.bash

roscore &
roslaunch --wait rvizweb rvizweb.launch &

jupyter lab workspaces import  ${REPO_DIR}/binder/jupyterlab-workspace.json

# Start the LLAMAINDEX server
npm run build
npm run start &

# # Use xvfb virtual display when there is no display connected.
# if [ -n "$DISPLAY" ] && [ "$DISPLAY" != ":100" ]; then
#     exec "$@"
# else
xvfb-run exec "$@"
# fi