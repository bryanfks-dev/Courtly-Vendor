import 'package:courtly_vendor/data/dto/order_dto.dart';

/// [OrdersResponseDTO] is a data transfer object for orders response.
class OrdersResponseDTO {
  /// [orders] is a list of orders.
  final List<OrderDTO> orders;

  /// [OrdersResponseDTO] is a constructor for [OrdersResponseDTO].
  const OrdersResponseDTO(this.orders);

  /// [fromJson] is a factory method to create a [OrdersResponseDTO] from a map.
  ///
  /// Returns a [OrdersResponseDTO] object.
  factory OrdersResponseDTO.fromJson(Map<String, dynamic> json) {
    return OrdersResponseDTO(
      (json['orders'] as List)
          .map((order) => OrderDTO.fromJson(order))
          .toList(),
    );
  }
}
