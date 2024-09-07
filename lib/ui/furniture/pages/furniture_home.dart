import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/ui/furniture/common/colors.dart';
import 'package:flutter_animation/ui/furniture/controllers/furniture_home_controller.dart';
import 'package:flutter_animation/ui/furniture/pages/items_view_page.dart';
import 'package:flutter_animation/ui/furniture/models/furniture_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class FurnitureHome extends StatelessWidget {
  FurnitureHome({super.key});

  final controller = Get.put(FurnitureHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/furniture-image/menu-icon.png",
                        height: 30),
                    Image.asset("assets/furniture-image/search.png", height: 30)
                  ],
                ),
                Positioned(
                    left: 50,
                    top: -10,
                    child: Column(
                      children: [
                        Text.rich(TextSpan(
                            text: "New\n",
                            style: GoogleFonts.antonio(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 45),
                            children: [
                              TextSpan(
                                text: "COLLECTION\n",
                                style: GoogleFonts.antonio(
                                    height: 0.6,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45),
                              )
                            ])),
                      ],
                    ))
              ],
            ),
            const SizedBox(height: 80),
            ReadMoreText(
              "The new Flexform outdoor collection is permeated with fresh, inventive style and pioneering pioneering pioneering pioneering pioneering pioneering pioneering pioneering pioneering design ",
              trimLines: 2,
              trimMode: TrimMode.Line,
              style: GoogleFonts.antonio(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              trimCollapsedText: "Show more",
              trimExpandedText: "Show less",
              lessStyle: GoogleFonts.antonio(
                  decoration: TextDecoration.underline,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              moreStyle: GoogleFonts.antonio(
                  decoration: TextDecoration.underline,
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                  itemCount: furnitureCategory.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedIndex.value = index;
                      },
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(right: 20, left: 10.0),
                          child: Text(
                            furnitureCategory[index],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: controller.selectedIndex == index
                                    ? Colors.amber
                                    : Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: MasonryGridView.builder(
                itemCount: mockData.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var item = mockData[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ItemsViewPage(), arguments: item);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Hero(
                                  tag:item.imagePath,
                                    child: Image.asset(item.imagePath)),
                                 Positioned(
                                    top: 15,
                                    right: 15,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                      ),
                                        child: Icon(Icons.bookmark_outline)))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${item.name.split(" ").first}\n${item.name.split(" ")[0]}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    height: 1.1),
                              ),
                              Text(
                                "\$${item.price}",
                                style: GoogleFonts.antonio(
                                    letterSpacing: -1,
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
