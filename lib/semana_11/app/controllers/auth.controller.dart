import 'package:flutter/cupertino.dart';
import '../models/user_auth.model.dart';

class AuthController {
  ValueNotifier<UserAuth?> _userLogged = ValueNotifier(null);

  ValueNotifier<UserAuth?> get user => _userLogged;

  set userLogged(UserAuth user) {
    if (_userLogged.value == null) _userLogged.value = user;
  }
}
