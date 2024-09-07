import 'package:flutter/material.dart';
import 'package:flutter_animation/ui/furniture/common/colors.dart';
import 'package:get/get.dart';

import '../controllers/items_view_page_controller.dart';
import 'furniture_details.dart';

class ItemsViewPage extends StatelessWidget {
  ItemsViewPage({super.key});

  final controller = Get.put(ItemsViewPageController());

  @override
  Widget build(BuildContext context) {
    var modelData = controller
        .collectionModel.collectionProducts[controller.pageIndex.value];
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.collectionModel.collectionProducts.length,
              onPageChanged: (value) {
                controller.pageIndex.value = value;
              },
              itemBuilder: (context, index) {
                var item = controller.collectionModel.collectionProducts[index];
                return Hero(
                  tag: item.imagePath,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(item.imagePath))),
                  ),
                );
              }),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  AnimatedContainer(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 150),
                    duration: const Duration(milliseconds: 400),
                    width: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70),
                    child: Center(
                      child: Text.rich(TextSpan(
                          text: "${modelData.name}\n",
                          style: const TextStyle(
                              color: secondaryColor, fontSize: 19),
                          children: [
                            TextSpan(
                              text: "${controller.collectionModel.name}\n",
                              style: const TextStyle(
                                  color: secondaryColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            )
                          ])),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: 100,
                    margin: const EdgeInsets.only(left: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: accentColor),
                    child: Center(
                      child: Text(
                        "\$${modelData.price}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(left: 80),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: accentColor, shape: BoxShape.circle),
                      ))
                ],
              ))
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: backGroundColor, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    size: 35,
                    Icons.home_filled,
                    color: Colors.white,
                  )),
              GestureDetector(
                  onTap: () {
                    Get.to(()=> FurnitureDetails(),arguments: controller.collectionModel.collectionProducts[controller.pageIndex.value]);
                  },
                  child: const Icon(
                    size: 60,
                    Icons.add_circle,
                    color: Colors.white,
                  )),
              IconButton(

                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    size: 35,
                    Icons.person,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
