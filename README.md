# ROS1D

Docker-based ROS1 (Noetic) development environment.

## Quick Start

1. Create workspace:
   ```bash
   mkdir -p $HOME/ros_ws/src
   ```

2. Enable X11:
   ```bash
   xhost +
   ```

3. Start container:
   ```bash
   cd ROS1-Noetic/docker
   docker-compose up -d
   ```

4. Enter container:
   ```bash
   docker exec -it ros1d bash
   ```

## Usage

- Workspace: `/home/user/ros_ws`
- Build: `cd /home/user/ros_ws && catkin build`
- GUI apps work out of the box
- Host networking enabled
