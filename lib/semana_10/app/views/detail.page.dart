import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.model.dart';
import '../repositories/user.repository.dart';
import '../db/my_database.dart';

class DetailPage extends StatefulWidget {
  final User? user;

  DetailPage({this.user});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final picker = ImagePicker();
  final cepController = TextEditingController();
  final repository = UserRepository(new MyDatabase());
  User? user = User.empty();

  final _formKey = GlobalKey<FormState>();

  bool isLoadingCep = false;
  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      user = widget.user;
      cepController.text = widget.user!.cep!;
    }
  }

  void changePhoto() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => user?.pathImage = pickedFile.path);
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
      user?.cep = cep;
      user?.address =
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
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    if (user?.pathImage == null)
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://robohash.org/5.png'),
                        radius: 100,
                      ),
                    if (user?.pathImage != null)
                      CircleAvatar(
                        backgroundImage: FileImage(File(user!.pathImage!)),
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
                  initialValue: user?.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  onSaved: (value) => user?.name = value!,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: user?.email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  onSaved: (value) => user?.email = value!,
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
                  child: Text(user?.address ?? ''),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  child: Text('Salvar'),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    _formKey.currentState!.save();

                    print(user);

                    user?.id == null
                        ? await repository.save(user!)
                        : await repository.update(user!);

                    Navigator.pop(context, user);
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
