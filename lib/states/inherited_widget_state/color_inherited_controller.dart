import 'package:flutter/material.dart';

// 🔹 Step 1b: Create Color InheritedWidget (also exposes a toggle callback)
class ColorInheritedWidget extends InheritedWidget {
  final Color color;
  final VoidCallback toggleColor;

  const ColorInheritedWidget({
    super.key,
    required this.color,
    required this.toggleColor,
    required super.child,
  });

  // Helper method to access it
  static ColorInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(ColorInheritedWidget oldWidget) {
    return oldWidget.color != color;
  }
}
