import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.model.dart';
import 'views/detail.page.dart';
import 'views/list.page.dart';
import 'views/login.page.dart';

class MyAppSemana10 extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao inicializar o Firebase'),
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

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
                final param = ModalRoute.of(ctx)?.settings.arguments;
                User? user = param == null ? null : param as User;

                return DetailPage(user: user);
              },
            },
          );
        });
  }
}
