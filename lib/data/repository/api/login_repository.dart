import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
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
  /// Returns [Either] a [Failure] or [String] object.
  Future<Either<Failure, String>> postLogin(
      {required LoginFormDTO formDto}) async {
    try {
      // Make a POST request to the API.
      final http.Response res = await _apiRepository
          .post(endpoint: 'auth/vendor/login', body: formDto.toMap())
          .timeout(const Duration(seconds: 2));

      // Parse the response
      ResponseDTO<LoginResponseDTO> responseDto =
          ResponseDTO.fromJson(jsonDecode(res.body), LoginResponseDTO.fromJson);

      // Check if the response is successful
      if (responseDto.success) {
        return right(responseDto.data!.token);
      }

      // Check for status codes
      if (res.statusCode == HttpStatus.internalServerError) {
        return left(ServerFailure(responseDto.message));
      }

      if (res.statusCode == HttpStatus.badRequest) {
        return left(FormFailure(responseDto.message));
      }

      return left(UnknownFailure(responseDto.message));
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
