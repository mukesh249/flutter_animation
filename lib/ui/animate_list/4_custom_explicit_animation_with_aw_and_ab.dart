import 'dart:math';

import 'package:flutter/material.dart';

class CustomExplicitAnimationWithAwAndAb extends StatefulWidget {
  const CustomExplicitAnimationWithAwAndAb({super.key});

  @override
  State<CustomExplicitAnimationWithAwAndAb> createState() =>
      _CustomExplicitAnimationWithAwAndAbState();
}

class _CustomExplicitAnimationWithAwAndAbState
    extends State<CustomExplicitAnimationWithAwAndAb>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/space.webp"),
        AnimatedBuilder(
          animation: animationController,
          builder: (_, __) {
            return ClipPath(
                clipper: const BeamClipper(),
                child: Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 1.5,
                      colors: const [Colors.yellow, Colors.transparent],
                      stops: [0.5, animationController.value],
                    ),
                  ),
                ));
          },
          //animation: null,
        ),
        Image.asset("assets/images/ufo.png"),
      ],
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
