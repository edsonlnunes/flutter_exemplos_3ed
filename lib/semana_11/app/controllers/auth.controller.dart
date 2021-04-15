import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_auth.model.dart';

class AuthController {
  ValueNotifier<UserAuth?> _userLogged = ValueNotifier(null);

  ValueNotifier<UserAuth?> get user => _userLogged;

  set userLogged(UserAuth? user) => _userLogged.value = user;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    userLogged = null;
  }

  Future<void> loadUser(User userFirebase) async {
    if (user.value == null) {
      final token = await userFirebase.getIdToken();
      userLogged = UserAuth(
        email: userFirebase.email!,
        name: userFirebase.displayName!,
        urlPhoto: userFirebase.photoURL!,
        token: token,
      );
    }
  }

  bool isLogged() {
    final userLogged = FirebaseAuth.instance.currentUser;

    if (userLogged != null) {
      loadUser(userLogged);
      return true;
    }

    return false;
  }
}
