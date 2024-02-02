import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/models/account.dart';
import 'package:movie_app/features/movies_info/data/repository/firebase_auth_repository.dart';

class RegisterUsecase extends UseCase<DataState<User>, Account> {
  final FirebaseAuthRepository _firebaseAuth;

  RegisterUsecase(this._firebaseAuth);
  @override
  Future<DataState<User>> call({params = const Account(email: '', password: '')}) async {
    return await _firebaseAuth.signUpWithEmailPassword(params);
  }
}
