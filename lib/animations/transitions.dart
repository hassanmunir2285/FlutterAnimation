import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TransitionsExample()));

class TransitionsExample extends StatefulWidget {
  const TransitionsExample({super.key});
  @override
  State<TransitionsExample> createState() => _TransitionsExampleState();
}

class _TransitionsExampleState extends State<TransitionsExample> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  late final Animation<double> anim;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    anim = CurvedAnimation(parent: c, curve: Curves.easeInOut);
  }

  @override
  void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transition Widgets')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // ScaleTransition
          ScaleTransition(scale: anim, child: const Icon(Icons.favorite, size: 40)),
          const SizedBox(height: 12),
          // FadeTransition
          FadeTransition(opacity: anim, child: const Text('Fading Text')),
          const SizedBox(height: 12),
          // RotationTransition
          RotationTransition(turns: anim, child: const Icon(Icons.refresh, size: 40)),
          const SizedBox(height: 12),
          // SlideTransition: needs a Tween<Offset>
          SlideTransition(position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(anim),
              child: const Chip(label: Text('SlideUp'))),
          const SizedBox(height: 12),
          // SizeTransition uses an axis factor
          SizeTransition(sizeFactor: anim, axis: Axis.horizontal, axisAlignment: -1.0, child: Container(width: 120, height: 40, color: Colors.teal)),
        ]),
      ),
    );
  }
}

