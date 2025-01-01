import 'package:courtly_vendor/data/dto/user_dto.dart';

/// [OrderDTO] is a data transfer object that represents the order data.
class OrderDTO {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [user] is the user who ordered.
  final UserDTO user;

  /// [courtType] is the type of the court.
  final String courtType;

  /// [date] is the date of the booking.
  final String date;

  /// [price] is the price of the booking.
  final double price;

  /// [appFee] is the application fee of the booking.
  final double appFee;

  OrderDTO({
    required this.id,
    required this.user,
    required this.courtType,
    required this.date,
    required this.price,
    required this.appFee,
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
      user: UserDTO.fromJson(json['user']),
      courtType: json['court_type'],
      date: json['date'],
      price: json['price'] + .0,
      appFee: json['app_fee'] + .0,
    );
  }
}
