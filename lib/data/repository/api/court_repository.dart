import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/courts_response_dto.dart';
import 'package:courtly_vendor/data/dto/add_new_court_form_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CourtRepository {
  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the token repository.
  final TokenRepository _tokenRepository = TokenRepository();

  Future<Either<Failure, CourtsResponseDTO>> postNewCourt(
      {required AddNewCourtFormDTO formDto, required String courtType}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Call the API to post a new court
    final Either<Failure, http.Response> either = await _apiRepository.post(
        endpoint: "vendors/me/courts/types/$courtType/new",
        body: formDto.toJson(),
        timeoutInSec: 2);

    // Check for failure
    if (either.isLeft()) {
      return Left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response
    final ResponseDTO<CourtsResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: CourtsResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return Right(responseDto.data!);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message));
    }

    return Left(UnknownFailure(responseDto.message));
  }
}
