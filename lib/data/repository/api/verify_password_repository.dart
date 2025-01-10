import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/dto/verify_password_form_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/local/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [VerifyPasswordRepository] is a class that connects the API with the data layer.
class VerifyPasswordRepository {
  /// [TokenRepository] is a class that connects the storage with the data layer.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [ApiRepository] is a class that connects the API with the data layer.
  final ApiRepository _apiRepository = ApiRepository();

  /// [postPassword] is a method used to verify the current password of the user.
  ///
  /// Parameters:
  ///   - [formDto] is the form data.
  ///
  /// Returns a [Future] of [Failure].
  Future<Failure?> postPassword(
      {required VerifyPasswordFormDTO formDto}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Call the API to verify the current password
    final Either<Failure, http.Response> either = await _apiRepository.post(
        endpoint: "auth/vendor/verify-password",
        body: formDto.toJson(),
        timeoutInSec: 2);

    // Check for failure
    if (either.isLeft()) {
      return either.fold(
          (l) => l, (r) => const UnknownFailure('Unknown error'));
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw 'No response');

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

    if (res.statusCode == HttpStatus.unauthorized) {
      return FormFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }
}
