import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/ui/logitech/page/logitech_controller.dart';
import 'package:flutter_animation/ui/logitech/utils/utils.dart';
import 'package:get/get.dart';

class LogitechHomePage extends StatelessWidget {
  LogitechHomePage({super.key});

  var controller = Get.put(LogitechController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.decal,
                colors: [
                  Colors.black,
                  Colors.black,
                  Color(0xff1F1E1E),
                  Color(0xff1F1E1E),
                  Colors.black
                ],
              )),
            ),
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              "assets/logitech/logitech_logo.png",
                              scale: 8,
                            ),
                            SizedBox(
                              width: Get.width * .6,
                              height: 20,
                              child: Center(
                                child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: controller.list.length,
                                    itemBuilder: (context, index) {
                                      var item = controller.list[index];
                                      return menuText(item, index);
                                    }),
                              ),
                            ),
                            /* Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                menuText("Home"),
                                menuText("Shop"),
                                menuText("Business"),
                                menuText("Support"),
                              ],
                            ),*/
                            Row(
                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                menuEnd("Search", Icons.search),
                                Container(
                                  color: Colors.grey,
                                  height: 20,
                                  width: 2,
                                ),
                                menuEnd("Login", Icons.login),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * .35,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  textBuild(Utils.masterSeries, textSize: 20),
                                  textBuild(Utils.mXMaster3s, textSize: 40),
                                  textBuild(Utils.masterDes, textSize: 15),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Expanded(
                                          child: Text(
                                            "MX",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                    fontSize: 280,
                                                    fontWeight: FontWeight.w900)
                                                .copyWith(
                                              foreground: Paint()
                                                ..strokeWidth = 15
                                                ..color = Color(0x129e9e9e)
                                                ..style = PaintingStyle.stroke,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        top: 150,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                RatingBar(
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star_border,
                                                  onRatingChanged: (value) =>
                                                      debugPrint('$value'),
                                                  initialRating: 3,
                                                  maxRating: 5,
                                                ),
                                                const SizedBox(width: 20),
                                                textBuild(Utils.ratingText, textSize: 15),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                textBuild(Utils.price, textSize: 25),
                                                const SizedBox(width: 20),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(0xff3A3636)),
                                                  child: textBuild(Utils.addToCart,
                                                      textSize: 16),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                                child: Image.asset(
                              'assets/logitech/mouse.png',
                              scale: 5,
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var isHover = false.obs;
  var hoverIndex = 5.obs;

  Widget menuText(title, int index) {
    return InkWell(
      onHover: (value) {

        value ? hoverIndex(index) : hoverIndex(5);
       // isHover.value = value;
      },
      onTap: () {
        //isHover.value = !isHover.value;
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration:
              BoxDecoration(
                 // color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(20.0), boxShadow: [
            BoxShadow(
                offset: const Offset(0.0, 0.0),
                blurRadius: 30,
                spreadRadius: 1,
                color: hoverIndex.value == index ? Color(0xd3ffffff) : Colors.transparent)
          ]),
          child: Center(
            child: Text(
              style: TextStyle(
                color: hoverIndex.value == index ? Colors.black : Colors.white,
                /*shadows:isHover.value ? [
                  const Shadow(
                    color: Colors.grey,
                    offset: Offset(10, 0),
                    blurRadius: 20,

                  ),
                ] : [],*/
              ),
              title,
            ),
          ),
        ),
      ),
    );
  }

  Widget textBuild(title, {double textSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        style: TextStyle(fontSize: textSize, color: Colors.white),
        title,
      ),
    );
  }

  Widget menuEnd(title, icon) {
    return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}
