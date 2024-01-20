---
layout: project_page
title: Impedance Control for Open Manipulator
permalink: /proj/proj6
project_id: proj6
---
<script
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
  type="text/javascript">
</script>

## Intro

Compliance in robotics, the ability of robots to react to external forces, has numerous real-life applications. In industries, compliant robots can work alongside humans, enhancing efficiency and safety in manufacturing. They can also be used in healthcare for delicate procedures and in disaster response for search and rescue operations. Overall, compliance in robotics enables safer and more effective human-robot interactions, revolutionizing various fields.

## Metodology

In this project, the impedance control will run in a Open Manipulator Robot. You can search more information __[here](https://emanual.robotis.com/docs/en/platform/openmanipulator_x/overview/)__

<img src="/proj/proj6/open_manipulator.png" style="display: block;margin-left: auto; margin-right: auto;" width="450">


### Impedance Control

In the field of robotics, impedance is a transfer function that relates the velocity V(s) of a robot to the force exerted at its end effector (F). This concept plays a crucial role in controlling the interaction between robots and their environment, allowing for adaptive and responsive behavior. Recent advancements in impedance control have focused on enhancing the robot's ability to interact with complex and dynamic environments, leading to applications in areas such as manufacturing, healthcare, and disaster response. These developments aim to improve the safety, efficiency, and versatility of robotic systems, paving the way for their broader integration into various real-world scenarios.

$$Z(s)=\frac{F(s)}{V(s)}=\frac{F(s)}{sX(s)}$$

This math relation can be modeled as an action of an spring or compliance which has three parameter. The first one (m) stands for inertia, b for damping and K for stiffness.

$$ms^2X(s)+bsX(s)+kX(s)=F(s)$$

$$Z(s)=sm+b+\frac{k}{s}$$

With that, we can model force (F) respect a desired position:

$$M_d(\ddot{x}-\ddot{x_d})+B_d(\dot{x}-\dot{x_d})+K_d(x-x_d)=F_A$$

Also, we know that the dynamics of a manipulator robot is:

$$M\ddot{x}+C\dot{x}+g=\tau$$

Where M is inertia, C is Coriolis matrix, g is a gravity vector and tau is a vector of the torque actuators of the manipulator. When applying inverse dynamics, we can obtain the following.

$$\tau = M_AJ^{-1}_A[\ddot{x}-J_A\dot{q}+M_d^{-1}(B_d(\dot{x}_d-\dot{x})+K_d(x_d-x))]+C\dot{q}+g+J^{T}_A(M_xMd^{-1}-I)F_A$$

### Implementation in the Open Manipulator 

This robot has 4 DoF and uses Dynamixel motors. However, it lacks on force or torque sensors so it makes it harder to apply an impedance control. Since, this robot has it open source packages, we can know the model (urdf) and the characteristics of the robot almost exactly, so we can apply an special case replacing in the general equation:

$$M_d=M_x=J^{-T}_AMJ^{-1}_A$$

$$\tau=M_AJ^{-1}_A[\ddot{x}-J_A\dot{q}+M_d^{-1}(B_d(\dot{x}_d-\dot{x})+K_d(x_d-x))]+C\dot{q}+g$$

That's enough for achieving an impedance control. So now we are going to code this to run the code in our robot. We will be using the cpp node made by OpenManipulatorX __(gravity compensator)[https://raw.githubusercontent.com/ROBOTIS-GIT/open_manipulator_controls/master/open_manipulator_controllers/src/gravity_compensation_controller.cpp]__. We can clone it by typing this in our terminal

```
$ cd ~/catkin_ws/src/
$ git clone https://github.com/ROBOTIS-GIT/open_manipulator_controls.git
$ cd ~/catkin_ws && catkin_make
```

After that, we will be locating the "gravity compensation controller" file in the /src directory. There we will be inserting the following piece of code:

```
  // Inverse Jacobian
  { J_pos_pinv_ = J_pos_.completeOrthogonalDecomposition().pseudoInverse(); }

  // Desired Inertial matrix
  Md_ = J_pos_pinv_.transpose() * M_.data * J_pos_pinv_;

  auto imposicion = Md_.inverse() * (Bd_ * (desired_x_dot_ - x_dot_eigen_) +
                                     Kd_ * (desired_x_ - x_eigen_));

  auto dinamica = desired_x_dot_dot_ - J_pos_dot_ * q_dot_.data + imposicion;

  tau_.data = M_.data * J_pos_pinv_ * dinamica + C_.data + G_.data;

```
Then we can run the controller by calling the following launch files

```
roslaunch open_manipulator_controller open_manipulator_controller.launch
roslaunch open_manipulator_controllers gravity_compensation_controller.launch
```

## Results

<iframe width="560" height="315" src="https://www.youtube.com/embed/r9iU3OYlKqc" frameborder="0" allowfullscreen align="center"></iframe>


Here it is an article about this project (Spanish):

<iframe src="/proj/proj6/final.pdf" height="500" width="900"></iframe>

The code can be located __[here](https://github.com/manul30/ImpedanceControl_OpenManipulator)__.

[projectRepo]: https://github.com/manul30/Flutter-bobelto
[postSVM]: {% post_url 2021-10-15-Flutter-comunication-with-ROS %}
