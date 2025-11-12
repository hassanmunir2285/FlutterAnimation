import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CustomShapes()));

class CustomShapes extends StatelessWidget {
  const CustomShapes({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomPainter Shapes')),
      body: Center(
        child: CustomPaint(
          size: const Size(200, 200),
          painter: _ShapePainter(),
        ),
      ),
    );
  }
}

class _ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.pink, Colors.orange],
      ).createShader(rect);
    // Draw rounded rect with gradient
    canvas.drawRRect(RRect.fromRectXY(rect.deflate(10), 24, 24), paint);

    // Draw a path (triangle)
    final path = Path();
    path.moveTo(size.width / 2, 20);
    path.lineTo(20, size.height - 20);
    path.lineTo(size.width - 20, size.height - 20);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


