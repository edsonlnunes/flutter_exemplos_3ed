import 'package:exemplos_flutter/semana_11/app/controllers/auth.controller.dart';
import 'package:exemplos_flutter/semana_11/app/models/user_auth.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import '../controllers/login.controller.dart';

enum ETipoRetorno { SIM, NAO }

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = LoginController();
  void showFailureLogin() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Ops, algo deu errado!'),
          contentPadding: EdgeInsets.all(20),
          children: [
            Text('Usuário ou senha inválidos, Tente novamente'),
          ],
        );
      },
    );
  }

  Future<void> doLogin(Future<bool> Function() onLogin) async {
    final isLogged = await onLogin();

    if (!isLogged) return;

    Navigator.of(context).pushReplacementNamed('/list-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/kame_house.jpg',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            color: Colors.black38,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  child: SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () => doLogin(loginController.doLoginGoogle),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: SignInButton(
                    Buttons.FacebookNew,
                    onPressed: () => doLogin(loginController.doLoginFacebook),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
