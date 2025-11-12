import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() => runApp(const MaterialApp(home: PhysicsExample()));

class PhysicsExample extends StatefulWidget {
  const PhysicsExample({super.key});
  @override
  State<PhysicsExample> createState() => _PhysicsExampleState();
}

class _PhysicsExampleState extends State<PhysicsExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController c;
  late final Animation<double> anim;

  @override
  void initState() {
    super.initState();
    c = AnimationController.unbounded(vsync: this);
    final spring = SpringDescription(mass: 1, stiffness: 70, damping: 2);
    final sim = SpringSimulation(spring, 0, 1, 0); // from 0 to 1
    c.animateWith(sim);
    anim = c; // use the raw controller value
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Physics (SpringSimulation)')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform.translate(
                offset: Offset(10, 200 - anim.value * 200),
                child: const Icon(Icons.sports_soccer, size: 48),
              ),
            ),
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform.translate(
                offset: Offset(10, 200 - anim.value * 200),
                child: const Icon(Icons.sports_volleyball, size: 48),
              ),
            ),
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform.translate(
                offset: Offset(10, 200 - anim.value * 200),
                child: const Icon(Icons.sports_basketball_outlined, size: 48),
              ),
            ),
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform.translate(
                offset: Offset(10, 200 - anim.value * 200),
                child: const Icon(Icons.sports_basketball_rounded, size: 48),
              ),
            ),
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform.translate(
                offset: Offset(10, 200 - anim.value * 200),
                child: const Icon(Icons.circle, size: 48),
              ),
            ),
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform.translate(
                offset: Offset(0, 200 - anim.value * 200),
                child: const Icon(Icons.sports_baseball, size: 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


