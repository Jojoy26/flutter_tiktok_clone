// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tiktok/src/controllers/video_controller.dart';
import 'package:flutter_tiktok/src/widgets/avatar.dart';
import 'package:flutter_tiktok/src/widgets/rotation_animation.dart';
import 'package:flutter_tiktok/src/widgets/video.dart';
import 'package:get/get.dart';

class TikTok extends StatefulWidget {
  const TikTok({ Key? key }) : super(key: key);

  @override
  _TikTokState createState() => _TikTokState();
}

class _TikTokState extends State<TikTok> with SingleTickerProviderStateMixin{

  VideoController controller = Get.put(VideoController());

  late AnimationController animationController;
  late Animation<double> scale;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getVideos();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );

    scale = Tween<double>(begin: 1, end: 1.2).animate(animationController)..addListener(() { 
      print("Oi");
    });

    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            pageSnapping: true,
            onPageChanged: (int i){
              print("IIIIIIIIIIIIIII ${i}");
              controller.setSelectVideo(i);
            },
            scrollDirection: Axis.vertical,
            itemCount: controller.videos.length,
            itemBuilder: (context, index){
              return Video();
            }
          ),
          Positioned(
            bottom: 85,
            right: 10,
            child: Column(
              children: [
                Obx(() => Avatar(url: controller.currentVideo.value.avatar,)),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () async{
                    controller.toggleLike(controller.selectVideoIndex.value);
                    await animationController.forward();
                    await animationController.reverse();
                  }, 
                  child: ScaleTransition(
                    scale: scale,
                    child: Obx(() => Icon(
                          Icons.favorite,
                          color: controller.currentVideo.value.isLiked ? Colors.red : Colors.white,
                          size: 36,
                        ),
                      )
                    )
                  ),
                Obx(( ) => textLabel(controller.currentVideo.value.likeCount.toString()),),
                SizedBox(height: 20,),
                Icon(Icons.message, color: Colors.white, size: 30,),
                Obx(( ) =>textLabel(controller.currentVideo.value.commentCount.toString())),
                SizedBox(height: 20,),
                Transform.rotate(
                  angle: 9.4,
                  child: Icon(Icons.reply, color: Colors.white, size: 40,),
                ),
                Obx(( ) =>(textLabel(controller.currentVideo.value.sharedCount.toString()))),
              ],
            )
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: RotationAnimation(
                child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white12, Colors.grey]
                  ),
                  shape: BoxShape.circle
                ),
                child: Obx(() =>  
                  CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(controller.currentVideo.value.avatar),
                  ),
                )
              )
            )
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        padding: EdgeInsets.only(left: 12, right: 12),
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            tikTokButton(),
            Icon(
              Icons.message,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

Widget tikTokButton() {
  return Container(
      height: 24.5,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 21,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6)
                ),
              ),
              Container(
                width: 21,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(6)
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 6, right: 6,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(
                  Icons.add
                ),
              ),
            ),
          )
        ],
      ),
    );
}

Widget textLabel(String label){
  return Text(
    label, style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 11
    ),
  );
}