import 'package:exemplos_flutter/crud/models/credentials.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import '../controllers/login.controller.dart';

enum ETipoRetorno { SIM, NAO }

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();
  late AnimationController animButtonControler;

  late Animation<double> buttonWidthAnim;
  late Animation<double> buttonOpacityAnim;
  late Animation<Color?> colorAnim;

  final _controller = LoginController();

  String? email;
  String? pass;

  @override
  void initState() {
    super.initState();
    _controller.isLoading.addListener(() {
      print(_controller.isLoading.value);
      _controller.isLoading.value
          ? animButtonControler.forward()
          : animButtonControler.reverse();
    });

    animButtonControler = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    buttonWidthAnim = Tween<double>(
      begin: 400,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: animButtonControler,
        curve: Interval(0, 1),
      ),
    );

    buttonOpacityAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animButtonControler,
        curve: Interval(.8, 1),
      ),
    );

    colorAnim = ColorTween(
      begin: Colors.red,
      end: Colors.orange,
    ).animate(
      CurvedAnimation(
        parent: animButtonControler,
        curve: Interval(0, 1),
      ),
    );
  }

  void doLogin() async {
    if (!formKey.currentState!.validate()) return;
    _controller.toggleLoading();

    formKey.currentState?.save();

    await Future.delayed(Duration(seconds: 5));

    final isLogged = _controller.doLogin(
      CredentialsModel(
        email: email!,
        pass: pass!,
      ),
    );

    _controller.toggleLoading();

    if (!isLogged) {
      // showFailureLogin();
      return;
    }

    Navigator.of(context).pushReplacementNamed('/list-page');
  }

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
                fit: BoxFit.cover,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildInput(
                    initialValue: 'teste@teste.com',
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
                  buildButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return AnimatedBuilder(
      animation: animButtonControler,
      builder: (_, __) {
        return InkWell(
          onTap: _controller.isLoading.value ? () {} : () => doLogin(),
          child: Container(
            width: buttonWidthAnim.value,
            height: 50,
            decoration: BoxDecoration(
              color: colorAnim.value,
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.center,
            child: _controller.isLoading.value
                ? Opacity(
                    opacity: buttonOpacityAnim.value,
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    ),
                  )
                : Opacity(
                    opacity: 1 - buttonOpacityAnim.value,
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        );
      },
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
    return ValueListenableBuilder<bool>(
        valueListenable: _controller.showPass,
        builder: (_, showPass, __) {
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
                      onPressed: _controller.toggleShowPass,
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
        });
  }
}
