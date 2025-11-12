import 'package:flutter/material.dart';

class SetStateScreen extends StatefulWidget {
  const SetStateScreen({super.key});
  @override
  State<SetStateScreen> createState() => _SetStateScreenState();
}

class _SetStateScreenState extends State<SetStateScreen> {
  // Initial list
  List<String> _items = ['Apple', 'Banana', 'orange'];

  void _addItem() {
    setState(() {
      _items.add('Item ${_items.length + 1}');
    });
  }

  int _count = 0;

  void _increment() {
    setState(() {
      _count++; // mutate state inside setState callback
    });
  }

  bool showDetails = false;

  String _data = "loading...";

  // Fake async function to simulate fetching data from network
  Future<String> fetchFromNetwork() async {
    await Future.delayed(const Duration(seconds: 5)); // pretend delay
    return "Fetched data from server ✅";
  }

  Future<void> _loadData() async {
    final fetched = await fetchFromNetwork(); // pretend async fetch
    if (!mounted) return; // safeguard
    setState(() {
      _data = fetched;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // automatically load when screen opens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => setState(() => showDetails = !showDetails),
              child: Text(showDetails ? 'Hide' : 'Show'),
            ),
            Text('Count: $_count', style: const TextStyle(fontSize: 24)),
            Text(_data, style: const TextStyle(fontSize: 24)),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: Text(_items[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            IconButton(
              onPressed: () {
                _increment();
              },
              icon: Icon(Icons.add),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {
                _addItem();
              },
              child: const Text('Add List Item'),
            ),
          ],
        ),
      ),
    );
  }
}
