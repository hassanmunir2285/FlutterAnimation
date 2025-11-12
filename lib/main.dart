import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

// Auth screens
import 'auth/login_screen.dart';
import 'auth/signup_screen.dart';

// State management examples
import 'states/set_state.dart';
import 'states/GetX state/getX_example1.dart' as getx;
import 'states/providerState/provider_example1.dart';
import 'states/inherited_widget_state/inherited_widget.dart';

// Bloc state management
import 'states/Bloc_State/counter_bloc.dart';
import 'states/Bloc_State/counter_cubit.dart';
import 'states/Bloc_State/global_bloc_observer.dart';
import 'states/Bloc_State/home_page_screen.dart';
import 'states/Bloc_State/login_bloc.dart';
import 'states/Bloc_State/theme_cubit.dart';

void main() {
  Bloc.observer = AppBlocObserver(); // Set global observer
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Bloc providers for state management
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Examples Hub',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            initialRoute: '/',
            routes: {
              // Main navigation
              '/': (context) => LoginScreen(),
              '/signup': (context) => const SignupScreen(),
              
              // State management examples
              '/setState': (context) => const SetStateScreen(),
              '/getX': (context) => getx.getXStateScreen(),
              '/provider': (context) => ProviderExample1(),
              '/inherited': (context) => const InheritedWidgetScreen(),
              '/bloc': (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
