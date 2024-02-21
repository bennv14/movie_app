import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/account.dart';

class FirebaseAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<DataState<User>> signUpWithEmailPassword(Account account) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );
    if (user.user != null) {
      return DataSuccess(user.user!);
    } else {
      return DataFailed(Exception());
    }
  }

  bool get isGoogleSignIn => _googleSignIn.currentUser != null;

  Future<DataState<User>> signInByEmailPassword(Account account) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );
    if (user.user != null) {
      return DataSuccess(user.user!);
    } else {
      return DataFailed(Exception());
    }
  }

  Future<DataState<User>> signInByGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Google sign cancelled");
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        return DataSuccess(user);
      } else {
        return DataFailed(Exception());
      }
    } on PlatformException catch (e) {
      log(e.toString());
      return DataFailed(e);
    }
  }

  Future<void> firebaseSignOut() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  Future<void> googleSignOut() async {
    if (await _googleSignIn.isSignedIn() == true) {
      await _googleSignIn.signOut();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.disconnect();
    } on FirebaseAuth {
      rethrow;
    }
  }
}
