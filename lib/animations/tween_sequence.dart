import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TweenSequenceExample()));

class TweenSequenceExample extends StatefulWidget {
  const TweenSequenceExample({super.key});
  @override
  State<TweenSequenceExample> createState() => _TweenSequenceExampleState();
}

class _TweenSequenceExampleState extends State<TweenSequenceExample> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> seq;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

    seq = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 100), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 100, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 50, end: 150), weight: 1),
    ]).animate(controller);
  }

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TweenSequence')),
      body: Center(child: Transform.translate(offset: Offset(seq.value, 0), child: const Icon(Icons.airplanemode_active, size: 48))),
    );
  }
}

