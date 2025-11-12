import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

/// 9) BlocCounterCard - uses CounterBloc (events) + BlocConsumer + BlocSelector
class BlocCounterCard extends StatelessWidget {
  const BlocCounterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            BlocConsumer<CounterBloc, int>(
              listenWhen: (previous, current) => current != previous,
              listener: (context, state) {
                if (state == 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Counter reached 5 (Bloc)!')),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Text('Bloc counter value: $state',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              context.read<CounterBloc>().add(CounterDecremented()),
                          child: const Text('-'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<CounterBloc>().add(CounterIncremented()),
                          child: const Text('+'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            BlocSelector<CounterBloc, int, bool>(
              selector: (state) => state.isEven,
              builder: (context, isEven) {
                return Text('Bloc counter isEven (selector): $isEven');
              },
            ),
          ],
        ),
      ),
    );
  }
}



