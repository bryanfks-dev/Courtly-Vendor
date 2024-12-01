/// [UserDTO] is a data transfer object class that holds the user data.
class UserDTO {
  final int id;
  final String username;
  final String profilePictureUrl;

  UserDTO({
    required this.id,
    required this.username,
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
      profilePictureUrl: json['profile_picture_url'],
    );
  }
}
