import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/ui/furniture/models/furniture_model.dart';
import 'package:get/get.dart';

class ItemsViewPageController extends GetxController {

 late CollectionModel collectionModel;
 var pageIndex = 0.obs;

 @override
  void onInit() {
    collectionModel = Get.arguments;
    super.onInit();
  }

}