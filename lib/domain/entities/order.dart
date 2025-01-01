import 'package:courtly_vendor/data/dto/order_dto.dart';
import 'package:courtly_vendor/domain/entities/user.dart';
import 'package:intl/intl.dart';

/// [Order] is a class that represents the order entity.
class Order {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [user] is the user who ordered.
  final User user;

  /// [courtType] is the type of the court.
  final String courtType;

  /// [date] is the date of the booking.
  final DateTime date;

  /// [price] is the price of the booking.
  final double price;

  /// [appFee] is the application fee of the booking.
  final double appFee;

  Order({
    required this.id,
    required this.user,
    required this.courtType,
    required this.date,
    required this.price,
    required this.appFee,
  });

  /// [fromDTO] is a factory method to create an [Order] from a dto.
  ///
  /// Parameters:
  ///   - [dto] is the order dto object.
  ///
  /// Returns an [Order] object.
  factory Order.fromDTO(OrderDTO dto) {
    /// [dateFormatter] is a date formatter object.
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    return Order(
      id: dto.id,
      user: User.fromDTO(dto.user),
      courtType: dto.courtType,
      date: dateFormatter.parse(dto.date),
      price: dto.price,
      appFee: dto.appFee,
    );
  }
}
