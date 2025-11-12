import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: First()));

class First extends StatelessWidget {
  const First({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PageRouteBuilder')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go'),
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 800),
                pageBuilder: (_, __, ___) => const Second(),
                transitionsBuilder: (_, animation, __, child) {
                  // scale + fade transition
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween(begin: 0.8, end: 1.0).animate(animation),
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Second extends StatelessWidget {
  const Second({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Second')),
    body: const Center(child: Text('Custom Transition')),
  );
}


