import 'package:flutter/material.dart';

class PlayAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  const PlayAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
  }) : super(key: key);

  @override
  State<PlayAnimation> createState() => _PlayAnimationState();
}

class _PlayAnimationState extends State<PlayAnimation> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> opacity;
  late Animation<double> scale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );
    opacity = Tween(begin: 0.0, end: 0.8).animate(animationController);
    scale = Tween(begin: 1.4, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  void callAnimation(){
    if(widget.isAnimating){
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    callAnimation();
    return FadeTransition(
      opacity: opacity,
      child: ScaleTransition(
        scale: scale,
        child: widget.child,
      )
    );
  }
}