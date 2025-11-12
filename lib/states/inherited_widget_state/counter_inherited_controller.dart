import 'package:flutter/material.dart';

// 🔹 Step 1: Create Counter InheritedWidget
class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final VoidCallback increment;
  final VoidCallback decrementFun;

  const CounterInheritedWidget({
    super.key,
    required this.counter,
    required this.increment,
    required this.decrementFun,
    required super.child,
  });

  // Helper: access this InheritedWidget from descendants
  static CounterInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}
