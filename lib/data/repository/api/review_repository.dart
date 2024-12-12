import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/reviews_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [ReviewRepository] is a class that contains the business logic for the Review entity.
class ReviewRepository {
  /// [_apiRepository] is an instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is an instance of [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getReviews] is a method that fetches reviews from the API.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [ReviewsResponseDTO]
  Future<Either<Failure, ReviewsResponseDTO>> getReviews({int? rating}) async {
    // Set the token from storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Set the query param
    final String queryParam = rating != null ? "?type=$rating" : "";

    // Make a GET request to the API.
    final Either<Failure, http.Response> either = await _apiRepository.get(
        endpoint: 'vendors/me/reviews$queryParam', timeoutInSec: 2);

    // Check for failure
    if (either.isLeft()) {
      return left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response
    final ResponseDTO<ReviewsResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: ReviewsResponseDTO.fromJson);

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
