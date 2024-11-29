import 'dart:convert';

import 'package:http/http.dart' as http;

/// [ApiRepository] is a repository to handle API requests.
/// This class is used to make API requests to the server.
class ApiRepository {
  /// [_baseUrl] is the base URL of the API.
  /// This base URL is used to make the API request.
  static const String _baseUrl = "http://192.168.1.83:3000/api/v1";

  /// [_jwtToken] is the JWT token for the API request.
  /// This JWT token is used to authenticate the API request.
  static String? _jwtToken;

  /// [_headers] is the headers for the API request.
  /// This headers is used to set the headers for the API request.
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Constructor for the ApiRepository.
  ApiRepository({String? jwtToken}) {
    _jwtToken = jwtToken;

    // Set the JWT token in the headers.
    _headers['Authorization'] = 'Bearer $_jwtToken';
  }

  /// [get] is a function to make a GET request to the API.
  /// This function will make a GET request to the API with the given endpoint.
  ///
  /// Returns a [Future] of [http.Response].
  Future<http.Response> get(String endpoint) async {
    /// Make a GET request to the API.
    final res =
        await http.get(Uri.parse('$_baseUrl/$endpoint'), headers: _headers);

    return res;
  }

  /// [post] is a function to make a POST request to the API.
  /// This function will make a POST request to the API with the given endpoint.
  /// The [body] parameter is the data that will be sent to the API.
  ///
  /// Returns a [Future] of [http.Response].
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    /// Make a POST request to the API.
    final res = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: _headers, body: json.encode(body));

    return res;
  }

  /// [patch] is a function to make a PATCH request to the API.
  /// This function will make a PATCH request to the API with the given endpoint.
  /// The [body] parameter is the data that will be sent to the API.
  ///
  /// Returns a [Future] of [http.Response].
  Future<http.Response> patch(
      String endpoint, Map<String, dynamic> body) async {
    /// Make a PATCH request to the API.
    final res = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
        headers: _headers, body: json.encode(body));

    return res;
  }
}
