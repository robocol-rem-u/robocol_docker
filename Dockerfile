FROM osrf/ros:melodic-desktop

# Install some tools
RUN apt-get update && apt-get -y upgrade && apt-get install -y \
    python-rosdep \
    python-catkin-tools \
    python-vcstool \
  && rm -rf /var/lib/apt/lists/*

# Clone the source code
WORKDIR /robocol_erc_ws
COPY robocol.repos ./
RUN vcs import < robocol.repos

# Install dependencies
RUN apt-get update \
  && rosdep update \
  && rosdep install --from-paths src -iy \
  && rm -rf /var/lib/apt/lists/*

# Build the workspace
RUN catkin config --extend /opt/ros/melodic && catkin build

