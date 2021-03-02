import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Inicial alterac'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.purple[200],
        child: Column(
          children: <Widget>[
            CaixaPreta(),
            CaixaPreta(),
            Container(
              color: Colors.blue[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CaixaPreta(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.yellow[200],
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CaixaPreta(
                          color: Colors.teal,
                        ),
                        CaixaPreta(
                          color: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                  CaixaPreta(
                    color: Colors.red,
                  ),
                  CaixaPreta(
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            CaixaPreta(
              height: 150,
            ),
            CaixaPreta(),
            CaixaPreta(),
          ],
        ),
      ),
    );
  }
}

class CaixaPreta extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const CaixaPreta({Key key, this.width, this.height, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? 60,
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
    );
  }
}
