import 'package:bloc/bloc.dart';

/// 3) COUNTER BLOC (events/states)
/// -------------------------
/// A more explicit event-driven Bloc example.
abstract class CounterEvent {}

class CounterIncremented extends CounterEvent {}

class CounterDecremented extends CounterEvent {}

/// For simple numeric state we keep state as `int`, but you could create classes.
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncremented>((event, emit) => emit(state + 1));
    on<CounterDecremented>((event, emit) => emit(state - 1));
  }
}
