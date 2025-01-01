import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/orders_response_dto.dart';
import 'package:courtly_vendor/data/dto/orders_stats_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [OrderRepository] is a class that provides methods to interact with the order API.
class OrderRepository {
  /// [_apiRepository] is an instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is an instance of [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getOrders] is a method that fetches the list of orders.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [OrdersResponseDTO].
  Future<Either<Failure, OrdersResponseDTO>> getOrders(
      {String? courtType}) async {
    // Set the token from storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Set the query parameters.
    final Map<String, String> queryParameters = {};

    if (courtType != null && courtType.isNotEmpty) {
      queryParameters['type'] = courtType;
    }

    // Get the orders from the API.
    final Either<Failure, http.Response> either = await _apiRepository.get(
        endpoint: 'vendors/me/orders',
        queryParam: queryParameters,
        timeoutInSec: 10);

    // Check for failure.
    if (either.isLeft()) {
      return Left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response.
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response.
    final ResponseDTO<OrdersResponseDTO> responseDto = ResponseDTO.fromJson(
      json: jsonDecode(res.body),
      fromJsonT: OrdersResponseDTO.fromJson,
    );

    // Check if the request was successful.
    if (responseDto.success) {
      return Right(responseDto.data!);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message.toString()));
    }

    return Left(UnknownFailure(responseDto.message.toString()));
  }

  /// [getOrdersStats] is a method that fetches the statistics of orders.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [OrdersStatsResponseDTO].
  Future<Either<Failure, OrdersStatsResponseDTO>> getOrdersStats() async {
    // Set the token from storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Get the orders stats from the API.
    final Either<Failure, http.Response> either = await _apiRepository.get(
        endpoint: 'vendors/me/orders/stats', timeoutInSec: 2);

    // Check for failure.
    if (either.isLeft()) {
      return Left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response.
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response.
    final ResponseDTO<OrdersStatsResponseDTO> responseDto =
        ResponseDTO.fromJson(
      json: jsonDecode(res.body),
      fromJsonT: OrdersStatsResponseDTO.fromJson,
    );

    // Check if the request was successful.
    if (responseDto.success) {
      return Right(responseDto.data!);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message.toString()));
    }

    return Left(UnknownFailure(responseDto.message.toString()));
  }
}
