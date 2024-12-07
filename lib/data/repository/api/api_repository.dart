import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [ApiRepository] is a repository to handle API requests.
/// This class is used to make API requests to the server.
class ApiRepository {
  /// [_baseUrl] is the base URL of the API.
  /// This base URL is used to make the API request.
  static const String _baseUrl = "http://10.39.51.179:3000/api/v1";

  /// [_token] is the JWT token for the API request.
  /// This JWT token is used to authenticate the API request.
  String? _token;

  /// [_headers] is the headers for the API request.
  /// This headers is used to set the headers for the API request.
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// [setTokenFromStorage] is a function to set the JWT token from the storage.
  Future<void> setTokenFromStorage(
      {required TokenRepository tokenRepository}) async {
    // Get the token from the repository
    final String? token = await tokenRepository.getToken();

    // Check if the token is null
    if (token == null) {
      return;
    }

    _token = token;
  }

  /// [get] is a function to make a GET request to the API.
  /// This function will make a GET request to the API with the given endpoint.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [http.Response].
  Future<Either<Failure, http.Response>> get(
      {required String endpoint, required int timeoutInSec}) async {
    try {
      /// Make a GET request to the API.
      final res = await http.get(Uri.parse('$_baseUrl/$endpoint'), headers: {
        ..._headers,
        if (_token != null) 'Authorization': 'Bearer $_token',
      }).timeout(Duration(seconds: timeoutInSec));

      return right(res);
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on HttpException catch (_) {
      return left(const RequestFailure("Cannot reach the server"));
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  /// [post] is a function to make a POST request to the API.
  /// This function will make a POST request to the API with the given endpoint.
  /// The [body] parameter is the data that will be sent to the API.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [http.Response].
  Future<Either<Failure, http.Response>> post(
      {required String endpoint,
      Map<String, dynamic>? body,
      required int timeoutInSec}) async {
    try {
      /// Make a POST request to the API.
      final res = await http
          .post(Uri.parse('$_baseUrl/$endpoint'),
              headers: {
                ..._headers,
                if (_token != null) 'Authorization': 'Bearer $_token',
              },
              body: json.encode(body))
          .timeout(Duration(seconds: timeoutInSec));

      return right(res);
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on HttpException catch (_) {
      return left(const RequestFailure("Cannot reach the server"));
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  /// [patch] is a function to make a PATCH request to the API.
  /// This function will make a PATCH request to the API with the given endpoint.
  /// The [body] parameter is the data that will be sent to the API.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [http.Response].
  Future<Either<Failure, http.Response>> patch(
      {required String endpoint,
      required Map<String, dynamic> body,
      required int timeoutInSec}) async {
    try {
      /// Make a PATCH request to the API.
      final res = await http
          .patch(Uri.parse('$_baseUrl/$endpoint'),
              headers: {
                ..._headers,
                if (_token != null) 'Authorization': 'Bearer $_token',
              },
              body: json.encode(body))
          .timeout(Duration(seconds: timeoutInSec));

      return right(res);
    } on SocketException catch (_) {
      return left(const NetworkFailure());
    } on HttpException catch (_) {
      return left(const RequestFailure("Cannot reach the server"));
    } on TimeoutException catch (_) {
      return left(const RequestFailure());
    } on Exception catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
