import 'package:flutter/material.dart';

extension ColorUtils on Color {
  Color? mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}

final List<Color> gradient = [
  Colors.yellow.withOpacity(0.7),
  Colors.yellow.withOpacity(0.4),
  Colors.transparent
];
