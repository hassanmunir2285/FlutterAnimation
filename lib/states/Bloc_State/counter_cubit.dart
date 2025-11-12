import 'dart:async';

import 'package:bloc/bloc.dart';

/// 2) COUNTER CUBIT (simple)
/// -------------------------
/// A Cubit holds a single state type (here `int`) and exposes methods to emit.
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0) {
    // Example of starting a periodic side-effect (not required).
    _startAutoIncrement();
  }

  Timer? _timer;

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  /// Demonstrates cancellation & resource cleanup
  void _startAutoIncrement() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      // emit carefully from a timer (side-effect)
      emit(state + 1);
    });
  }

  @override
  Future<void> close() {
    // cancel resources when cubit is closed
    _timer?.cancel();
    return super.close();
  }
}
