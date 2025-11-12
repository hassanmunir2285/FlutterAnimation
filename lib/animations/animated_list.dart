import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: AnimatedListDemo()));

class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({super.key});
  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> key = GlobalKey();
  final List<int> items = [];

  void addItem() {
    final index = items.length;
    items.add(index);
    key.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 500),
    );
  }

  void removeItem() {
    if (items.isEmpty) return;
    final removed = items.removeLast();
    key.currentState?.removeItem(items.length, (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Removed $removed')),
      );
    }, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedList')),
      body: AnimatedList(
        key: key,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ListTile(title: Text('Item ${items[index]}')),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: addItem,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: removeItem,
            heroTag: 'b',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}


