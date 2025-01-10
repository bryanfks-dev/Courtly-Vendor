import 'dart:async';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/login_form_dto.dart';
import 'package:courtly_vendor/data/dto/login_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/login_repository.dart';
import 'package:courtly_vendor/data/repository/local/token_repository.dart';
import 'package:dartz/dartz.dart';

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
    // Make a POST request to the API.
    final Either<Failure, LoginResponseDTO> res =
        await loginRepository.postLogin(formDto: formDto);

    // Check if the request is not success
    return res.fold((l) => l, (r) async {
      // Set the token to the storage.
      await tokenRepository.setToken(r.token);

      return null;
    });
  }
}
