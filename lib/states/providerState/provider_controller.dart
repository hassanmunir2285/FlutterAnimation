import 'package:flutter/cupertino.dart';

/// Simple ChangeNotifier (ChangeNotifier basics)
class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  // used to show Provider.of(context, listen:false) usage
  void setTo(int v) {
    _count = v;
    notifyListeners();
  }
}

/// A local counter to show scoping (different instance than global Counter)
class LocalCounter extends ChangeNotifier {
  int value = 0;
  void increment() {
    value++;
    notifyListeners();
  }
}
