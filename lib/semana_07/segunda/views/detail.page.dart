import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map<String, String>? user;

  DetailPage({this.user});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://robohash.org/1.png'),
                    radius: 100,
                  ),
                  Positioned(
                    bottom: 30,
                    right: 20,
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
