import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/common/heart.dart';
import 'package:flutter_animation/first_demo_controller.dart';
import 'package:flutter_animation/ui/weather/weather_page.dart';
import 'package:get/get.dart';

import 'app_bar.dart';

/*
class FirstDemo extends stl {
  const FirstDemo({super.key});

  @override
  State<FirstDemo> createState() => _FirstDemoState();
}
*/

class FirstDemo extends StatelessWidget {
  const FirstDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final FirstDemoController controller = Get.find<FirstDemoController>();
    return Obx(
      () => Scaffold(
        body: PageView(controller: controller.pageController, children: [
          const WeatherPage(),
          Column(children: [
            const SizedBox(height: 30),
            AppBarCustom(
              title: "Mukesh",
              color: controller.color.value,
            ),
            const Heart(),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              margin: EdgeInsets.all(controller.margin.value),
              width: controller.width.value,
              color: controller.color.value,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.margin.value = controller.margin.value == 0 ? 50 : 0;
                    },
                    child: const Text("Animate Margin Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.width.value = controller.width.value == 200 ? 400 : 200;
                    },
                    child: const Text("Animate Width Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.color.value = controller.color.value == Colors.blue
                          ? Colors.amber
                          : Colors.blue;
                    },
                    child: const Text("Animate Color Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.opacity.value = controller.opacity.value == 0 ? 1 : 0;
                    },
                    child: const Text("Animate Opacity Button"),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(seconds: 2),
                    opacity: controller.opacity.value,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onHover: (value) {
                            controller.color.value = Colors.deepPurple;
                          },
                          onPressed: () {},
                          child: const Text("Hide Me"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            /*  ListView.builder(
                 // initialItemCount: list.length,
                 itemCount: list.length,
                  itemBuilder: (context, index){
                    var item = list[index];
                    return Text("${item.title}",style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),);}
              )*/
          ]),
        ]),
        backgroundColor: controller.colors[controller.index.value],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: controller.colors[controller.index.value],
          color: controller.colors[controller.index.value].shade200,
          onTap: (value) {
            controller.index.value = value;
            controller.pageController.jumpToPage(controller.index.value);
          },
          animationDuration: const Duration(milliseconds: 200),
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
