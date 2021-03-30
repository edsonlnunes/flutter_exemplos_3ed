import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'views/detail.page.dart';
import 'views/list.page.dart';
import 'views/login.page.dart';

class MyAppSegunda09 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/': (_) => LoginPage(),
        '/list-page': (_) => ListPage(),
        '/detail-page': (ctx) {
          final user =
              ModalRoute.of(ctx)?.settings.arguments as Map<String, String>?;

          return DetailPage(user: user);
        },
      },
    );
  }
}
