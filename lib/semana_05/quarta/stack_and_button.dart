import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/fundo.jpg',
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
                buildInput(icon: Icons.person, label: 'Username...'),
                SizedBox(
                  height: 20,
                ),
                buildInput(icon: Icons.lock, label: 'Password'),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    height: 50,
                    width: 300,
                    child: RaisedButton(
                      onPressed: isLoading ? null : () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                      color: Colors.cyan,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    height: 50,
                    width: 300,
                    child: OutlineButton(
                      onPressed: () {
                        setState(() => isLoading = true);
                      },
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.cyan,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 70,
                    child: IconButton(
                      icon: Icon(Icons.login),
                      color: Colors.black,
                      onPressed: () {
                        setState(() => isLoading = false);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput({@required String label, @required IconData icon}) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 35,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSquare() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        color: Colors.red,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              width: 150,
              height: 150,
              color: Colors.blue,
            ),
            Container(
              width: 130,
              height: 130,
              color: Colors.green,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.blue,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 130,
                height: 130,
                color: Colors.green,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.orange,
              ),
            ),
            Positioned(
              right: -52,
              child: Text(
                'Um texto qualquer',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 120,
              right: 120,
              child: Icon(
                Icons.android,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
