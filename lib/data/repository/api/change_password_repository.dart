import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/change_password_form_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
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
  /// Returns a [Failure] object.
  Future<Failure?> patchPassword(
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
    } on SocketException catch (_) {
      return const NetworkFailure();
    } on TimeoutException catch (_) {
      return const RequestFailure();
    } on Exception catch (e) {
      return UnknownFailure(e.toString());
    }
  }
}
