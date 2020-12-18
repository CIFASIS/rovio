#!/bin/bash

catkin init
catkin config --merge-devel
catkin config --extend /opt/ros/kinetic
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -DROVIO_NCAM=2 -DSAVE_TIMES=ON
catkin build rovio
