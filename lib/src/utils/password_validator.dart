class PasswordValidator {
  static bool isPasswordTooShort(String pass, int minLength) {
    if (pass.length < minLength) {
      return true;
    }
    return false;
  }

  static bool hasAtleastOnSpecialChar(String pass) {
    if (RegExp(r".*[!@#$&*]").hasMatch(pass)) {
      return true;
    }
    return false;
  }

  static bool hasAtLeastANumber(String pass) {
    if (RegExp(r".*[0-9]").hasMatch(pass)) {
      return true;
    }
    return false;
  }

  static bool hasAtLeastOneUpperCase(String pass) {
    if (RegExp(r".*[A-Z]").hasMatch(pass)) {
      return true;
    }
    return false;
  }
}
