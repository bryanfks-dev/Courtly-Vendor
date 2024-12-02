import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
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
  /// Returns a [Future] of [Either] a [Failure] or [VendorResponseDTO].
  Future<Either<Failure, VendorResponseDTO>> getVendor() async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Make a POST request to the API.
    final Either<Failure, http.Response> either = await _apiRepository
        .get(endpoint: 'vendors/me', timeoutInSec: 2);

    // Check for failure
    if (either.isLeft()) {
      return left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response
    final ResponseDTO<VendorResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: VendorResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return right(responseDto.data!);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(responseDto.message));
    }

    return left(UnknownFailure(responseDto.message));
  }
}
