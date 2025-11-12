import 'package:flutter/material.dart';

class CombinedAnimationExample extends StatefulWidget {
  const CombinedAnimationExample({super.key});
  @override
  State<CombinedAnimationExample> createState() =>
      _CombinedAnimationExampleState();
}

class _CombinedAnimationExampleState extends State<CombinedAnimationExample>
    with SingleTickerProviderStateMixin {
  // Implicit animation properties
  double _size = 120;
  Color _color = Colors.blue;
  bool _expanded = false;

  // Explicit animation controller + animations
  late final AnimationController _controller;
  late final Animation<double> _rotation; // turns (0..1)
  late final Animation<double> _scale; // scale 1..1.4

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Toggle implicit properties (size + color)
  void _toggleImplicit() {
    setState(() {
      _expanded = !_expanded;
      _size = _expanded ? 180 : 120;
      _color = _expanded ? Colors.deepOrange : Colors.blue;
    });
  }

  // Start or reverse explicit animation (rotation + scale)
  void _toggleExplicit() {
    if (_controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.forward) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Implicit + Explicit Animation')),
      body: Center(
        // Explicit: RotationTransition and ScaleTransition (driven by controller)
        child: RotationTransition(
          turns: _rotation,
          child: ScaleTransition(
            scale: _scale,
            // Implicit: AnimatedContainer changes size & color automatically
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _size,
              height: _size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.flutter_dash,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      // Two buttons to control each animation style
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _toggleImplicit,
                icon: const Icon(Icons.aspect_ratio),
                label: const Text('Implicit: size / color'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _toggleExplicit,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Explicit: rotate / scale'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
