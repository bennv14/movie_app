import 'package:movie_app/features/movies_info/data/repository/firebase_auth_repository.dart';
import 'package:movie_app/features/movies_info/presentation/controller/auth_strategy/auth_strategy.dart';
import 'package:movie_app/injection_container.dart';

class GoogleAuthentication implements AuthStrategy {
  late final FirebaseAuthRepository _firebaseAuthRepository;

  GoogleAuthentication() {
    _firebaseAuthRepository = getIt.get<FirebaseAuthRepository>();
  }

  @override
  Future login() async {
    return await _firebaseAuthRepository.signInByGoogle();
  }

  @override
  Future logout() async {
    await _firebaseAuthRepository.firebaseSignOut();
    await _firebaseAuthRepository.googleSignOut();
  }

  @override
  Future register() async {
    return await _firebaseAuthRepository.signInByGoogle();
  }
}
