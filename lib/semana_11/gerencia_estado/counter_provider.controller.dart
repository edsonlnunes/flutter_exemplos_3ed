import 'package:flutter/widgets.dart';

class CounterProviderController extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}
