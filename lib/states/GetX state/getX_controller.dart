import 'package:get/get.dart';

// Method A
class CounterController extends GetxController {
  var count = 0.obs; // reactive variable
  void increment() => count.value++;
}

// Method B
class SimpleController extends GetxController {
  int count = 0;
  void increment() {
    count++;
    update(); // notifies GetBuilder widgets
  }
}
