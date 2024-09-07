import 'package:flutter/material.dart';
import 'package:flutter_animation/common/size_config.dart';
import 'package:flutter_animation/ui/furniture/common/colors.dart';
import 'package:flutter_animation/ui/furniture/controllers/furniture_details_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FurnitureDetails extends StatelessWidget {
  FurnitureDetails({super.key});

  final controller = Get.put(FurnitureDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CurvePath(),
                child: Hero(
                  tag:  controller.collectionDetailsModel.imagePath,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              controller.collectionDetailsModel.imagePath)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(
                        text:
                            "${controller.collectionDetailsModel.name.split(" ").first.toUpperCase()}\n",
                        style: GoogleFonts.antonio(
                            height: 1,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.screenWidth * 0.12),
                        children: [
                          TextSpan(
                            text: controller.collectionDetailsModel.name
                                .split(" ")
                                .last
                                .toUpperCase(),
                            style: GoogleFonts.antonio(
                                height: 1,
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 60),
                          )
                        ])),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${controller.collectionDetailsModel.price}",
                          style: GoogleFonts.antonio(
                              color: textColor, letterSpacing: -3, fontSize: 50),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 6,
                          child: ListView.builder(
                            shrinkWrap: true,
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: index == 3 ? 30 : 15,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: index == 3 ? textColor : Colors.white24,
                                      borderRadius: BorderRadius.circular(10)),
                                );
                              }),
                        )
                      ],
                    ),
                    const SizedBox(height: 30,),

                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(controller.collectionDetailsModel.description,
              style: const TextStyle(
                fontSize: 18,
                color: textColor
              ),),)
            ],
          ),
          SafeArea(
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                    color: backGroundColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
                onPressed: () {},
                height: 70,
                color: accentColor,
                padding: const EdgeInsets.symmetric(horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                      color: backGroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.bookmark_outline,
                color: Colors.grey.shade700,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CurvePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    Path path = Path();
    path.lineTo(0, h * 0.85);
    path.quadraticBezierTo(
        size.width * 0.50, size.height, size.width, size.height * 0.85);

    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
