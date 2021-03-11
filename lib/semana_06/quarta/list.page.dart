import 'dart:math';

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int tipo = 0;

  final users = [
    {
      'nome': 'Edson',
      'email': 'edson@gmail.com',
      'url': 'https://robohash.org/1.png',
    },
    {
      'nome': 'Diego',
      'email': 'diego@gmail.com',
      'url': 'https://robohash.org/2.png',
    },
    {
      'nome': 'Gabriel',
      'email': 'gabriel@gmail.com',
      'url': 'https://robohash.org/3.png',
    },
    {
      'nome': 'Thobias',
      'email': 'thobias@gmail.com',
      'url': 'https://robohash.org/4.png',
    },
    {
      'nome': 'Airton',
      'email': 'airton@gmail.com',
      'url': 'https://robohash.org/5.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipo = 0;
                    });
                  },
                  child: Text('ListView'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipo = 1;
                    });
                  },
                  child: Text('ListView.builder'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipo = 2;
                    });
                  },
                  child: Text('ListView.separeted'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    switch (tipo) {
      case 0:
        return buildDefaultList();
      case 1:
        return buildBuilderList();
      case 2:
        return buildSeparetedList();
      default:
        return buildDefaultList();
    }
  }

  Widget buildSeparetedList() {
    return ListView.separated(
      separatorBuilder: (_, index) => FlutterLogo(),
      itemCount: 20,
      itemBuilder: (_, index) {
        print(index);
        return RandomColoredBox();
      },
    );
  }

  Widget buildBuilderList() {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (_, index) {
        print(index);
        return RandomColoredBox();
      },
    );
  }

  Widget buildDefaultList() {
    return ListView(
      children: [
        ListTile(
          title: Text('Edson Martins'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('edson@edson.com'),
              Text('51 9 9999-5555'),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://robohash.org/2.png'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              print('clicou no icon');
            },
          ),
          onTap: () {
            print('clicou em cima');
          },
          onLongPress: () {
            print('segurou em cima');
          },
          selected: false,
          enabled: true,
          isThreeLine: false,
          // tileColor: Colors.red,
          // selectedTileColor: Colors.red[200],
        ),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
        // RandomColoredBox(),
      ],
    );
  }
}

class RandomColoredBox extends StatefulWidget {
  @override
  _RandomColoredBoxState createState() => _RandomColoredBoxState();
}

class _RandomColoredBoxState extends State<RandomColoredBox> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ColoredBox(
        color: Colors.primaries
            .elementAt(Random.secure().nextInt(Colors.primaries.length)),
        child: Container(
          height: 60,
          child: Text('Random color'),
        ),
      ),
    );
  }
}
