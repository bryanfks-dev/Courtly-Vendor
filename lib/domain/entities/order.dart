import 'package:courtly_vendor/data/dto/order_dto.dart';
import 'package:courtly_vendor/domain/entities/court.dart';
import 'package:courtly_vendor/domain/entities/user.dart';
import 'package:intl/intl.dart';

/// [Order] is a class that represents the order entity.
class Order {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [user] is the user who ordered.
  final User user;

  /// [court] is the court that was ordered.
  final Court court;

  /// [date] is the date of the booking.
  final DateTime date;

  /// [bookStartTime] is the start time of the booking.
  final DateTime bookStartTime;

  /// [bookEndTime] is the end time of the booking.
  final DateTime bookEndTime;

  /// [price] is the price of the booking.
  final double price;

  Order({
    required this.id,
    required this.user,
    required this.court,
    required this.date,
    required this.bookStartTime,
    required this.bookEndTime,
    required this.price,
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

    /// [timeFormatter] is a time formatter object.
    final DateFormat timeFormatter = DateFormat('HH:mm');

    return Order(
      id: dto.id,
      user: User.fromDTO(dto.user),
      court: Court.fromDTO(dto.court),
      date: dateFormatter.parse(dto.date),
      bookStartTime: timeFormatter.parse(dto.bookStartTime),
      bookEndTime: timeFormatter.parse(dto.bookEndTime),
      price: dto.price,
    );
  }
}
