import 'package:flutter/material.dart';
import 'package:flutter_animation/common/data.dart';
import 'package:flutter_animation/common/size_config.dart';
import 'package:flutter_animation/first_demo.dart';
import 'package:flutter_animation/models/demo_item.dart';
import 'package:get/get.dart';

import '../../widgets/shimmer_list_item.dart';

class AnimateController extends GetxController{
  var isAni = false.obs;
  final GlobalKey<AnimatedListState> _key = GlobalKey();
}
class AnimateList extends StatelessWidget {
   AnimateList({super.key});

   var controller = Get.put(AnimateController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            controller.isAni(!(controller.isAni.value));
          },
            child: Text("List")),
      ),
      body: SizedBox.expand(
        child: Stack(children: [
          Positioned.fill(
              child: AnimatedList(
                key: controller._key,
                  //physics: const ClampingScrollPhysics(),
                  //itemCount: 100,
                  initialItemCount: 10,
                  itemBuilder: (context, index,animation) {
                    return Obx(
                        ()=> AnimatedContainer(
                        duration: Duration(milliseconds: 300 + (index * 200)),
                        curve: Curves.easeInOut,
                        transform: Matrix4.translationValues(controller.isAni.value ? AppSizes.screenWidth : 0, 0, 0),
                        child: ShimmerListItem(
                          isShimmerActive: true,
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
