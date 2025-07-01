import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class DemoCustomShape extends StatelessWidget {
  DemoCustomShape({super.key});

  var isStroke = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        color: Colors.lime,
        child: InkWell(
          onTap: () {
            isStroke.value = !isStroke.value;
          },
          child: Obx(
            () => CustomPaint(
              size: Size(Get.width, Get.height),
              painter: CustomShapeCircle(
                  isStroke.value ? PaintingStyle.stroke : PaintingStyle.fill),
            ),
          ),
        ),
        /* child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            // Container(
            //   color: Colors.grey,
            //   child: CustomPaint(
            //     painter: CustomShapeLine(),
            //   ),
            // ),
            InkWell(
              onTap: () {
                isStroke.value = !isStroke.value;
              },
              child: Obx(
                () => CustomPaint(
                  painter: CustomShapeCircle(isStroke.value
                      ? PaintingStyle.stroke
                      : PaintingStyle.fill),
                ),
              ),
            ),
           */ /* GestureDetector(
              onTap: () {
                isStroke.value = !isStroke.value;
              },
              child: Obx(
                () => CustomPaint(
                  painter: CustomShapeRect(isStroke.value
                      ? PaintingStyle.stroke
                      : PaintingStyle.fill),
                  size: const Size(100, 100),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    isStroke.value = !isStroke.value;
                  },
                  child: Obx(
                    () => CustomPaint(
                      painter: CustomShapeOval(isStroke.value
                          ? PaintingStyle.stroke
                          : PaintingStyle.fill),
                      size: const Size(100, 100),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    isStroke.value = !isStroke.value;
                  },
                  child: Obx(
                    () => CustomPaint(
                      painter: CustomShapeOval(isStroke.value
                          ? PaintingStyle.stroke
                          : PaintingStyle.stroke),
                      size: const Size(100, 100),
                      child: Transform(
                          alignment: Alignment.topLeft,
                          transform: Matrix4.rotationZ(1.57),
                          child: const Text(
                            "Mukesh",
                            style: TextStyle(
                                fontSize: 25,
                                height: .5,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          )),
                    ),
                  ),
                ),
              ],
            )*/ /*
          ],
        ),*/
      ),
    );
  }
}

/*class CustomShapeLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.pink;
    canvas.drawLine(const Offset(10, 0), Offset(0, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}*/

class CustomShapeCircle extends CustomPainter {
  PaintingStyle? style;

  CustomShapeCircle(PaintingStyle paintingStyle) {
    style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw Circle
    canvas.drawCircle(Offset(size.width/2, 100), 50, paint);

    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);


    // Draw Triangle
    paint.color = Colors.green;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.2, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.4);
    path.close();
    canvas.drawPath(path, paint);

    // Draw Triangle
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.2, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.4);
    path.close();
    canvas.drawPath(path, paint);

    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    // Offset center = Offset(size.width / 2, size.height / 2);
    Rect bigRect = const Rect.fromLTRB(10, 20, 100, 200);
    Rect smallRect = const Rect.fromLTRB(20, 30, 100, 200);
    RRect bigRRect = RRect.fromRectXY(bigRect, 70, 57);
    RRect smallRRect = RRect.fromRectXY(smallRect, 70, 74);

    ///Draw Rectangle Using Rect
    /*canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        paint);*/

    ///Draw Rectangle Using circle
    canvas.drawDRRect(bigRRect, smallRRect, paint);

    ///Draw Rectangle Using Offset
    // canvas.drawRect(Rect.fromPoints(Offset(size.width,size.height),const Offset(0,0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/*class CustomShapeRect extends CustomPainter {
  PaintingStyle? style;

  CustomShapeRect(PaintingStyle paintingStyle) {
    style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.pink
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          [Colors.pink, Colors.amber, Colors.white]);
    // Offset center = Offset(size.width / 2, size.height / 2);

    ///Draw Rectangle Using Rect
    */ /*canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        paint);*/ /*

    canvas.clipRect(Offset.zero & size);
    canvas.drawPaint(paint);

    ///Draw Rectangle Using circle
    // canvas.drawRect(Rect.fromCircle(center: center, radius: 50), paint);

    ///Draw Rectangle Using Offset
    // canvas.drawRect(Rect.fromPoints(Offset(size.width,size.height),const Offset(0,0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapeOval extends CustomPainter {
  var style;

  CustomShapeOval(PaintingStyle paintingStyle) {
    style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.pink;
    paint.style = style;
    // Offset center = Offset(size.width / 2, size.height / 2);
    Rect bigRect = const Rect.fromLTRB(10, 20, 100, 200);
    Rect smallRect = const Rect.fromLTRB(20, 30, 100, 200);
    RRect bigRRect = RRect.fromRectXY(bigRect, 70, 57);
    RRect smallRRect = RRect.fromRectXY(smallRect, 70, 74);

    ///Draw Rectangle Using Rect
    */ /*canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        paint);*/ /*

    ///Draw Rectangle Using circle
    canvas.drawDRRect(bigRRect, smallRRect, paint);

    ///Draw Rectangle Using Offset
    // canvas.drawRect(Rect.fromPoints(Offset(size.width,size.height),const Offset(0,0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}*/
