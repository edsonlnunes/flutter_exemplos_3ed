import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

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
                    onPressed: loginController.doLoginGoogle,
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: loginController.isLoading,
                  builder: (_, isLoading, __) {
                    return AnimatedContainer(
                      height: isLoading ? 150 : 65,
                      duration: Duration(milliseconds: 500),
                      child: isLoading
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    'Autenticando...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                )
                              ],
                            )
                          : null,
                    );
                  },
                ),
                Container(
                  height: 50,
                  child: SignInButton(
                    Buttons.FacebookNew,
                    onPressed: loginController.doLoginFacebook,
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
