import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'counter.store.dart';

class CounterMobxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterMobxPage(),
    );
  }
}

class CounterMobxPage extends StatefulWidget {
  @override
  _CounterMobxPageState createState() => _CounterMobxPageState();
}

class _CounterMobxPageState extends State<CounterMobxPage> {
  final store = CounterStore();
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
                  child: Observer(
                    builder: (_) {
                      return Text(
                        store.counter.toString(),
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
          store.increment();
        },
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Você clicou tantas vezes:',
                style: Theme.of(context).textTheme.headline5,
              ),
              Observer(
                builder: (_) {
                  print('passou no observer');
                  return Text(
                    store.counter.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite algo',
                      ),
                      onChanged: store.setText,
                    ),
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      store.add();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    print('atualizou a lista');
                    return ListView.builder(
                      itemCount: store.frases.length,
                      itemBuilder: (_, index) {
                        return Text(store.frases[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
