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

## Using Docker

---
**NOTE**

The commands in this section should be executed as the `root` user, unless you have configured docker to be [managable as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/).

---

Make sure the [Docker Engine](https://docs.docker.com/engine/install/#server) is installed and the `docker` service is running:
```
systemctl start docker
```
If you have an issue like the following:
```
ERRO[0000] failed to dial gRPC: cannot connect to the Docker daemon. Is 'docker daemon' running on this host?: dial unix /var/run/docker.sock: connect: permission denied 
```
Run the command below:
```
sudo chmod 666 /var/run/docker.sock
```
Build the docker image by executing:
```
docker build -t robocol_img .
```
Permit the root user to connect to X window display:
```
xhost +local:root
```
Start the docker container:
```
docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY --name robocol_erc robocol_img
```
If you want the simulation to be able to communicate with ROS nodes running on the host or another docker container, add `--net=host` flag:
```
docker run --rm --net=host -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY --name robocol_erc  robocol_img
```
To start any other ROS nodes inside the container, type:
```
docker exec -it robocol_erc /ros_entrypoint.sh <COMMAND>
```
To update the docker image, you need to rebuild it with `--no-cache` option:
```
docker build --no-cache -t robocol_erc .
```

* Instructions taken from https://github.com/fictionlab/erc_sim_ws/blob/master/README.md
