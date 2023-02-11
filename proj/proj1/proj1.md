---
layout: project_page
title: Lane Lines Detection Project
permalink: /proj/proj1
project_id: proj1
---

This project was made for Image Proccessing course at UTEC (Universidad de Ingeniería y Tecnología) for robotics specialization degree. The goal of the porject is to write a software pipeline using OpenCV library to detect lane boundaries in an imagea and then video from a front-facing camera on a car. 

In this post, we will use the following test image:

<img src="/proj/proj1/test.png" align="center" width="500">

### Defining transform points

In order to make it easier to detect the lines, we need to condition the image to make the lines parallel in a new perspective. That's why we are using Bird's Eye View transform. In this case, we are going to use the _stretch_ method shown [here](https://nikolasent.github.io/opencv/2017/05/07/Bird's-Eye-View-Transformation.html). By trial and error, we adjust our points so that we focus on our interest region.

<img src="/proj/proj1/points.png" align="center" width="500">

<img src="/proj/proj1/bevgray.png" align="center" width="500">

After applying the transform and changing from RGB to gray scale, we use the gabor filter wich let us focus on borders in a especif range of direction. After that, whe can plot a specific row of our image to see the pattern tha it generates. Then, we can use a threshold visualize better the lanes in our image.

<img src="/proj/proj1/plot.png" align="center" width="500">

<img src="/proj/proj1/lanes.png" align="center" width="500">

### Implementing a untraditional algorithm

We can observe from the last 2 images, that there are 2 mainly pikes in the plot, and from there, we can inferre that those pikes are our desired lines, also, there are a certain distance from those pikes and also, the pikes have a standard width. With those all variables, we can elaborate our program logic.

<img src="/proj/proj1/explain.png" align="center" width="500">

With the previous info, we will try to select 2 points for every row of our image that satisfy the requirements. Those 2 points will be our center of each lane.
<img src="/proj/proj1/lineas.png" align="center" width="500">

Then we apply a curve fitting to the image above. We can choose any order of the polynomical curve, but in this case we are going to keep it simple, so it will be a lineal curve.
<img src="/proj/proj1/curve.png" align="center" width="500">

After that, we make the inverse Bird's Eye View transform and we can see that the curve drawn are really close to the real lanes.
<img src="/proj/proj1/final.png" align="center" width="500">

## Disadvantages and future work

- The logic algorithm detects the lanes only if there are 2 lanes in the region of interest. It means that it cannot detect the lines when the car pass from one carril to another.
- The program can have problems when there are too much traffic signs in the road.
- The _shrinking_ Bird's Eye View method can work better for this program since we don't increase the spatial resolution and we only center in the central lines, it could also detect any rect lines.

