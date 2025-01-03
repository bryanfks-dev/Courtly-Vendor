import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/booking_dto.dart';
import 'package:courtly_vendor/data/dto/court_bookings_response_dto.dart';
import 'package:courtly_vendor/data/dto/court_dto.dart';
import 'package:courtly_vendor/data/dto/courts_response_dto.dart';
import 'package:courtly_vendor/data/dto/add_new_court_form_dto.dart';
import 'package:courtly_vendor/data/dto/courts_stats_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/update_court_form_dto.dart';
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

  Future<Either<Failure, CourtsStatsResponseDTO>> getCourtsStats() async {
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    final Either<Failure, http.Response> either = await _apiRepository.get(
        endpoint: "vendors/me/courts/stats", timeoutInSec: 2);

    if (either.isLeft()) {
      return Left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    final http.Response res = either.getOrElse(() => throw 'No response');

    final ResponseDTO<CourtsStatsResponseDTO> responseDto =
        ResponseDTO.fromJson(
            json: jsonDecode(res.body),
            fromJsonT: CourtsStatsResponseDTO.fromJson);

    if (responseDto.success) {
      return Right(responseDto.data!);
    }

    if (res.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message));
    }

    return Left(UnknownFailure(responseDto.message));
  }

  /// [getCourts] is the method that will be used to get the courts.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns [Future] of [Either] [Failure] or [List] of [CourtDTO].
  Future<Either<Failure, List<CourtDTO>>> getCourts(
      {required String courtType}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Call the API to get the courts
    final Either<Failure, http.Response> either = await _apiRepository.get(
        endpoint: "vendors/me/courts/$courtType", timeoutInSec: 2);

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
      return Right(responseDto.data!.courts);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message));
    }

    if (res.statusCode == HttpStatus.badRequest) {
      return Left(RequestFailure(responseDto.message));
    }

    return Left(UnknownFailure(responseDto.message));
  }

  /// [getCourtBookings] is the method that will be used to get the court bookings.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///   - [date] is the date of the bookings.
  ///
  /// Returns [Future] of [Either] [Failure] or [List] of [BookingDTO].
  Future<Either<Failure, List<BookingDTO>>> getCourtBookings(
      {required String courtType, required String date}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    /// [queryParameters] is the query parameters.
    final Map<String, String> queryParameters = {
      'date': date,
    };

    // Call the API to get the court bookings
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "vendors/me/courts/$courtType/bookings",
        queryParam: queryParameters,
        timeoutInSec: 3);

    // Check for failure
    if (res.isLeft()) {
      return Left(
          res.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw 'No response');

    // Parse the response
    final ResponseDTO<CourtBookingsResponseDTO> responseDto =
        ResponseDTO.fromJson(
            json: jsonDecode(response.body),
            fromJsonT: CourtBookingsResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return Right(responseDto.data!.courtBookings);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message));
    }

    if (response.statusCode == HttpStatus.badRequest) {
      return Left(RequestFailure(responseDto.message));
    }

    return Left(UnknownFailure(responseDto.message));
  }

  /// [putCourt] is a method that will be used to update the court.
  ///
  /// Paramters:
  ///   - [courtType] is the type of the court.
  ///   - [formDto] is the form data to update the court.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> putCourt(
      {required String courtType, required UpdateCourtFormDTO formDto}) async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Call the API to update the court
    final Either<Failure, http.Response> res = await _apiRepository.put(
        endpoint: "vendors/me/courts/$courtType",
        body: formDto.toJson(),
        timeoutInSec: 3);

    // Check for failure
    if (res.isLeft()) {
      return res.fold((l) => l, (r) => const UnknownFailure('Unknown error'));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw 'No response');

    // Parse the response
    final ResponseDTO responseDto =
        ResponseDTO.fromJson(json: jsonDecode(response.body));

    // Check if the response is successful
    if (responseDto.success) {
      return null;
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDto.message);
    }

    if (response.statusCode == HttpStatus.badRequest) {
      return RequestFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }
}
