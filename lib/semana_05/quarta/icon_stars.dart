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
  var _starts = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildIcons(),
          ),
          SizedBox(
            height: 20,
          ),
          _starts > 0
              ? Text(
                  'Você tem $_starts estrelas',
                  style: TextStyle(fontSize: 20),
                )
              : Text(
                  'Você não tem nenhuma estrela',
                  style: TextStyle(fontSize: 20),
                ),
          SizedBox(
            height: 20,
          ),
          buildReaction(),
        ],
      ),
    );
  }

  Widget buildReaction() {
    switch (_starts) {
      case 1:
        return FaIcon(FontAwesomeIcons.angry);
      case 2:
        return FaIcon(FontAwesomeIcons.frown);
      case 3:
        return FaIcon(FontAwesomeIcons.meh);
      case 4:
        return FaIcon(FontAwesomeIcons.smile);
      case 5:
        return FaIcon(FontAwesomeIcons.grinHearts);
      default:
        return FaIcon(FontAwesomeIcons.questionCircle);
    }
  }

  List<Widget> buildIcons() {
    var widgets = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      var preenchida = _starts >= i;
      widgets.add(InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          setState(() {
            // _starts = i == 1 && preenchida ? 0 : i;
            _starts = preenchida ? i - 1 : i;
          });
        },
        onDoubleTap: () {
          setState(() {
            _starts = 0;
          });
        },
        child: Icon(
          preenchida ? Icons.star : Icons.star_border,
          color: preenchida ? Colors.amber : Colors.black,
          size: 40,
        ),
      ));
    }
    return widgets;
  }
}
