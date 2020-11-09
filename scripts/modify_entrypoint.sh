#!/bin/bash
sed -i '/exec "$@"/i \
           source "/root/catkin_ws/devel/setup.bash"' /ros_entrypoint.sh