import 'package:flutter_tiktok/src/models/video.dart';
import 'package:flutter_tiktok/src/videos/videos_list.dart';
import 'package:get/get.dart';

class VideoController extends GetxController{

  RxList<Rx<VideoModel>> videos = <Rx<VideoModel>>[].obs;
  RxInt selectVideoIndex = 0.obs;

  Rx<VideoModel> get currentVideo => videos[selectVideoIndex.value];

  void getVideos() {
    List<Rx<VideoModel>> list = <Rx<VideoModel>>[];

    for(VideoModel item in videosList){
      list.add(
        item.obs
      );
    }

    videos.value = list;
  }

  void setSelectVideo(int index){
    selectVideoIndex.value = index;
  }

  void toggleLike(int index){
    videos[index].update((video) {
      video!.videoUrl = video.videoUrl;
      video.isLiked = !video.isLiked;
    });
  }
}