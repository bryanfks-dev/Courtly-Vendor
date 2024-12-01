/// [VerifyPasswordFormDTO] is a class that is used to pass the password to verify.
class VerifyPasswordFormDTO {
  /// [password] is the password want to verify.
  final String password;

  VerifyPasswordFormDTO({required this.password});

  /// [toJson] is a method used to convert the object to a JSON object.
  ///
  /// Returns a [Map<String, String>] object.
  Map<String, String> toJson() {
    return {
      'password': password,
    };
  }
}
