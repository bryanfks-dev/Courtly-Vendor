import 'package:email_validator/email_validator.dart';

/// [LoginFormValidator] is a class to validate the login form.
/// It checks if the email and password are valid or not.
class LoginFormValidator {
  /// [validateEmail] is a method to validate the email.
  /// It checks if the email is valid or not.
  ///
  /// Returns a [String] message.
  String? validateEmail(String email) {
    // Check if the email is empty.
    if (email.trim().isEmpty) {
      return "Email cannot be empty";
    }

    // Check if the email is valid.
    if (!EmailValidator.validate(email)) {
      return "Email is invalid";
    }

    return null;
  }

  /// [validatePassword] is a method to validate the password.
  /// It checks if the password is valid or not.
  ///
  /// Returns a [String] message.
  String? validatePassword(String password) {
    // Check if the password is empty.
    if (password.isEmpty) {
      return "Password is required";
    }

    return null;
  }
}
