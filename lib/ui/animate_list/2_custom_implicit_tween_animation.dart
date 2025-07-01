import 'dart:math';

import 'package:flutter/material.dart';

class CustomImplicitTweenAnimation extends StatefulWidget {
  const CustomImplicitTweenAnimation({super.key});

  @override
  State<CustomImplicitTweenAnimation> createState() =>
      _CustomImplicitTweenAnimationState();
}

class _CustomImplicitTweenAnimationState
    extends State<CustomImplicitTweenAnimation> {
  bool isButtonClicked = false;

  double _sliderValue = 0.0;
  Color? _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
              child: TweenAnimationBuilder(
                  tween: ColorTween(begin: Colors.white, end: _newColor),
                  duration: const Duration(seconds: 1),
                  child: Image.asset("assets/images/sun.png"),
                  onEnd: (){
                    setState(() {
                      _newColor = _newColor == Colors.red ? Colors.white : Colors.red;
                    });
                  },
                  builder: (_, Color? color, myChild) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          color ?? Colors.white, BlendMode.modulate),
                      child: myChild,
                    );
                  })),
          Slider.adaptive(
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  _newColor = Color.lerp(Colors.white, Colors.red, value);
                });
              })
        ],
      ),
    );
  }
}

class CustomSineCurve extends Curve {
  final double count;

  CustomSineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}
