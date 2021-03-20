import 'package:flutter/material.dart';

import 'views/users.view.dart';
import 'views/login.view.dart';
import 'views/detail.view.dart';

class AppMainCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => LoginView(),
        '/users-view': (_) => UsersView(),
        '/detail-view': (ctx) {
          final user =
              ModalRoute.of(ctx)?.settings.arguments as Map<String, String>?;

          return DetailView(user: user);
        },
      },
    );
  }
}
