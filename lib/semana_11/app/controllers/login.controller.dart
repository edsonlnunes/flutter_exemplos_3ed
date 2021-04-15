import 'package:exemplos_flutter/semana_11/app/models/user_auth.model.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth.controller.dart';

class LoginController {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void toggleLoading() => isLoading.value = !isLoading.value;

  Future<void> doLoginGoogle() async {
    toggleLoading();

    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final loginResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await setUserLogged(loginResult.user);
    } catch (e) {
      toggleLoading();
    }
  }

  Future<void> doLoginFacebook() async {
    toggleLoading();

    final result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final firebaseResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await setUserLogged(firebaseResult.user);
    }

    toggleLoading();
  }

  Future<void> setUserLogged(User? firebaseUser) async {
    final token = await firebaseUser!.getIdToken();

    final userAuth = UserAuth(
      email: firebaseUser.email!,
      name: firebaseUser.displayName!,
      urlPhoto: firebaseUser.photoURL!,
      token: token,
    );

    final authController = GetIt.I.get<AuthController>();

    authController.userLogged = userAuth;
    toggleLoading();
  }
}
