import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final users = <Map<String, String>>[
    {
      'id': '1',
      'nome': 'Edson',
      'email': 'edson@gmail.com',
      'url': 'https://robohash.org/1.png',
    },
    {
      'id': '2',
      'nome': 'Diego',
      'email': 'diego@gmail.com',
      'url': 'https://robohash.org/2.png',
    },
    {
      'id': '3',
      'nome': 'Gabriel',
      'email': 'gabriel@gmail.com',
      'url': 'https://robohash.org/3.png',
    },
    {
      'id': '4',
      'nome': 'Thobias',
      'email': 'thobias@gmail.com',
      'url': 'https://robohash.org/4.png',
    },
    {
      'id': '5',
      'nome': 'Airton',
      'email': 'airton@gmail.com',
      'url': 'https://robohash.org/5.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/detail-page',
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index) {
          final user = users[index];
          return Dismissible(
            key: ValueKey(user['id']),
            background: Container(
              color: Colors.red,
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Excluindo...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.archive,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Arquivando...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            // direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              print('item foi removido');
            },
            confirmDismiss: (direction) async {
              // if (direction == DismissDirection.startToEnd) {
              //   if (user['id'] == '2') return true;
              // }

              // if (direction == DismissDirection.endToStart) {
              //   if (user['id'] == '3') return true;
              // }

              return true;
            },
            child: ListTile(
              title: Text(user['nome']!),
              subtitle: Text(user['email']!),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['url']!),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/detail-page',
                    arguments: user,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
