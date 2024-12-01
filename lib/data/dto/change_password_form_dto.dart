/// [ChangePasswordFormDTO] is a data transfer object class used to pass the data from the UI to the API.
class ChangePasswordFormDTO {
  /// [oldPassword] is the old password.
  final String oldPassword;

  /// [newPassword] is the new password.
  final String newPassword;

  /// [confirmPassword] is the confirm password.
  final String confirmPassword;

  ChangePasswordFormDTO({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  /// [toJson] is a method used to convert the object to a JSON object.
  /// 
  /// Returns a [Map<String, String>] object.
  Map<String, String> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}
