import 'dart:convert';
import 'dart:io';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:http/http.dart' as http;

class LogoutRepository {
  /// [ApiRepository] is the repository class for the API
  final ApiRepository _apiRepository = ApiRepository();

  /// [postLogout] is a function to make a POST request to the API.
  ///
  ///
  Future<Failure?> postLogout() async {
    try {
      // Make a POST request to the API.
      final http.Response res = await _apiRepository
          .post(endpoint: 'auth/vendor/logout')
          .timeout(const Duration(seconds: 2));

      // Parse the response.
      ResponseDTO responseDto =
          ResponseDTO.fromJson(json: jsonDecode(res.body));

      // Return null if the request is successful.
      if (responseDto.success) {
        return null;
      }

      // Check for status codes.
      if (res.statusCode == HttpStatus.internalServerError) {
        return ServerFailure(responseDto.message);
      }

      return UnknownFailure(responseDto.message);
    } on SocketException catch (_) {
      return const NetworkFailure();
    } on RequestFailure catch (_) {
      return const RequestFailure();
    } on Exception catch (e) {
      return UnknownFailure(e.toString());
    }
  }
}
