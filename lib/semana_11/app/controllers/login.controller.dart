import 'package:exemplos_flutter/semana_11/app/models/user_auth.model.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth.controller.dart';

class LoginController {
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  Future<bool> doLoginGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final loginResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await setUserLogged(loginResult.user);

    return true;
  }

  Future<bool> doLoginFacebook() async {
    final result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final firebaseResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await setUserLogged(firebaseResult.user);

      return true;
    }

    return false;
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
  }
}
