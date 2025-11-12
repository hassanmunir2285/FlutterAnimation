import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 1) GLOBAL BLoC OBSERVER
/// -------------------------
/// Observe transitions/errors globally - helpful for debugging.
class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // prints event, currentState, nextState
    debugPrint('🔁 onTransition -- ${bloc.runtimeType} : $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('❗ onError -- ${bloc.runtimeType} : $error');
    super.onError(bloc, error, stackTrace);
  }
}
