class Service {
  bool doLogin({
    required String email,
    required String pass,
  }) {
    if (email == 'teste@teste.com') {
      return false;
    }

    return true;
  }
}
