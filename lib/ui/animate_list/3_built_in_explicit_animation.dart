import 'dart:math';

import 'package:flutter/material.dart';

class BuiltInExplicitAnimation extends StatefulWidget {
  const BuiltInExplicitAnimation({super.key});

  @override
  State<BuiltInExplicitAnimation> createState() =>
      _BuiltInExplicitAnimationState();
}

class _BuiltInExplicitAnimationState extends State<BuiltInExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 15), vsync: this)
          ..repeat();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (animationController.isAnimating) {
              animationController.stop();
            } else {
              animationController.repeat();
            }
          },
          child: RotationTransition(
            alignment: Alignment.center,
            turns: animationController,
            child: Image.asset("assets/images/galaxy.webp"),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
