#!/bin/bash
set -e

. "/opt/ros/noetic/setup.bash"

# Only source workspace if it exists
if [ -f "${ROS_WS}/devel/setup.bash" ]; then
    . "${ROS_WS}/devel/setup.bash"
fi

exec "$@"