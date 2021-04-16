import 'package:flutter/widgets.dart';

class CounterController {
  ValueNotifier<int> counter = ValueNotifier(0);

  void increment() {
    counter.value++;
  }
}
