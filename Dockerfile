FROM osrf/ros:humble-desktop-jammy

RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws/src

ADD unitree_lidar_ros2/src/unitree_lidar_ros2 ./unitree_lidar_ros2/src/unitree_lidar_ros2
ADD unitree_lidar_sdk ./unitree_lidar_sdk

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /ros2_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /ros2_ws

RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    colcon build

RUN sed --in-place --expression \
      '$isource "/ros2_ws/install/setup.bash"' \
      /ros_entrypoint.sh
      
CMD ["ros2", "launch", "unitree_lidar_ros2", "launch.py"]
