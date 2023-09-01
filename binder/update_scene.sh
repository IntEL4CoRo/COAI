#!/bin/bash

source ${HOME}/workspace/ros/devel/setup.bash

# Environment rosnodes to be killed
nodes=$(rosnode list)
# Nodes to be excluded from killing
exclude=("rosbridge_websocket" "roswww" "rosapi" "rosout", "ros_board")
for node in $nodes; do
  # Extract the node name
  node_name=${node##*/}

  # Check if the node should be excluded
  if [[ ! " ${exclude[@]} " =~ " ${node_name} " ]]; then
    # Kill the node
    rosnode kill $node_name
  fi
done

# Launch new rosnodes
REPO_CONFIG_PATH=${REPO_DIR}/binder
roslaunch ${REPO_CONFIG_PATH}/update_scene.launch  \
          launch_file:=${@} \
          config_path:=${REPO_CONFIG_PATH} &
          

# exec "$@"