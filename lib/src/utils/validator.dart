
import 'email_validator.dart';
import 'password_validator.dart';

class Validator {
  String validateEmail(String email) {
    if (EmailValidator.invalidEmail(email)) {
      return "Please enter a valid email.";
    }
    return null;
  }

  String validatePasswords(String password, String confirmPassword) {
    if (password == confirmPassword) {
      if (PasswordValidator.isPasswordTooShort(password, 8)) {
        return "Password must be at least 8 characters";
      } else if (!PasswordValidator.hasAtLeastANumber(password)) {
        return "Password must contain at least one number.";
      } else if (!PasswordValidator.hasAtLeastOneUpperCase(password)) {
        return "Password must contain at least one upper case";
      } else if (!PasswordValidator.hasAtleastOnSpecialChar(password)) {
        return "Password must contain at least one special character.";
      }
      return null;
    } else {
      return "Password and Confirm Password does not match.";
    }
  }
}