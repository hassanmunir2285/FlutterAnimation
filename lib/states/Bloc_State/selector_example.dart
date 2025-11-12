import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';
import 'counter_cubit.dart';

/// 11) SelectorExample: demonstrates context.select vs BlocSelector
class SelectorExample extends StatelessWidget {
  const SelectorExample({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitEven = context.select((CounterCubit c) => c.state.isEven);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text('context.select -> CounterCubit.isEven = $cubitEven'),
            const SizedBox(height: 8),
            BlocSelector<CounterBloc, int, String>(
              selector: (state) => 'value=${state}',
              builder: (context, selectedString) {
                return Text('BlocSelector produced string: $selectedString');
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: context.read does not subscribe; context.watch/select subscribe.',
            ),
          ],
        ),
      ),
    );
  }
}





