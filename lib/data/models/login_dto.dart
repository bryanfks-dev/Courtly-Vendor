/// [LoginDTO] is a class that holds the data that is needed to login a vendor.
///
/// [LoginDTO] takes [email] and [password] as required data
class LoginDTO {
  /// [email] is the phone number of the vendor.
  final String email;

  /// [password] is the password of the vendor.
  final String password;

  LoginDTO({
    required this.email,
    required this.password,
  });

  /// [toMap] is a method to convert the [LoginDTO] to a map.
  ///
  /// Returns a map of [String] key and [String] value.
  Map<String, String> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}
