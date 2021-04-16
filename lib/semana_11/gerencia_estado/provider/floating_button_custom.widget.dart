import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_provider.controller.dart';

class FloatingButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<CounterProviderController>(context, listen: false);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        controller.increment();
      },
    );
  }
}
