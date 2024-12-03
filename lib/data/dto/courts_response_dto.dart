import 'package:courtly_vendor/data/dto/court_dto.dart';

/// [CourtsResponseDTO] is a data transfer object for courts response.
class CourtsResponseDTO {
  /// [courts] is a list of courts.
  final List<CourtDTO> courts;

  CourtsResponseDTO({required this.courts});

  /// [fromJson] is a factory method to create a [CourtsResponseDTO] from a map.
  ///
  /// Parameters:
  ///   - [json] is a map that contains the courts data.
  ///
  /// Returns a [CourtsResponseDTO] object.
  factory CourtsResponseDTO.fromJson(Map<String, dynamic> json) {
    return CourtsResponseDTO(
      courts: (json['courts'] as List)
          .map((court) => CourtDTO.fromJson(court))
          .toList(),
    );
  }
}
