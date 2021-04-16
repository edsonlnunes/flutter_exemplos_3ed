import 'package:flutter/material.dart';

import 'counter_notifier.controller.dart';

class CounterNotifierApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterNotifier(),
    );
  }
}

class CounterNotifier extends StatefulWidget {
  @override
  _CounterNotifierState createState() => _CounterNotifierState();
}

class _CounterNotifierState extends State<CounterNotifier> {
  final controller = CounterController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: ValueListenableBuilder<int>(
                    valueListenable: controller.counter,
                    builder: (_, counter, __) {
                      return Text(
                        counter.toString(),
                      );
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.increment();
        },
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Você clicou tantas vezes:',
              style: Theme.of(context).textTheme.headline5,
            ),
            ValueListenableBuilder<int>(
              valueListenable: controller.counter,
              builder: (_, counter, __) {
                print('passou aqui');
                return Text(
                  counter.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
