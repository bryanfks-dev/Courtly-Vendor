import 'package:courtly_vendor/data/dto/court_dto.dart';
import 'package:courtly_vendor/data/dto/user_dto.dart';

/// [OrderDTO] is a data transfer object that represents the order data.
class OrderDTO {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [user] is the user who ordered.
  final UserDTO user;

  /// [court] is the ordered court.
  final CourtDTO court;

  /// [date] is the date of the booking.
  final String date;

  /// [bookStartTime] is the start time of the booking.
  final String bookStartTime;

  /// [bookEndTime] is the end time of the booking.
  final String bookEndTime;

  /// [price] is the price of the booking.
  final double price;

  OrderDTO({
    required this.id,
    required this.user,
    required this.court,
    required this.date,
    required this.bookStartTime,
    required this.bookEndTime,
    required this.price,
  });

  /// [fromJson] is a factory method to create an [OrderDTO] from a map.
  ///
  /// Parameters:
  ///   - [json] is a map that contains the order data.
  ///
  /// Returns an [OrderDTO] object.
  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      id: json['id'],
      user: json['user'],
      court: json['court'],
      date: json['date'],
      bookStartTime: json['book_start_time'],
      bookEndTime: json['book_end_time'],
      price: json['price'],
    );
  }
}
