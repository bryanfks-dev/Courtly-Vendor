import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/change_password_form_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
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
  ///   -  formDto] is the form data.
  ///
  /// Returns [Either] a [Failure] or [VendorDTO] object.
  Future<Either<Failure, VendorDTO>> patchPassword(
      {required ChangePasswordFormDTO formDto}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    try {
      // Call the API to change the password
      final http.Response res = await _apiRepository
          .patch(endpoint: "vendors/me/password", body: formDto.toJson())
          .timeout(const Duration(seconds: 5));

      // Parse the response
      final ResponseDTO<VendorResponseDTO> responseDto = ResponseDTO.fromJson(
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
