import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ACExample()));

class ACExample extends StatefulWidget {
  const ACExample({super.key});
  @override
  State<ACExample> createState() => _ACExampleState();
}

class _ACExampleState extends State<ACExample> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> sizeTween;

  @override
  void initState() {
    super.initState();
    // vsync provided by SingleTickerProviderStateMixin -> prevents offscreen tick waste
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // Tween maps controller's 0..1 to 50..200
    sizeTween = Tween<double>(begin: 50, end: 200).animate(controller)
      ..addListener(() => setState(() {}));

    // lifecycle example: start forward then reverse automatically
    controller.forward().then((_) => controller.reverse());
  }

  @override
  void dispose() {
    controller.dispose(); // always dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimationController + Tween')),
      body: Center(child: Container(width: sizeTween.value, height: sizeTween.value, color: Colors.blue)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // toggle forward / reverse / repeat
          if (controller.status == AnimationStatus.dismissed) controller.repeat(reverse: true);
          else controller.stop();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

