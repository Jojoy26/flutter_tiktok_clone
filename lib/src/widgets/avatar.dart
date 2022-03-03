import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String url;
  const Avatar({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
        ),
        padding: EdgeInsets.all(0.7),
          child: CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(widget.url),                  
          )
        ),
        Positioned.fill(
          bottom: -10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle
              ),
              child: Icon(Icons.add, color: Colors.white, size: 16,),
            ),
          )
        )
      ],
    );
  }
}