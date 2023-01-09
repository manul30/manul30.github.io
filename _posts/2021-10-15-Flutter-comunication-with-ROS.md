---
layout: post
title:  "Flutter communication with ROS video streaming"
title_img: /assets/post5/video_screenshot.png
abstract: A Flutter application with communication with ROS for interaction with the robot instances in Gazebo simulator.
date:   2021-10-15 12:00:00 +0300
categories: HMI
project: proj2
---
## Introduction

The main goal of the project is to stablish a communication between a Flutter desktop application and the ROS node. Also, to send and receive messages and visualize them in the app. The result of the implementation will be shown in Gazebo and the app itself.

## Roslib
We are using `Roslib ^0.0.3`, a flutter library for communicating to a ROS node over websockets with rosbridge, influenced by roslibjs, according to its [author][author].

*__Websockets in ROS__*

In order to work with websockets, it is neccesary to be able to execute it in a ROS node. That's why we are using `rosbridge_suite` package. To install it, you can execute the following command:

{% highlight bash linenos%}
sudo apt-get install ros-<rosdistro>-rosbridge-server
{% endhighlight %}

Where `<rosditro>` is the workspace ROS version. In our case, it is `melodic`.


## ROS

Before moving to the code, it is important to review some ROS concepts such as `node` and `topics`. 

According to the __[ROS wiki][ROS]__, a node is a process that performs computation. Nodes are combined together into a graph and communicate with one another using streaming topics, RPC services, and the Parameter Server. It is an executable that ROS uses to communicate with other nodes.

In the other side, topics are named buses over which nodes exchange messages. Topics have anonymous publish/subscribe semantics, which decouples the production of information from its consumption. In that way, nodes can publish messages to a topic as well as subscribe to receive messages.

<img src="https://upload.wikimedia.org/wikipedia/commons/e/e7/ROS-master-node-topic.png" align="center" width="1500">


We are using these concepts to start building our widgets in Flutter.

## Widget

### __ROS connection__
For the creation of the app we are going to create a Widget called `JoyStickPage` that returns a `Scaffold` widget. Inside of it we define our variables to initiate our `Ros` and `Topic` instances.  

We'll work with the `camera`, `cmd_vel`, and `imu` topics of the turtlebot robot.

{% highlight dart linenos%}

class JoyStickPage extends StatefulWidget {
  @override
  _JoyStickPageState createState() => _JoyStickPageState();
}

class _JoyStickPageState extends State<JoyStickPage> {
  late Ros ros;
  late Topic cmd_vel;
  late Topic imu;
  late Topic camera;

  @override
  void initState() {
    ros = Ros(url: 'ws://0.0.0.0:9090');

    cmd_vel = Topic(
        ros: ros,
        name: '/cmd_vel',
        type: "geometry_msgs/Twist",
        reconnectOnClose: true,
        queueLength: 10,
        queueSize: 10);


    imu = Topic(
      ros: ros,
      name: 'imu',
      type: 'sensor_msgs/Imu',
      queueSize: 10,
      queueLength: 10,
    );

    camera = Topic(
      ros: ros,
      name: 'camera/image/compressed',
      type: 'sensor_msgs/CompressedImage',
      queueSize: 10,
      queueLength: 10,
    );

    super.initState();
  }

  void initConnection() async {
    ros.connect();
    await cmd_vel.subscribe();
    await imu.subscribe();
    await camera.subscribe();
    setState(() {});
  }

  void destroyConnection() async {
    await cmd_vel.unsubscribe();
    await imu.unsubscribe();
    await camera.unsubscribe();
    await ros.close();
    setState(() {});
  }

{% endhighlight %}

We also declare two void functions that help us publishing the messsages from de joystick to the `cmd_vel` topic of the turtlebot.

{% highlight dart linenos%}
  
  void publishCmd(double _linear_speed, double _angular_speed) async {
    var linear = {'x': _linear_speed, 'y': 0.0, 'z': 0.0};
    var angular = {'x': 0.0, 'y': 0.0, 'z': _angular_speed};
    var twist = {'linear': linear, 'angular': angular};
    await cmd_vel.publish(twist);
    print('cmd published');
    publishCounter();
  }

  void _move(double _degrees, double _distance) {
    print(
        'Degree:' + _degrees.toString() + ' Distance:' + _distance.toString());
    double radians = _degrees * ((22 / 7) / 180);
    double linear_speed = cos(radians) * _distance;
    double angular_speed = -sin(radians) * _distance;

    publishCmd(linear_speed, angular_speed);
  }

{% endhighlight %}


### __Joystick__

For the plotting of the Joystick, we are using the flutter library `control_pad` which can be found __[here](https://pub.dev/packages/control_pad/versions/1.1.1+1)__.

<img src="https://i.imgur.com/ZwfNg9W.jpg" align="center" width="300">

### __Image__
We also need to build a Widget able to show the image received from the camera topic of our robot. in order to do that, we create a function to get the image from the string message that returns from the topic. The encoding given to the images is using base64, so we decode in the same way:

{% highlight dart linenos%}

Widget getImagenBase64(String imagen) {
    var _imageBase64 = imagen;
    const Base64Codec base64 = Base64Codec();
    if (_imageBase64 == null) return new Container(child: Text('Image'),);
    var bytes = base64.decode(_imageBase64);
    return Image.memory(
          bytes,
          gaplessPlayback: true,
          width: 400,
          fit: BoxFit.fitWidth,
       
    );
  }

{% endhighlight %}

### __Streaming__

Our app will be constantly reading the new messages of the websocket node thanks to the `StreamBuilder` Widget declare as below. The connection will be triggered with a button of class `ActionChip`. Finally, we call the `getImageBase64()` to render the image in our app with an embedded HTML tag.

{% highlight dart linenos%}

...
      body: StreamBuilder<Object>(
      stream: ros.statusStream,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ActionChip(
                label: Text(snapshot.data == Status.CONNECTED
                    ? 'DISCONNECT'
                    : 'CONNECT'),
                backgroundColor: snapshot.data == Status.CONNECTED
                    ? Colors.green[300]
                    : Colors.grey[300],
                onPressed: () {
                  print(snapshot.data);
                  if (snapshot.data != Status.CONNECTED) {
                    this.initConnection();
                  } else {
                    this.destroyConnection();
                  }
                },
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
              child: JoystickView(
                onDirectionChanged: ( double degrees, double distance) {
                    _move(degrees, distance);
                },
              ),),
              Padding(padding: EdgeInsets.all(20)),
                  StreamBuilder(
                    stream: camera.subscription,
                    builder: (context2,AsyncSnapshot<dynamic> snapshot2){
                      if (snapshot2.hasData){
                        return Html(
                          
                          data: """<img src="data:https//image/jpeg;base64,${snapshot2.data['msg']['data']}" >"""

                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }
                  ),
                ]
              ),
            
          );

      },

...

{% endhighlight %}


## Final result


<iframe width="560" height="315" src="https://www.youtube.com/embed/AmCjIxHKl5g" frameborder="0" allowfullscreen align="center"></iframe>



For details of the implementation see the [project repo][projectRepo].

[ROS]: http://wiki.ros.org/
[author]: https://pub.dev/packages/roslib/versions/0.0.3
[projectRepo]: https://github.com/manul30/Flutter-video-streaming-ROS