import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/ui/sofa_set/page/sofa_set_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/neo_button.dart';
import '../utils/sofa_utils.dart';

class SofaPage extends StatelessWidget {
  SofaPage({super.key});

  var controller = Get.put(SofaSetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Color(0xFFDBD3CF),
              /*decoration: const BoxDecoration(
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
              )),*/
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
                            Text(sofaSet,
                                style: GoogleFonts.ingridDarling(
                                    fontSize: 55, color: Color(0xFF412927))),
                            SizedBox(
                              width: Get.width * .6,
                              height: 30,
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
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                menuEnd("", Icons.search),
                                Container(
                                  color: Color(0xffCCA176),
                                  height: 20,
                                  width: 2,
                                ),
                                menuEnd("", Icons.login),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * .25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  textBuild(modernFurniture,
                                      textSize: 75,
                                      style: GoogleFonts.aclonica(
                                          fontSize: 75, color: Color(0xFF2E1414))),
                                  textBuild(description,
                                      textSize: 25,
                                      style: GoogleFonts.actor(
                                          fontSize: 25, color: Color(0xFF2E1414))),
                                  const SizedBox(height: 50),
                                  Row(
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xff5B6D99)),
                                        child: textBuild(startNow,
                                            textSize: 25,
                                            style: GoogleFonts.acme(
                                                fontSize: 25, color: Color(0xFF2E1414))),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xffCCA176)),
                                        child: textBuild(readMore,
                                            textSize: 25,
                                            style: GoogleFonts.acme(
                                                fontSize: 25, color: Color(0xFF2E1414))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  NeoButton()
                                ],
                              ),
                            ),
                            Flexible(
                                child: Image.asset(
                              'assets/sofaset/furniture.png',
                              scale: 2,
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
          decoration: BoxDecoration(
              // color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 30,
                    spreadRadius: 1,
                    color: hoverIndex.value == index
                        ? Color(0xffCCA176)
                        : Colors.transparent)
              ]),
          child: Center(
            child: Text(
              style: GoogleFonts.inder(
                fontSize: 25,
                color: hoverIndex.value == index ? Colors.black : Color(0xFF412927),
              ),
              /* style: TextStyle(
                color: hoverIndex.value == index ? Colors.black : Colors.white,
                */ /*shadows:isHover.value ? [
                  const Shadow(
                    color: Colors.grey,
                    offset: Offset(10, 0),
                    blurRadius: 20,

                  ),
                ] : [],*/ /*
              ),*/
              title,
            ),
          ),
        ),
      ),
    );
  }

  Widget textBuild(title, {double textSize = 16, TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        style: style ?? TextStyle(fontSize: textSize, color: Colors.white),
        title,
      ),
    );
  }

  Widget menuEnd(title, icon) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Color(0xFF412927)),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(color: Color(0xFF412927)),
            ),
          ],
        ));
  }
}


