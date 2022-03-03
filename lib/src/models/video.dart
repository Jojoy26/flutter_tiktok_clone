class VideoModel {
  String videoUrl;
  String avatar;
  int likeCount;
  int commentCount;
  int sharedCount;
  bool isLiked;
  VideoModel({
    required this.videoUrl,
    required this.avatar,
    required this.likeCount,
    required this.commentCount,
    required this.sharedCount,
    required this.isLiked,
  });
}
