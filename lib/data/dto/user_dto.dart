/// [UserDTO] is a data transfer object class that holds the user data.
class UserDTO {
  /// [id] is the ID of the user.
  final int id;

  /// [username] is the username of the user.
  final String username;

  /// [phoneNumber] is the phone number of the user.
  final String? phoneNumber;

  /// [profilePictureUrl] is the URL of the user's profile picture.
  final String? profilePictureUrl;

  UserDTO({
    required this.id,
    required this.username,
    this.phoneNumber,
    required this.profilePictureUrl,
  });

  /// [fromJson] is a factory method to create a [UserDTO] from a map.
  ///
  /// Parameters:
  ///   - [json] is a map that contains the user data.
  ///
  /// Returns a [UserDTO] object.
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }
}
