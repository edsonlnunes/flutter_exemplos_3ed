import 'package:flutter/cupertino.dart';

class CounterController {
  ValueNotifier<int> counter = ValueNotifier(0);

  void increment() {
    counter.value++;
  }
}
