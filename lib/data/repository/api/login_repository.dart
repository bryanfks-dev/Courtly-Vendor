import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/login_form_dto.dart';
import 'package:courtly_vendor/data/dto/login_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [LoginRepository] is a class to handle login requests.
class LoginRepository {
  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [postLogin] is a function to make a POST request to the API.
  ///
  /// Parameters:
  ///   - [formDto] is the login form data.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [LoginResponseDTO] object.
  Future<Either<Failure, LoginResponseDTO>> postLogin(
      {required LoginFormDTO formDto}) async {
    // Make a POST request to the API.
    final Either<Failure, http.Response> either = await _apiRepository.post(
        endpoint: 'auth/vendor/login', body: formDto.toMap(), timeoutInSec: 2);

    // Check for failure
    if (either.isLeft()) {
      return left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response
    ResponseDTO<LoginResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: LoginResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return right(responseDto.data!);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(responseDto.message));
    }

    if (res.statusCode == HttpStatus.badRequest) {
      return left(FormFailure(responseDto.message));
    }

    return left(UnknownFailure(responseDto.message));
  }
}
