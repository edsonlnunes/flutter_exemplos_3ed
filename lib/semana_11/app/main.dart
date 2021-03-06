import 'package:exemplos_flutter/semana_11/app/controllers/auth.controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'models/user.model.dart';
import 'models/user_auth.model.dart';
import 'views/detail.page.dart';
import 'views/list.page.dart';
import 'views/login.page.dart';

class MyAppSemana11 extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyAppSemana11() {
    GetIt.I.registerSingleton(AuthController());
  }

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

        final controller = GetIt.I.get<AuthController>();

        return ValueListenableBuilder<UserAuth?>(
          valueListenable: controller.user,
          builder: (_, userLogged, __) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.teal,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              // home: LoginPage(),
              initialRoute: '/',
              routes: {
                '/': (_) {
                  if (controller.isLogged()) return ListPage();

                  return LoginPage();
                },
                '/detail-page': (ctx) {
                  final param = ModalRoute.of(ctx)?.settings.arguments;
                  User? user = param == null ? null : param as User;

                  return DetailPage(user: user);
                },
              },
            );
          },
        );
      },
    );
  }
}
