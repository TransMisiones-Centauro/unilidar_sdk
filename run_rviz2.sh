#!/usr/bin/env bash

rocker --nvidia --x11 robinlab/unilidar_sdk:humble "rviz2 -d /ros2_ws/src/unitree_lidar_ros2/src/unitree_lidar_ros2/rviz/view.rviz"
