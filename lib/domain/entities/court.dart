import 'package:courtly_vendor/data/dto/court_dto.dart';

class Court {
  /// [id] is the unique identifier of the court.
  final int id;

  /// [name] is the name of the court.
  final String name;

  /// [type] is the type of the court.
  final String type;

  /// [price] is the price of the court.
  final double price;

  Court({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
  });

  /// [fromDTO] is a factory method to create a [Court] from a dto.
  ///
  /// Parameters:
  ///   - [dto] is t he court dto object.
  ///
  /// Returns a [Court] object.
  factory Court.fromDTO(CourtDTO dto) {
    return Court(
      id: dto.id,
      name: dto.name,
      type: dto.type,
      price: dto.price,
    );
  }
}
