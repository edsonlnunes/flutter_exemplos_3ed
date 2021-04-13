import 'dart:io';

import 'package:exemplos_flutter/semana_11/app/models/user_auth.model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/my_database.dart';
import '../repositories/user.repository.dart';
import '../models/user.model.dart';
import '../controllers/auth.controller.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final repository = UserRepository(MyDatabase());
  Future<List<User>>? actionGetUsers;

  final authController = GetIt.I.get<AuthController>();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    setState(() {
      actionGetUsers = repository.get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuários'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ValueListenableBuilder<UserAuth?>(
              valueListenable: authController.user,
              builder: (_, userLogged, __) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userLogged!.urlPhoto),
                  ),
                  accountName: Text(
                    userLogged.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text(
                    userLogged.email,
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/kame_house.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('isLogged');
                Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(
            '/detail-page',
          );

          if (result != null) {
            _loadUsers();
          }
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: actionGetUsers,
        builder: (_, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Ocorreu um erro ao carregar os usuários'),
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: () async {
              _loadUsers();
            },
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return Dismissible(
                  key: ValueKey(user.id),
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
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      users.removeWhere((u) => u.id == user.id);
                    });
                  },
                  confirmDismiss: (direction) async {
                    return await repository.delete(user);
                  },
                  child: ListTile(
                    title: Text(user.name!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email ?? ''),
                        Text(user.address!),
                      ],
                    ),
                    isThreeLine: true,
                    leading: user.pathImage == null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage('https://robohash.org/1.png'),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(user.pathImage!)),
                          ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.of(context).pushNamed(
                          '/detail-page',
                          arguments: user,
                        );
                        if (result != null) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
