import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerState/provider_controller.dart';

class LocalCounterPage extends StatelessWidget {
  const LocalCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Change this to use LocalCounter instead of Counter
    final localCounter = context.watch<LocalCounter>();

    return Scaffold(
      appBar: AppBar(title: const Text('Local Counter Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Local Counter Value:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              '${localCounter.value}', // Use value instead of count
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                localCounter.increment();
              },
              child: const Text('Increment Local Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
