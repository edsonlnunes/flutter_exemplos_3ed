import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'content.widget.dart';
import 'counter_provider.controller.dart';
import 'floating_button_custom.widget.dart';

class CounterProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProviderController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CounterProviderPage(),
      ),
    );
  }
}

class CounterProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('passou pelo build');
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
                  child: Consumer<CounterProviderController>(
                      builder: (_, ctr, ___) {
                    return Text(
                      ctr.counter.toString(),
                    );
                  }),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingButtonCustom(),
      body: SizedBox.expand(
        child: Content(),
      ),
    );
  }
}
