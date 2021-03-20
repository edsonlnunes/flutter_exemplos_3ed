import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var isOpen = false;
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
      appBar: AppBar(
        title: Text('Lista de usuários'),
      ),
      // drawerScrimColor: Colors.red,
      drawer: Drawer(
        child: Column(
          children: [
            // DrawerHeader(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Container(
            //         height: 60,
            //         width: 60,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage('assets/goku.jpg'),
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //       ),
            //       Text(
            //         'Edson',
            //         style: Theme.of(context).textTheme.headline4?.copyWith(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //             ),
            //         textAlign: TextAlign.center,
            //       ),
            //       Text(
            //         'edson@gmail.com',
            //         style: Theme.of(context).textTheme.headline5?.copyWith(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //             ),
            //         textAlign: TextAlign.center,
            //       ),
            //     ],
            //   ),
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/kame_house.jpg'),
            //       fit: BoxFit.fitWidth,
            //     ),
            //   ),
            // ),
            UserAccountsDrawerHeader(
              arrowColor: Colors.yellow,
              onDetailsPressed: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/goku.jpg'),
                ),
              ],
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/goku.jpg'),
              ),
              accountName: Text(
                'Edson Martins',
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                'edson@gmail.com',
                style: TextStyle(color: Colors.black),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/kame_house.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: isOpen ? 100 : 0,
              color: Colors.red,
              child: Row(
                children: [
                  Text('Teste'),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/detail-page',
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Perfil'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
