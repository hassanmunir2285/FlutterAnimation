import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_counter_card.dart';
import 'cubit_counter_card.dart';
import 'login_bloc.dart';
import 'theme_cubit.dart';
import 'selector_example.dart';

/// 7) HOME PAGE - demonstrates many widgets & usages
/// -------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiBlocListener demonstrates reacting to multiple bloc state changes
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // navigate on success (side-effect)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login success: ${state.token}')),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed: ${state.message}')),
              );
            }
          },
        ),
        // you can add more listeners for other blocs
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC All-in-One Example'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () =>
                  context.read<ThemeCubit>().toggle(), // context.read()
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionTitle('Cubit Counter (simple)'),
                CubitCounterCard(),
                SizedBox(height: 12),
                SectionTitle('Bloc Counter (events & states)'),
                BlocCounterCard(),
                SizedBox(height: 12),
                SectionTitle('Login (async)'),
                _LoginCard(),
                SizedBox(height: 12),
                SectionTitle('Selectors & context.watch/select usage'),
                SelectorExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small helper for section titles
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

/// Login card widget for demonstrating async login with Bloc
class _LoginCard extends StatefulWidget {
  @override
  State<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is LoginLoading ? null : () {
                    context.read<LoginBloc>().add(
                      LoginRequested(
                        username: _usernameController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  child: state is LoginLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                );
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Text('Success: ${state.token}', style: const TextStyle(color: Colors.green));
                } else if (state is LoginFailure) {
                  return Text('Error: ${state.message}', style: const TextStyle(color: Colors.red));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
