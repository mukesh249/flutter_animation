import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/ui/furniture/models/furniture_model.dart';
import 'package:get/get.dart';

class FurnitureDetailsController extends GetxController {

 late CollectionDetailsModel collectionDetailsModel;

 @override
  void onInit() {
    collectionDetailsModel = Get.arguments;
    super.onInit();
  }

}