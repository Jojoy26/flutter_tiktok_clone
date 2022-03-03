// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tiktok/src/controllers/video_controller.dart';
import 'package:flutter_tiktok/src/widgets/play_animation.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_tiktok/src/models/video.dart';

class Video extends StatefulWidget {
  const Video({
    Key? key,
  }) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video>  {

  VideoController videoController = Get.find();
  late VideoPlayerController controller;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.asset(
      videoController.currentVideo.value.videoUrl
    )..initialize().then((value){
      controller.setLooping(true);
      
      setState(() {
        controller.play();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void toggleVideo(){
    if(controller.value.isPlaying){
      setState(() {
        controller.pause();
      });
    } else {
      setState(() {
        controller.play();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        children: [
          InkWell(
            onTap: toggleVideo,
            child: VideoPlayer(controller)
          ),
          GestureDetector(
            onTap: toggleVideo,
            child: PlayAnimation(
              isAnimating: controller.value.isInitialized && !controller.value.isPlaying,
              child: Center(
                child: Icon(
                  Icons.play_arrow, 
                  color: Colors.white,
                  size: 55,
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}