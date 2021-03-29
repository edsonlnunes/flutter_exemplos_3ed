import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

import 'service.dart';
import 'views/detail.page.dart';
import 'views/list.page.dart';

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

enum ETipoRetorno { SIM, NAO }

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoading = false;
  var showPass = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  // final emailController = TextEditingController();
  // final passController = TextEditingController();
  String? email;
  String? pass;

  void doLogin(ctx) {
    // if (!Form.of(ctx)!.validate()) return;
    if (!formKey.currentState!.validate()) return;

    formKey.currentState?.save();

    final isLogged = Service().doLogin(email: email!, pass: pass!);

    if (!isLogged) {
      showFailureLogin();
      return;
    }

    Navigator.of(context).pushReplacementNamed('/list-page');
  }

  void showFailureLogin() async {
    // ##### ALERT DIALOG #####
    // final result = await showDialog<ETipoRetorno>(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (ctx) {
    //     return AlertDialog(
    //       title: Text('Ops, algo deu errado!'),
    //       content: Text('Usuário  ou senha inválidos, tente novamente'),
    //       actions: [
    //         TextButton(
    //           child: Text('Sim'),
    //           onPressed: () {
    //             Navigator.of(context).pop(ETipoRetorno.SIM);
    //           },
    //         ),
    //         TextButton(
    //           child: Text('Não'),
    //           onPressed: () {
    //             Navigator.pop(context, ETipoRetorno.NAO);
    //             // Navigator.of(context).pop();
    //           },
    //         )
    //       ],
    //     );
    //   },
    // );

    // print(result);

    // ##### SIMPLE MODAL #####
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

  void showSnackBar(String text, _) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildInput(
                    initialValue: 'edson@gmail.com',
                    icon: Icons.person,
                    label: 'E-mail',
                    validator: (value) {
                      if (!EmailValidator.validate(value!)) {
                        return 'E-mail inválido';
                      }

                      return null;
                    },
                    onSaved: (value) => email = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildInput(
                    initialValue: 'edson@gmail.com',
                    icon: Icons.lock,
                    label: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Senha inválida';
                      }

                      return null;
                    },
                    onSaved: (value) => pass = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Container(
                      height: 50,
                      width: 300,
                      child: Builder(builder: (ctx) {
                        return ElevatedButton(
                          onPressed: isLoading ? null : () => doLogin(ctx),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            primary: Colors.red,
                          ),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput({
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    String? initialValue,
    TextEditingController? controller,
    bool obscureText = false,
  }) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText && !showPass,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        counterStyle: TextStyle(
          color: Colors.white,
        ),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  showPass ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
              )
            : null,
      ),
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      cursorWidth: 4,
      cursorRadius: Radius.circular(10),
      keyboardType: TextInputType.text,
    );
  }
}
