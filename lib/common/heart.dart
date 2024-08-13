import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  late AnimationController animationController;
  late Animation<Color?> animationColor;
  late Animation<double> animationSize;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    animationColor = ColorTween(begin: Colors.grey, end: Colors.red).animate(animationController);
    animationSize = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween<double>(begin: 30, end: 100), weight: 50),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 100, end: 30), weight: 50)
    ]).animate(animationController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }

      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return IconButton(
              onPressed: () {
                isFav ? animationController.reverse() : animationController.forward();
              },
              icon: Icon(
                Icons.favorite,
                color: animationColor.value,
                size: animationSize.value,
              ));
        });
  }
}
