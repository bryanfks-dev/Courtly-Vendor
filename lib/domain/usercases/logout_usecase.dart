import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/repository/api/logout_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';

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

    return failure;
  }

  /// [clearToken] is a function to clear the token.
  ///
  /// Returns [Future] of [void].
  Future<void> clearToken() async {
    // Clear the token.
    await tokenRepository.clearToken();
  }
}
