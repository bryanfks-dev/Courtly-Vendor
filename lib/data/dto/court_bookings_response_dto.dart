import 'package:courtly_vendor/data/dto/booking_dto.dart';

/// [CourtBookingsResponseDTO] is the DTO for the response of the court bookings.
class CourtBookingsResponseDTO {
  /// [courtBookings] is the list of court bookings.
  final List<BookingDTO> courtBookings;

  CourtBookingsResponseDTO({required this.courtBookings});

  /// [fromJson] is the method that will convert the JSON object to the DTO.
  ///
  /// Parameters:
  ///   - [json] is the JSON object.
  ///
  /// Returns [CourtBookingsResponseDTO].
  factory CourtBookingsResponseDTO.fromJson(Map<String, dynamic> json) {
    return CourtBookingsResponseDTO(
      courtBookings: (json['bookings'] as List)
          .map((x) => BookingDTO.fromJson(x))
          .toList(),
    );
  }
}
