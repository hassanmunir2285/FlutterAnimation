//8) CubitCounterCard - uses BlocBuilder and context.watch / context.read
/// -------------------------
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

class CubitCounterCard extends StatelessWidget {
  const CubitCounterCard({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch<T>() subscribes and rebuilds when T (Cubit) state changes.
    final cubitValue = context.watch<CounterCubit>().state;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text('Value (context.watch): $cubitValue'),
            const SizedBox(height: 8),
            BlocBuilder<CounterCubit, int>(
              builder: (context, count) {
                // here 'count' is the cubit's state (int)
                return Text(
                  'Value (BlocBuilder): $count',
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterCubit>().decrement(),
                  // read: don't subscribe
                  child: const Text('-'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => context.read<CounterCubit>().increment(),
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('NOTE: Cubit exposes methods directly (increment/decrement).'),
          ],
        ),
      ),
    );
  }
}
