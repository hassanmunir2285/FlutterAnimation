import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: AnimatedWidgetExample()));

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({super.key});
  @override
  State<AnimatedWidgetExample> createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  late final Animation<double> anim;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    anim = Tween(begin: 0.7, end: 1.5).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));
  }

  @override
  void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedWidget Example')),
      body: Center(child: PulsingIcon(animation: anim)),
    );
  }
}

class PulsingIcon extends AnimatedWidget {
  const PulsingIcon({super.key, required Animation<double> animation}) : super(listenable: animation);
  @override
  Widget build(BuildContext context) {
    final anim = listenable as Animation<double>;
    return Transform.scale(scale: anim.value, child: const Icon(Icons.star, size: 50, color: Colors.orange));
  }
}

