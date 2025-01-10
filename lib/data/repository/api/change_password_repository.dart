import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/change_password_form_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/local/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [ChangePasswordRepository] is the repository for changing the password.
class ChangePasswordRepository {
  /// [_tokenRepository] is the repository for the token.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [_apiRepository] is the repository for the API.
  final ApiRepository _apiRepository = ApiRepository();

  /// [patchPassword] is a method used to change the password of the user.
  ///
  /// Parameters:
  ///   -  [formDto] is the form data.
  ///
  /// Returns a [Future] of [Failure].
  Future<Failure?> patchPassword(
      {required ChangePasswordFormDTO formDto}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Call the API to change the password
    final Either<Failure, http.Response> either = await _apiRepository.patch(
        endpoint: "vendors/me/password",
        body: formDto.toJson(),
        timeoutInSec: 5);

    // Check if the response is a failure
    if (either.isLeft()) {
      return either.fold((l) => l, (r) => null);
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw Exception());

    // Parse the response
    final ResponseDTO<VendorResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: VendorResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return null;
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDto.message);
    }

    if (res.statusCode == HttpStatus.badRequest) {
      return FormFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }
}
