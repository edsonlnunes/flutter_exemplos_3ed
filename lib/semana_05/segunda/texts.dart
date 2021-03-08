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
        primarySwatch: Colors.red,
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
  LongPressGestureRecognizer? gestureRecognizer;

  @override
  void initState() {
    gestureRecognizer = LongPressGestureRecognizer()
      ..onLongPress = () {
        print('clicou');
      };
    super.initState();
  }

  @override
  void dispose() {
    gestureRecognizer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Inicial alterac'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: TextStyle(fontSize: 17),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(
            color: Colors.red,
            height: 20,
            thickness: 2,
          ),
          Text.rich(
            TextSpan(
              text: 'Começando com um texto padrão, ',
              children: [
                TextSpan(
                  text: 'este texto é itálico, ',
                  children: [
                    TextSpan(
                      text: 'e este é itálico e negrito, ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: 'este texto é negrito, ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: 'este texto é sublinhado e clicavel,',
                  recognizer: gestureRecognizer,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              print('clicou aqui');
            },
            child: Center(
              child: Text(
                'Cliquei aqui',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(
                Icons.star,
                color: Colors.red,
                size: 50,
              ),
              Icon(Icons.star_border),
              Icon(Icons.star_border),
              FaIcon(
                FontAwesomeIcons.airbnb,
                size: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
