import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StaggeredExample()));

class StaggeredExample extends StatefulWidget {
  const StaggeredExample({super.key});
  @override
  State<StaggeredExample> createState() => _StaggeredExampleState();
}

class _StaggeredExampleState extends State<StaggeredExample> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  late final Animation<double> boxGrow;
  late final Animation<double> fadeIn;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    // box grows during 0.0 - 0.6 of controller
    boxGrow = Tween<double>(begin: 50, end: 200).animate(CurvedAnimation(parent: c, curve: const Interval(0.0, 0.6, curve: Curves.ease)));
    // fade in during 0.6 - 1.0
    fadeIn = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: c, curve: const Interval(0.6, 1.0, curve: Curves.easeIn)));
    c.forward();
  }

  @override
  void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered (Interval)')),
      body: Center(
        child: AnimatedBuilder(
          animation: c,
          builder: (_, __) => Opacity(
            opacity: fadeIn.value,
            child: Container(width: boxGrow.value, height: boxGrow.value, color: Colors.purple),
          ),
        ),
      ),
    );
  }
}

