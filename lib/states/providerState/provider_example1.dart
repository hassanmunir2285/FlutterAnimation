import 'package:flutter/material.dart';
import 'package:flutter_project_1/states/providerState/proxyProvider.dart';
import 'package:provider/provider.dart';
import '../providerState/provider_controller.dart';
import 'localCounterScreen.dart';

class ProviderExample1 extends StatelessWidget {
  ProviderExample1({super.key});

  // demonstrates mixing Provider with local setState
  bool showExtra = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1) Global ChangeNotifierProvider (single)
        ChangeNotifierProvider<Counter>(create: (_) => Counter()),

        // 2) ProxyProvider: creates MultiplierService depending on Counter
        //    It will be recreated each time Counter changes.
        ProxyProvider<Counter, MultiplierService>(
          update: (context, counter, previous) =>
              MultiplierService(counter.count, factor: previous?.factor ?? 2),
        ),

        // 3) StreamProvider
        StreamProvider<int>(create: (_) => tickingStream(), initialData: 0),

        // 4) FutureProvider
        FutureProvider<String>(
          create: (_) => fetchUsername(),
          initialData: 'Loading...', // shown until future completes
        ),
      ],
      child: Builder(
        builder: (context) {
          // Provider.of(context) -> this listens by default (equivalent to context.watch)
          // here we show the usage, but later we'll prefer context.watch/read
          final counterViaProviderOf = Provider.of<Counter>(context);

          // context.watch<T>() - rebuild when T changes (recommended for simple reads)
          final globalCount = context.watch<Counter>().count;

          // context.read<T>() -> read without listening (use inside callbacks)
          // (we will use it in onPressed handlers)

          // the StreamProvider value (tick) and FutureProvider value (username)
          final tick = context.watch<int>(); // provided by StreamProvider
          final username = context
              .watch<String>(); // provided by FutureProvider

          // MultiplierService provided by ProxyProvider (depends on Counter)
          final multiplier = Provider.of<MultiplierService>(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Provider Example')),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // show FutureProvider value (username)
                  Row(
                    children: [
                      const Text('User (FutureProvider): '),
                      Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // show StreamProvider tick
                  Row(
                    children: [
                      const Text('Tick (StreamProvider): '),
                      Text(
                        '$tick s',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // context.watch usage
                  Text(
                    'Global count (context.watch): $globalCount',
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 8),

                  // Consumer - rebuilds only this subtree when Counter changes
                  Consumer<Counter>(
                    builder: (context, counter, child) => Text(
                      'Consumer shows: ${counter.count}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Selector - only rebuilds when the selected value changes (parity)
                  Selector<Counter, bool>(
                    selector: (_, counter) => counter.count.isEven,
                    builder: (context, isEven, child) {
                      return Text(
                        'Selector (parity): ${isEven ? "Even" : "Odd"}',
                        style: const TextStyle(fontSize: 16),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // Show ProxyProvider-derived value
                  Text(
                    'ProxyProvider Multiplied: ${multiplier.multiplied}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  // show Provider.of used above
                  Text(
                    'From Provider.of (listening): ${counterViaProviderOf.count}',
                  ),

                  const SizedBox(height: 12),

                  // Buttons area
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // context.read -> no listening, safe in callbacks
                          context.read<Counter>().increment();
                        },
                        child: const Text('Increment Global Counter'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // use Provider.of with listen: false inside callback
                          Provider.of<Counter>(context, listen: false).setTo(5);
                        },
                        child: const Text(
                          'Set Global to 5 (Provider.of listen:false)',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to a route that has its own local provider (scoping)
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                // Provider + Navigation / Scoping:
                                // Provide a LocalCounter only to this route's subtree.
                                return ChangeNotifierProvider<LocalCounter>(
                                  create: (_) => LocalCounter(),
                                  child: const LocalCounterPage(),
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Open Local Counter (scoped provider)',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // show extra widgets controlled by local setState
                  if (showExtra)
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text('Extra section (toggled by setState)'),
                            const SizedBox(height: 8),
                            // small control showing both context.read and context.watch usage
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Read-only action:'),
                                IconButton(
                                  onPressed: () {
                                    // context.read doesn't rebuild UI
                                    final current = context
                                        .read<Counter>()
                                        .count;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Read count: $current',
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.pink,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.info_outline),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<Counter>().increment(),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
