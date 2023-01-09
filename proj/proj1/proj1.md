---
layout: project_page
title: Lane Lines Detection Project
permalink: /proj/proj1
project_id: proj1
---

This Project is based on the fourth task of the Udacity Self-Driving Car Nanodegree program. The main goal of the project is to write a software pipeline to identify the lane boundaries in a video from a front-facing camera on a car. 

It was implemented in Python with OpenCV library. The project [repo](https://github.com/NikolasEnt/Advanced-Lane-Lines).

The key idea of the realization is use of virtual sensors with adaptive position and threshold which analyze the region of interest row by row. It also use information from previous frames and different techniques of results filtering for smoothing.
The code also estimates radius of the road curvature and the position of the vehicle with respect to the lane center.



### Final project videos:

<iframe width="560" height="315" src="https://www.youtube.com/embed/1YaguCWMklc" frameborder="0" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/aOaV-RHMg2U" frameborder="0" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/tgQwXVzhrBI" frameborder="0" allowfullscreen></iframe>