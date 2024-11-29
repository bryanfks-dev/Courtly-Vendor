import 'dart:async';
import 'dart:convert';

import 'package:courtly_vendor/data/dto/login_form_dto.dart';
import 'package:courtly_vendor/data/dto/login_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:http/http.dart' as http;

/// [LoginRepository] is a class to handle login requests.
class LoginRepository {
  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [postLogin] is a function to make a POST request to the API.
  ///
  /// Parameters:
  ///   - [formDto] is the login form data.
  ///
  /// Returns a [ResponseDTO] object.
  Future<ResponseDTO<LoginResponseDTO>> postLogin(LoginFormDTO formDto) async {
    // Make a POST request to the API.
    http.Response res = await _apiRepository
        .post('auth/vendor/login', formDto.toMap())
        .timeout(const Duration(seconds: 2));

    // Parse the response
    ResponseDTO<LoginResponseDTO> responseDto =
        ResponseDTO.fromJson(jsonDecode(res.body), LoginResponseDTO.fromJson);

    return responseDto;
  }
}
