import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  Color color = Colors.deepPurple;
  AppBarCustom({super.key, required this.title,  required this.color });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double tweenValue, Widget? child) {
          return Opacity(
            opacity: tweenValue,
            child: Padding(
              padding: EdgeInsets.all(tweenValue * 20),
              child: child,
          ));
        },
        child:  Text(
          title,
          style: TextStyle(
              fontSize: 30,
              color: color,
              fontWeight: FontWeight.bold
          ),
        ));
  }
}
