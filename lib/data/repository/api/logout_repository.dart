import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/local/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LogoutRepository {
  /// [ApiRepository] is the repository class for the API
  final ApiRepository _apiRepository = ApiRepository();

  /// [TokenRepository] is the repository class for the token storage.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [postLogout] is a function to make a POST request to the API.
  ///
  /// Returns a [Future] of [Failure].
  Future<Failure?> postLogout() async {
    // Set the token from the storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Make a POST request to the API.
    final Either<Failure, http.Response> either = await _apiRepository
        .post(endpoint: 'auth/vendor/logout', timeoutInSec: 2);

    // Check if the response is a failure.
    if (either.isLeft()) {
      return either.fold((l) => l, (r) => null);
    }

    // Get the response.
    final http.Response res = either.getOrElse(() => throw "No Response");

    // Parse the response.
    ResponseDTO responseDto = ResponseDTO.fromJson(json: jsonDecode(res.body));

    // Return null if the request is successful.
    if (responseDto.success) {
      return null;
    }

    // Check for status codes.
    if (res.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }
}
