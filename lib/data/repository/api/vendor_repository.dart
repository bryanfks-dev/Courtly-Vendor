import 'dart:async';
import 'dart:convert';

import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_response_dto.dart';
import 'package:courtly_vendor/data/repository/api/api_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:http/http.dart' as http;

/// [VendorRepository] is a class to handle vendor requests.
class VendorRepository {
  /// [_tokenRepository] is the token repository.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [getVendor] is a function to make a POST request to the API.
  ///
  /// Returns a [VendorResponseDTO] object.
  Future<ResponseDTO<VendorResponseDTO>> getVendor() async {
    // Set the token from the storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Make a POST request to the API.
    http.Response res = await _apiRepository
        .get(endpoint: 'vendors/me')
        .timeout(const Duration(seconds: 2));

    // Parse the response
    ResponseDTO<VendorResponseDTO> responseDto =
        ResponseDTO.fromJson(jsonDecode(res.body), VendorResponseDTO.fromJson);

    return responseDto;
  }
}
