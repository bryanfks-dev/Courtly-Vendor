/// [LoginFormDTO] is a class that holds the form data that is needed to login a vendor.
///
/// [LoginFormDTO] takes [email] and [password] as required data
class LoginFormDTO {
  /// [email] is the phone number of the vendor.
  String email;

  /// [password] is the password of the vendor.
  String password;

  LoginFormDTO({
    required this.email,
    required this.password,
  });

  /// [toMap] is a method to convert the [LoginFormDTO] to a map.
  ///
  /// Returns a map of [String] key and [String] value.
  Map<String, String> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}
