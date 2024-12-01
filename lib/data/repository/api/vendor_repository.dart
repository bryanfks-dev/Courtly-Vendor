import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [VendorRepository] is a class to handle vendor requests.
class VendorRepository {
  /// [_tokenRepository] is the token repository.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [getVendor] is a function to make a POST request to the API.
  ///
  /// Returns [Either] a [Failure] or [VendorDTO] object.
  Future<Either<Failure, VendorDTO>> getVendor() async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    try {
      // Make a POST request to the API.
      final http.Response res = await _apiRepository
          .get(endpoint: 'vendors/me')
          .timeout(const Duration(seconds: 2));

      // Parse the response
      final ResponseDTO<VendorResponseDTO> responseDto = ResponseDTO.fromJson(
          json: jsonDecode(res.body), fromJsonT: VendorResponseDTO.fromJson);

      // Check if the response is successful
      if (responseDto.success) {
        return right(responseDto.data!.vendor);
      }

      // Check for status codes
      if (res.statusCode == HttpStatus.internalServerError) {
        return left(ServerFailure(responseDto.message));
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
