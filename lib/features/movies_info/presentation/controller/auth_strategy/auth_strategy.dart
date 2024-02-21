abstract class AuthStrategy {
  Future login();
  Future logout();
  Future register();
}
