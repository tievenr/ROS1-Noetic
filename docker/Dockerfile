FROM osrf/ros:noetic-desktop-full

# Setup user for GUI to work without xhost
ARG UNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}
RUN usermod -aG sudo ${UNAME}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Disable terminal interaction for apt
ENV DEBIAN_FRONTEND=noninteractive

# Make default shell in Dockerfile bash instead of sh
SHELL ["/bin/bash", "-c"]

# Install ROS1 dependencies and Python tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-noetic-navigation \
    ros-noetic-teb-local-planner \
    ros-noetic-global-planner \
    ros-noetic-ros-control \
    ros-noetic-ros-controllers \
    ros-noetic-joint-state-publisher-gui \
    ros-noetic-robot-state-publisher \
    ros-noetic-xacro \
    ros-noetic-rviz \
    ros-noetic-rqt \
    ros-noetic-rqt-common-plugins \
    ros-noetic-explore-lite \
    ros-noetic-teleop-twist-joy \
    ros-noetic-joy \
    ros-noetic-gmapping \
    python3 \
    python3-pip \
    python3-opencv \
    python3-catkin-tools \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create custom ros workspace
ENV ROS_WS=/home/user/ros_ws
USER ${UNAME}
RUN mkdir -p ${ROS_WS}/src

# Install Python dependencies for YOLO
RUN pip3 install opencv-python numpy && \
    pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cpu

# Create Python symlink
USER root
RUN ln -s /usr/bin/python3 /usr/bin/python
USER ${UNAME}

# Update rosdep
RUN rosdep update

# Clone Fire Fighting Robot repo and frontier exploration
WORKDIR ${ROS_WS}/src
RUN git clone https://github.com/lidorshimoni/Fire-Fighting-Robot-using-ROS-.git && \
    git clone https://github.com/paulbovbel/frontier_exploration.git

# Install dependencies from packages
WORKDIR ${ROS_WS}
RUN . /opt/ros/noetic/setup.bash && \
    rosdep install --from-paths src --ignore-src -r -y

# Build workspace with catkin
RUN . /opt/ros/noetic/setup.bash && \
    catkin init && \
    catkin build

# Source ROS workspace automatically when terminal is opened
RUN echo ". /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo ". ${ROS_WS}/devel/setup.bash" >> ~/.bashrc

WORKDIR ${ROS_WS}
CMD ["/bin/bash"]