import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_provider.controller.dart';

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Você clicou tantas vezes:',
          style: Theme.of(context).textTheme.headline5,
        ),
        Consumer<CounterProviderController>(
          builder: (_, ctr, ___) {
            return Text(
              ctr.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
      ],
    );
  }
}
