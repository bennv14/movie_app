class WrongPassword implements Exception {
  const WrongPassword();

  @override
  String toString() {
    return "WrongPassword";
  }
}

class UserNotFound implements Exception {
  const UserNotFound();
  @override
  String toString() {
    return "UserNotFound";
  }
}

class EmailAlreadyInUse implements Exception {
  const EmailAlreadyInUse();
  @override
  String toString() {
    return "EmailAlreadyInUse";
  }
}

class WeakPassword implements Exception {
  const WeakPassword();
  @override
  String toString() {
    return "WeakPassword";
  }
}
