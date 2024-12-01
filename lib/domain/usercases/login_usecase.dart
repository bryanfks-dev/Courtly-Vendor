import 'dart:async';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/login_form_dto.dart';
import 'package:courtly_vendor/data/dto/login_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/login_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';

/// [LoginUsecase] is a class to handle login usecase.
class LoginUsecase {
  /// [loginRepository] is the login repository.
  final LoginRepository loginRepository;

  /// [tokenRepository] is the token repository.
  final TokenRepository tokenRepository;

  LoginUsecase({required this.loginRepository, required this.tokenRepository});

  /// [login] is a function to handle the login usecase.
  ///
  /// Parameters:
  ///  - [formDto] is the login form data.
  ///
  /// Returns a [ResponseDTO] object.
  Future<Failure?> login(LoginFormDTO formDto) async {
    try {
      // Make a POST request to the API.
      ResponseDTO<LoginResponseDTO> res =
          await loginRepository.postLogin(formDto: formDto);

      // Check if the request is successful.
      if (!res.success) {
        return FormFailure(res.message);
      }

      // Set the token to the storage.
      await tokenRepository.setToken(res.data!.token);

      return null;
    } on SocketException catch (_) {
      return const NetworkFailure("Network Failure");
    } on TimeoutException catch (_) {
      return const NetworkFailure("Request Timeout");
    } catch (e) {
      return UnknownFailure(e.toString());
    }
  }
}
