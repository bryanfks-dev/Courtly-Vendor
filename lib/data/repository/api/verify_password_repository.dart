import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/dto/verify_password_form_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
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
  /// Returns [Either] a [Failure] or [VendorDTO].
  Future<Either<Failure, VendorDTO>> postPassword(
      {required VerifyPasswordFormDTO formDto}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    try {
      // Call the API to verify the current password
      http.Response res = await _apiRepository
          .post(endpoint: "auth/vendor/verify-password", body: formDto.toJson())
          .timeout(const Duration(seconds: 2));

      // Parse the response
      ResponseDTO<VendorResponseDTO> responseDto = ResponseDTO.fromJson(
          jsonDecode(res.body), VendorResponseDTO.fromJson);

      // Check if the response is successful
      if (responseDto.success) {
        return right(responseDto.data!.vendor);
      }

      // Check for status codes
      if (res.statusCode == HttpStatus.internalServerError) {
        return left(ServerFailure(responseDto.message));
      }

      if (res.statusCode == HttpStatus.badRequest) {
        return left(FormFailure(responseDto.message));
      }

      if (res.statusCode == HttpStatus.unauthorized) {
        return left(FormFailure(responseDto.message));
      }

      return left(UnknownFailure(responseDto.message));
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
