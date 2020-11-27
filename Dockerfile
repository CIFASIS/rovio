FROM ros:kinetic-perception

ENV ROS_VERSION=kinetic
ENV CATKIN_WS=/root/catkin_ws ROVIO_ROOT=/root/catkin_ws/src/rovio/
RUN   apt-get update && \
      apt-get install python-catkin-tools python-setuptools --yes && \
      rm -rf /var/lib/apt/lists/*

COPY ./ $ROVIO_ROOT/

# Build rovio
WORKDIR $CATKIN_WS
COPY ./scripts/ $CATKIN_WS
RUN ["/bin/bash", "-c", "chmod +x build.sh && chmod +x modify_entrypoint.sh && sync && ./build.sh && ./modify_entrypoint.sh"]
