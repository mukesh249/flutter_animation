import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoCustomShape extends StatelessWidget {
  DemoCustomShape({super.key});

  var isStroke = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        color: Colors.lime,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey,
              child: CustomPaint(
                painter: CustomShapeLine(),
                size: const Size(100, 2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                isStroke.value = !isStroke.value;
              },
              child: Obx(
                () => CustomPaint(
                  painter: CustomShapeCircle(isStroke.value
                      ? PaintingStyle.stroke
                      : PaintingStyle.fill),
                  size: const Size(100, 100),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
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
            const SizedBox(
              height: 10,
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
                const SizedBox(width: 20,),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapeLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.pink;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapeCircle extends CustomPainter {
  var style;

  CustomShapeCircle(PaintingStyle paintingStyle) {
    style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.pink;
    paint.style = style;
    Offset offset = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(offset, 50, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapeRect extends CustomPainter {
  var style;

  CustomShapeRect(PaintingStyle paintingStyle) {
    style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.pink;
    paint.style = style;
    Offset center = Offset(size.width / 2, size.height / 2);

    ///Draw Rectangle Using Rect
    /*canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        paint);*/

    ///Draw Rectangle Using circle
    canvas.drawRect(Rect.fromCircle(center: center, radius: 50), paint);

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
    Offset center = Offset(size.width / 2, size.height / 2);
    Rect rect1 = const Rect.fromLTRB(0,0,100,200);

    ///Draw Rectangle Using Rect
    /*canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        paint);*/

    ///Draw Rectangle Using circle
    canvas.drawOval(rect1, paint);

    ///Draw Rectangle Using Offset
    // canvas.drawRect(Rect.fromPoints(Offset(size.width,size.height),const Offset(0,0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
