class EmailValidator {
  static bool invalidEmail(String email) {
    if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return false;
    }
    return true;
  }
}