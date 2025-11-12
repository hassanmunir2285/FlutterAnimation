import 'package:flutter/material.dart';

import 'color_inherited_controller.dart';
import 'counter_inherited_controller.dart';

// 🔹 Step 2: A Stateful screen that provides the CounterInheritedWidget
class InheritedWidgetScreen extends StatefulWidget {
  const InheritedWidgetScreen({super.key});

  @override
  State<InheritedWidgetScreen> createState() => _InheritedWidgetScreenState();
}

class _InheritedWidgetScreenState extends State<InheritedWidgetScreen> {
  int _counter = 0;

  void decrementCounter() {
    if (_counter > 0) {
      setState(() => _counter--);
    }
  }

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    // NOTE:
    // Wrap the CounterInheritedWidget with ColorStateClass (which provides ColorInheritedWidget)
    // so that InheritedChildClass can access BOTH inherited widgets from its BuildContext.
    return ColorStateClass(
      child: CounterInheritedWidget(
        counter: _counter,
        increment: _incrementCounter,
        decrementFun: decrementCounter,
        child: const InheritedChildClass(),
      ),
    );
  }
}

// 🔹 Step 2 (color provider): make it accept a child so it can wrap other providers
class ColorStateClass extends StatefulWidget {
  final Widget child;
  const ColorStateClass({required this.child, super.key});

  @override
  State<ColorStateClass> createState() => _ColorStateClassState();
}

class _ColorStateClassState extends State<ColorStateClass> {
  bool _isBlue = true;
  bool _isRed = false;

  Color get currentColor {
    if (_isBlue && _isRed) {
      return Colors.blueAccent; // case 1
    } else if (_isBlue && !_isRed) {
      return Colors.red; // case 2
    } else if (!_isBlue && _isRed) {
      return Colors.green; // case 3
    } else {
      return Colors.yellow; // case 4
    }
  }

  void _toggleColor() {
    setState(() {
      _isBlue = !_isBlue;
      if (_isBlue) {
        _isRed = !_isRed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorInheritedWidget(
      color: currentColor,
      toggleColor: _toggleColor,
      child: widget.child,
    );
  }
}

// 🔹 Step 3: Child widget(s) that consume the inherited data.
// Put consumers in separate widgets so their `context` is below the provider.
class InheritedChildClass extends StatelessWidget {
  const InheritedChildClass({super.key});

  @override
  Widget build(BuildContext context) {
    // Both inherited widgets are available because InheritedChildClass is inside
    // ColorInheritedWidget -> CounterInheritedWidget (as built above).
    final counterProvider = CounterInheritedWidget.of(context);
    final colorProvider = ColorInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('InheritedWidget Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Counter Value: ${counterProvider.counter}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              "Hello Flutter!",
              style: TextStyle(fontSize: 30, color: colorProvider.color),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // this button toggles the color provided by ColorInheritedWidget
              onPressed: () {
                colorProvider.toggleColor();
              },
              child: const Icon(Icons.color_lens),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // no-op here; actual increment/decrement are handled by the IconButtons below
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Decrement',
              onPressed: () {
                counterProvider.decrementFun();
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 12),
            IconButton(
              tooltip: 'Increment',
              onPressed: () {
                counterProvider.increment();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
