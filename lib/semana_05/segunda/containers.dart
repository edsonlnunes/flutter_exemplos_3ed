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
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.red,
                width: 5,
              ),
            ),
            child: Text('Growdev'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.green,
                  Colors.teal,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              // image: DecorationImage(
              // ),
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(50),
              // border: Border.all(width: 3, color: Colors.red[200]),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/goku.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/goku.jpg',
            ),
            radius: 50,
          ),
        ],
      ),
    );
  }
}
