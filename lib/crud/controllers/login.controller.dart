import 'package:exemplos_flutter/crud/models/credentials.model.dart';
import 'package:flutter/widgets.dart';

class LoginController {
  ValueNotifier<bool> showPass = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void toggleShowPass() => showPass.value = !showPass.value;
  void toggleLoading() => isLoading.value = !isLoading.value;

  bool doLogin(CredentialsModel credentials) {
    if (credentials.email == 'teste@teste.com') {
      return false;
    }

    return true;
  }
}
