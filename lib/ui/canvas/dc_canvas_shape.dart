import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const SignatureApp());
}

class SignatureApp extends StatelessWidget {
  const SignatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignatureScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final GlobalKey _signatureKey = GlobalKey();
  late EasySignaturePadController _controller;
  String shape = "circle"; // Change to "rectangle" if needed

  @override
  void initState() {
    super.initState();
    _controller = EasySignaturePadController();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.storage.request();
  }

  Future<void> _saveSignature() async {
    try {
      final boundary = _signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save signature')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signature Pad with Shape')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: RepaintBoundary(
              key: _signatureKey,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: ShapePainter(shape: shape),
                    size: Size.infinite,
                  ),
                  EasySignaturePad(
                    controller: _controller,
                    penColor: Colors.black,
                    strokeWidth: 3.0,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _controller.clear(),
                child: const Text("Clear"),
              ),
              ElevatedButton(
                onPressed: _saveSignature,
                child: const Text("Save"),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final String shape;

  ShapePainter({required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    if (shape == "circle") {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width < size.height ? size.width * 0.3 : size.height * 0.3;
      canvas.drawCircle(center, radius, paint);
    } else if (shape == "rectangle") {
      final rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.6,
        height: size.height * 0.4,
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
