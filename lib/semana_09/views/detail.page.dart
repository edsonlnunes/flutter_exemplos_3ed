import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exemplos_flutter/semana_09/db/my_database.dart';
import 'package:exemplos_flutter/semana_09/models/user.model.dart';
import 'package:exemplos_flutter/semana_09/repositories/user.repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  final Map<String, String>? user;

  DetailPage({this.user});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final picker = ImagePicker();
  final cepController = TextEditingController();
  final repository = UserRepository(new MyDatabase());
  final user = User.empty();

  File? imageFile;
  bool isLoadingCep = false;

  void changePhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
    }
  }

  void getAddress() async {
    setState(() {
      isLoadingCep = true;
    });
    var cep = cepController.text;
    var response = await Dio().get('https://viacep.com.br/ws/$cep/json/');

    final resultAddress = response.data as Map<String, dynamic>;

    setState(() {
      isLoadingCep = false;
      user.cep = cep;
      user.address =
          '${resultAddress['logradouro']}, ${resultAddress['cep']} - ${resultAddress['bairro']}, ${resultAddress['localidade']} - ${resultAddress['uf']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do usuário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              children: [
                Stack(
                  children: [
                    if (imageFile == null)
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://robohash.org/5.png'),
                        radius: 100,
                      ),
                    if (imageFile != null)
                      CircleAvatar(
                        backgroundImage: FileImage(imageFile!),
                        radius: 100,
                      ),
                    Positioned(
                      bottom: 30,
                      right: 20,
                      child: InkWell(
                        onTap: changePhoto,
                        child: Icon(
                          Icons.photo_camera_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
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
                  onSaved: (value) => user.name = value!,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  onSaved: (value) => user.name = value!,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: cepController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CEP',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextButton(
                        child: isLoadingCep
                            ? CircularProgressIndicator()
                            : Text('Buscar CEP'),
                        onPressed: isLoadingCep
                            ? null
                            : () {
                                if (cepController.text.length < 8) return;

                                getAddress();
                              },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Endereço',
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(user.address ?? ''),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  child: Text('Salvar'),
                  onPressed: () async {
                    await repository.save(user);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
