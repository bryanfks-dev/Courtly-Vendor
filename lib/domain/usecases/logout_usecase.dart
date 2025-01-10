import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/repository/api/logout_repository.dart';
import 'package:courtly_vendor/data/repository/local/token_repository.dart';

/// [LogoutUsecase] is a class to handle the logout usecase.
class LogoutUsecase {
  /// [LogoutRepository] is the repository class for the logout API.
  final LogoutRepository logoutRepository;

  /// [TokenRepository] is the repository class for the token storage.
  final TokenRepository tokenRepository;

  LogoutUsecase(
      {required this.logoutRepository, required this.tokenRepository});

  /// [logout] is a function to make a POST request to the API.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> logout() async {
    // Make a POST request to the API.
    final Failure? failure = await logoutRepository.postLogout();

    // Check if the request is successful.
    if (failure != null) {
      return failure;
    }

    // Clear the token from the storage.
    await tokenRepository.clearToken();

    return null;
  }
}
