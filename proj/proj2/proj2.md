---
layout: project_page
title: AUV Bobelto HMI
permalink: /proj/proj2
project_id: proj2
---

This project is created based on the HMI requirements of the AUV (Autonomous Underwater Vehicle) made by __[Blume Team](https://www.linkedin.com/company/blume-team/)__ . The main goal of the project is to create a Graphical User Interface (GUI) to visualize the main sensor data to monitor the performance of the Bobelto ROV for the MATE ROV 2022 competition. This HMI was implemented and tested with the robot in the image below.

<img src="/proj/proj2/bobelto.png" align="center" width="1000">

This project is a compilation of a lot of custom widgets. I explain some of them in the post page. Additionally, a lane line finding algorithm was added. It was implemented in Fluttter SDK for linux desktop. The main advantage of using Flutter SDK is that it can build the application in any platform that Flutter supports (i.e. MacOS, Windows, Linux, iOS, Android).  The project repo is availuble on [Github][projectRepo].

There are some newer versions of the GUI, tha last one up to date includes the visualization of the joystick controller, as it is shown in the video below.

### Contents:

1. [Flutter commnuication with ROS through websockets][postSVM]
2. Sensor data streaming

## Final project video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/dWXkCMG5Bxc" frameborder="0" allowfullscreen align="center"></iframe>

[projectRepo]: https://github.com/manul30/Flutter-bobelto
[postSVM]: {% post_url 2021-10-15-Flutter-comunication-with-ROS %}
