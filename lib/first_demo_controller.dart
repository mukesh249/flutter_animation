import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstDemoController extends GetxController {

  var pageController = PageController(initialPage: 0);
  var index = 0.obs;
  var opacity = 1.0.obs;
  var margin = 0.0.obs;
  var width = 200.0.obs;
  var color = Colors.blue.obs;

  List colors = [Colors.pink, Colors.green, Colors.purple, Colors.teal];
  Random random = Random();
  Tween<Offset> offset = Tween(begin: const Offset(1,0),end: const Offset(0, 0));
}