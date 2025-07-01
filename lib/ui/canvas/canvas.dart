import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class CanvasController extends GetxController {
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);

  Future<void> captureCanvas(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      imageBytes.value = byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error capturing canvas: $e');
    }
  }
}

class CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    // Draw Circle
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.3), 50, paint);

    // Draw Rectangle
    paint.color = Colors.green;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.5, size.height * 0.12, 150, 100), paint);

    // Draw Triangle
    paint.color = Colors.red;
    var path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.7, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CanvasScreen extends StatelessWidget {
  final controller = Get.put(CanvasController());
  final GlobalKey canvasKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canvas with Shapes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: canvasKey,
              child: CustomPaint(
                size: Size(Get.width, 300),
                painter: CanvasPainter(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.captureCanvas(canvasKey),
              child: Text('Show Image'),
            ),
            Obx(() => controller.imageBytes.value != null
                ? Image.memory(controller.imageBytes.value!)
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}
