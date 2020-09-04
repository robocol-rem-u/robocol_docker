# robocol_docker

This repository contains Robocol dockerfile.

## Requirements

The simulation is mainly developed and tested on [Ubuntu 18.04 Bionic Beaver](https://releases.ubuntu.com/18.04/) with [ROS Melodic Morenia](http://wiki.ros.org/melodic/Installation/Ubuntu), so it is a recommended setup. 

The rest of the tools used in this guide can be installed with apt:
```
sudo apt install python-rosdep python-catkin-tools python-vcstool
```

There is also a dockerized version which should work on most Linux distributions running X Window Server (See [Using Docker](#using-docker) section).

## Building

Use the `vcstool` tool to clone the required packages:
```
vcs import < robocol.repos
```
Use the `rosdep` tool to install any missing dependencies. If you are running `rosdep` for the first time, you might have to run:
```
sudo rosdep init
```
first. Then, to install the dependencies, type:
```
rosdep update
sudo apt update
rosdep install --rosdistro melodic --from-paths src -iy
```
Now, use the `catkin` tool to build the workspace:
```
catkin config --extend /opt/ros/melodic
catkin build
```
