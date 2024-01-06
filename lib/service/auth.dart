import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signin
  Future signinAnonymos() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user!;
      return user;
    } catch (e) {
      log(name: "signinAnonymos", e.toString());
      return null;
    }
  }
}
