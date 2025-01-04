import 'package:courtly_vendor/data/dto/court_dto.dart';

/// [CourtResponseDTO] is a data transfer object that represents the
/// court response data.
class CourtResponseDTO {
  /// [court] is the court data.
  final CourtDTO court;

  CourtResponseDTO({required this.court});

  /// [fromJson] is a factory method to create a [CourtResponseDTO] from a map.
  ///
  /// Parameters:
  ///   - [json] is a map that contains the court response data.
  ///
  /// Returns a [CourtResponseDTO] object.
  factory CourtResponseDTO.fromJson(Map<String, dynamic> json) {
    return CourtResponseDTO(
      court: CourtDTO.fromJson(json['court']),
    );
  }
}
