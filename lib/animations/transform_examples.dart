import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TransformExamples()));

class TransformExamples extends StatefulWidget {
  const TransformExamples({super.key});
  @override
  State<TransformExamples> createState() => _TransformExamplesState();
}

class _TransformExamplesState extends State<TransformExamples> {
  double angle = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transform')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: angle,
              child: const Icon(Icons.accessible_forward_outlined, size: 40),
            ),
            const SizedBox(height: 8),
            Transform.scale(
              scale: 2.4,
              child: const Icon(Icons.android, size: 40),
            ),
            const SizedBox(height: 8),
            Transform(
              transform: Matrix4.skewY(0.3),
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.amber,
                child: const Text('Skew'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => setState(() => angle += 0.5),
              child: const Text('Rotate'),
            ),
          ],
        ),
      ),
    );
  }
}


