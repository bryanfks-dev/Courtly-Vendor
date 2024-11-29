import 'package:courtly_vendor/data/dto/vendor_dto.dart';

/// [LoginResponseDTO] is a data transfer object for login response.
class LoginResponseDTO {
  /// [vendor] is the vendor data.
  final VendorDTO vendor;

  /// [token] is the token for the vendor.
  final String token;

  LoginResponseDTO({
    required this.vendor,
    required this.token,
  });

  /// [fromJson] is a factory method to create a [LoginResponseDTO] from a map.
  ///
  /// Returns a [LoginResponseDTO] object.
  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) {
    return LoginResponseDTO(
      vendor: VendorDTO.fromJson(json['vendor']),
      token: json['token'],
    );
  }
}
