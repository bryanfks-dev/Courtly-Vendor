import 'package:courtly_vendor/data/dto/vendor_dto.dart';

/// [VendorResponseDTO] is a data transfer object for vendor response.
class VendorResponseDTO {
  /// [vendor] is the vendor data.
  final VendorDTO vendor;

  VendorResponseDTO({
    required this.vendor,
  });

  /// [fromJson] is a factory method to create a [VendorResponseDTO] from a map.
  ///
  /// Returns a [VendorResponseDTO] object.
  factory VendorResponseDTO.fromJson(Map<String, dynamic> json) {
    return VendorResponseDTO(
      vendor: VendorDTO.fromJson(json['vendor']),
    );
  }
}
