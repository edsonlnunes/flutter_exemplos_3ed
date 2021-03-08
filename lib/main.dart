import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;
  var showPass = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  void doLogin(_) {
    if (!EmailValidator.validate(emailController.text)) {
      showSnackBar('E-mail inválido', _);
      return;
    }

    if (passController.text.isEmpty) {
      showSnackBar('Senha inválida', _);
      return;
    }

    // proxima call
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

    // scaffoldKey.currentState?.showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       text,
    //       style: TextStyle(
    //         fontSize: 17,
    //       ),
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.red,
    //   ),
    // );

    // Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       text,
    //       style: TextStyle(
    //         fontSize: 17,
    //       ),
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.red,
    //   ),
    // );
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: buildInput(
                        icon: Icons.person,
                        label: 'E-mail',
                        controller: emailController,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: buildInput(
                        icon: Icons.person,
                        label: 'E-mail',
                        controller: emailController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                buildInput(
                  icon: Icons.lock,
                  label: 'Password',
                  controller: passController,
                  obscureText: true,
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
        ],
      ),
    );
  }

  Widget buildInput({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText && !showPass,
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
        // fillColor: Colors.black,
        // filled: true,
        counterStyle: TextStyle(
          color: Colors.white,
        ),
        // icon: Icon(
        //   Icons.person,
        // ),
        // prefixIcon: Icon(
        //   Icons.person,
        // ),
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
      // maxLength: 10,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      cursorWidth: 4,
      cursorRadius: Radius.circular(10),
      keyboardType: TextInputType.number,
      // buildCounter: (
      //   _, {
      //   required int currentLength,
      //   required int? maxLength,
      //   required bool isFocused,
      // }) {
      //   if (isFocused) {
      //     return Row(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         Text(
      //           '$currentLength/$maxLength',
      //           style: TextStyle(
      //             color: Colors.white,
      //           ),
      //         ),
      //         SizedBox(
      //           width: 5,
      //         ),
      //         Icon(
      //           Icons.smoking_rooms,
      //           color: Colors.white,
      //         )
      //       ],
      //     );
      //   }
      //   return null;
      // },
      inputFormatters: [
        // TextInputFormatter.withFunction((oldValue, newValue) => null)
        // FilteringTextInputFormatter.deny(RegExp('[4-6]')),
        // TextInputFormatter.withFunction(
        //   (oldValue, newValue) => TextEditingValue(
        //     text: newValue.text.toUpperCase(),
        //     composing: newValue.composing,
        //     selection: newValue.selection,
        //   ),
        // ),
        // CnpjCpfFormatter(
        //   eDocumentType: EDocumentType.BOTH,
        // )
      ],
    );
    //   return Container(
    //     width: double.infinity,
    //     height: 60,
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(50),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black,
    //           blurRadius: 5,
    //           spreadRadius: 2,
    //         ),
    //       ],
    //     ),
    //     child: Row(
    //       children: [
    //         Icon(
    //           icon,
    //           color: Colors.black,
    //           size: 35,
    //         ),
    //         SizedBox(
    //           width: 15,
    //         ),
    //         Text(
    //           label,
    //           style: TextStyle(
    //             fontSize: 20,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
