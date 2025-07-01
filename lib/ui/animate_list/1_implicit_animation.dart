import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Implicit Animation"),
        ),
        body:
            /*AnimatedContainer(
              width: isButtonClicked ? 100 : 400,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: const [Colors.purple, Colors.transparent],
                      stops: [isButtonClicked ? 0.2 : 0.5, 1.0])),
              duration: const Duration(seconds: 10),
              curve: CustomSineCurve(),
              child: Image.asset("assets/images/right_select.png"),
            ),*/
            /*AnimatedContainer(
              height: isButtonClicked ? 200 : 80,
              child: Image.asset('assets/icons/eye_icon.png'),
              duration: Duration(seconds: 10),
              curve: CustomSineCurve(count: 2),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isButtonClicked = !isButtonClicked;
                });
              },
              child: const Text("Animate"),
            ),*/
            Center(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 5)),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    double width;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          width = 10;

                          break;
                        }
                      case ConnectionState.done:
                        {
                          width = 500;
                          break;
                        }
                    }
                    return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: width,
                      curve: Curves.easeInOut,
                      child: Image.asset("assets/images/right_select.png"),
                    );
                  }),
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
