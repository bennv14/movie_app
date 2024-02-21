import 'package:movie_app/features/movies_info/data/models/account.dart';
import 'package:movie_app/features/movies_info/data/repository/firebase_auth_repository.dart';
import 'package:movie_app/features/movies_info/presentation/controller/auth_strategy/auth_strategy.dart';
import 'package:movie_app/injection_container.dart';

class EmailAuthentication implements AuthStrategy {
  final Account account;
  late final FirebaseAuthRepository _firebaseAuthRepository;

  EmailAuthentication(this.account) {
    _firebaseAuthRepository = getIt<FirebaseAuthRepository>();
  }
  @override
  Future login() async {
    return await _firebaseAuthRepository.signInByEmailPassword(account);
  }

  @override
  Future logout() async {
    return await _firebaseAuthRepository.firebaseSignOut();
  }

  @override
  Future register() async {
    return await _firebaseAuthRepository.signUpWithEmailPassword(account);
  }
}
