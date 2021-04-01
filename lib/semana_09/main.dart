import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.model.dart';
import 'views/detail.page.dart';
import 'views/list.page.dart';
import 'views/login.page.dart';

class MyAppSegunda09 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          print(snapshot.error);
          print(snapshot.data);
          final prefs = snapshot.data!;

          final isLogged =
              prefs.getBool('isLogged') != null && prefs.getBool('isLogged')!;

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // home: LoginPage(),
            initialRoute: !isLogged ? '/' : '/list-page',
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
