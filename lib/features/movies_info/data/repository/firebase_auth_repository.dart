import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/account.dart';

class FirebaseAuthRepository {
  final firebaseAuth = FirebaseAuth.instance;

  Future<DataState<User>> signUpWithEmailPassword(Account account) async {
    final user = await firebaseAuth.createUserWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );
    if (user.user != null) {
      return DataSuccess(user.user!);
    } else {
      return DataFailed(Exception());
    }
  }

  Future<DataState<User>> signInByEmailPassword(Account account) async {
    final user = await firebaseAuth.signInWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );
    if (user.user != null) {
      return DataSuccess(user.user!);
    } else {
      return DataFailed(Exception());
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuth {
      rethrow;
    }
  }
}
