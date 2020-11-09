#!/bin/bash

catkin init
catkin config --merge-devel
catkin config --extend /opt/ros/kinetic
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build rovio