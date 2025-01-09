import 'package:courtly_vendor/core/config/api_server_config.dart';
import 'package:courtly_vendor/data/dto/user_dto.dart';

/// [User] is an entity class that represents a user.
class User {
  /// [id] is the unique identifier of the user.
  final int id;

  /// [username] is the username of the user.
  final String username;

  /// [phoneNumber] is the phone number of the user.
  final String phoneNumber;

  /// [profilePictureUrl] is the URL of the user's profile picture.
  final String profilePictureUrl;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.profilePictureUrl,
  });

  /// [fromDTO] is a factory method to create a [User] from a dto.
  ///
  /// Parameters:
  ///   - [dto] is the user dto object.
  ///
  /// Returns a [User] object.
  factory User.fromDTO(UserDTO dto) {
    return User(
        id: dto.id,
        username: dto.username,
        phoneNumber: dto.phoneNumber,
        profilePictureUrl: (dto.profilePictureUrl != null)
            ? "${ApiServerConfig.baseUrl}/${dto.profilePictureUrl}"
            : "");
  }
}
