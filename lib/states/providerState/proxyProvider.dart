/// A simple service produced by ProxyProvider that depends on Counter.
class MultiplierService {
  final int base;
  final int factor;
  MultiplierService(this.base, {this.factor = 2});
  int get multiplied => base * factor;
}

/// A stream that ticks every second (for StreamProvider demo)
Stream<int> tickingStream() =>
    Stream.periodic(const Duration(minutes: 1), (i) => i);

/// Simulated async fetch for FutureProvider (e.g., fetch username)
Future<String> fetchUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Hassan Munir'; // pretend this came from network
}
