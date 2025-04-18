FROM osrf/ros:noetic-desktop-full

# Setup user for GUI to work without xhost
ARG UNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}
RUN usermod -aG sudo ${UNAME}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${UNAME}

# Create a custom ros workspace
ENV ROS_WS=/home/user/ros_ws
RUN mkdir -p ${ROS_WS}/src

# Disable terminal interaction for apt
ENV DEBIAN_FRONTEND=noninteractive

# Make default shell in Dockerfile bash instead of sh
SHELL ["/bin/bash", "-c"]

# Install ROS1 dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
    ros-noetic-navigation \
    ros-noetic-turtlebot3 \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control \
    ros-noetic-ros-control \
    ros-noetic-ros-controllers \
    ros-noetic-joint-state-publisher-gui \
    ros-noetic-robot-state-publisher \
    ros-noetic-xacro \
    ros-noetic-rviz \
    ros-noetic-rqt \
    ros-noetic-rqt-common-plugins \
    python3-catkin-tools \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    && sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# Update rosdep
RUN rosdep update

# Build workspace
RUN cd ${ROS_WS} && \
    . /opt/ros/noetic/setup.bash && \
    catkin init && \
    catkin build

# Source ROS workspace automatically when new terminal is opened
RUN echo ". /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo ". ${ROS_WS}/devel/setup.bash" >> ~/.bashrc

WORKDIR /home/user/ros_ws

CMD ["/bin/bash"]