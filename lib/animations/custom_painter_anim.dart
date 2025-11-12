import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CustomPainterAnim()));

class CustomPainterAnim extends StatefulWidget {
  const CustomPainterAnim({super.key});
  @override
  State<CustomPainterAnim> createState() => _CustomPainterAnimState();
}

class _CustomPainterAnimState extends State<CustomPainterAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController c;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomPainter + Animation')),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: AnimatedBuilder(
            animation: c,
            builder: (_, __) =>
                CustomPaint(painter: _CirclePainter(progress: c.value)),
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  _CirclePainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.4;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    // draw background circle
    paint.color = Colors.grey.withOpacity(0.3);
    canvas.drawCircle(center, radius, paint);
    // draw arc based on progress
    paint.color = Colors.blue;
    final sweep = 2 * 3.1415926 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926 / 2,
      sweep,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CirclePainter old) => old.progress != progress;
}


