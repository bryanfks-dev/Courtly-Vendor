/// [LoginDTO] is a class that holds the data that is needed to login a vendor.
///
/// [LoginDTO] takes [phoneNumber] and [password] as required data, [phoneNumber]
class LoginDTO {
  /// [phoneNumber] is the phone number of the vendor.
  final String phoneNumber;

  /// [password] is the password of the vendor.
  final String password;

  LoginDTO({
    required this.phoneNumber,
    required this.password,
  });

  /// [toMap] is a method to convert the [LoginDTO] to a map.
  ///
  /// Returns a map of [String] key and [String] value.
  Map<String, String> toMap() {
    return {
      "phone_number": phoneNumber,
      "password": password,
    };
  }
}
