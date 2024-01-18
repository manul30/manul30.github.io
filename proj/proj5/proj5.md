---
layout: project_page
title: Visual SLAM with RBG-D camera for navigation
permalink: /proj/proj5
project_id: proj5
---

## Intro

This project is part of the Autonomoues Robotics course at UTEC. The objective of this project is to compare maps obtained through ViSLAM using RTABMap with stereo camera configuration and the use of an RGB-D depth camera.

Here, we area evaluating both approaches with the Turtlebot3 Waffle Pi robot. Also, we are using the following map to evaluate the obtained results with the ground truth.

<img src="/proj/proj5/turtlebot_maze_map_modified.png" style="display: block;margin-left: auto; margin-right: auto;" width="300">

## Metodology

### A. Navigation Algorithm with 2D Lidar

The first step of the methodology is to establish a navigation algorithm based on the measurements that performs 2D LiDAR. The flow chart of this algorithm is detailed better in the figure below. The essence is to avoid collision with obstacles while navigating through an unknown environment performing the SLAM.

<img src="/proj/proj5/diagrama-flujo.png" align="center" width="450">



<img src='/proj/proj5/gg.gif'  alt="Project title image">

The whole proccess is described in the following pdf file (spanish)

<iframe src="/proj/proj5/Proyecto_Fundamentos.pdf" height="500" width="900"></iframe>

The code can be located __[here](https://github.com/Jimi1811/Visual_SLAM_in_turtlebot3)__.

[projectRepo]: https://github.com/manul30/Flutter-bobelto
[postSVM]: {% post_url 2021-10-15-Flutter-comunication-with-ROS %}
