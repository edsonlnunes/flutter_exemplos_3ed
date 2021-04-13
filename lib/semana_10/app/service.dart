import 'package:shared_preferences/shared_preferences.dart';

class Service {
  Future<bool> doLogin({
    required String email,
    required String pass,
  }) async {
    if (email == 'teste@teste.com') {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLogged', true);

    return true;
  }
}
