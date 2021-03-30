import 'package:exemplos_flutter/semana_09/db/my_database.dart';
import 'package:exemplos_flutter/semana_09/models/user.model.dart';

class UserRepository {
  MyDatabase _myDB;

  UserRepository(this._myDB);

  Future<bool> save(User user) async {
    try {
      final instance = await _myDB.getInstance();

      final id = await instance.insert('users', user.toMap());
      print('user id: $id');

      return id > 0;
    } catch (e) {
      print(e);
      throw 'Erro ao inserir o usuário';
    }
  }
}
