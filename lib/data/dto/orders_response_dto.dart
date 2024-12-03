import 'package:courtly_vendor/data/dto/order_dto.dart';

/// [OrdersResponseDTO] is a data transfer object for orders response.
class OrdersResponseDTO {
  /// [orders] is a list of orders.
  final List<OrderDTO> orders;

  const OrdersResponseDTO({required this.orders});

  /// [fromJson] is a factory method to create a [OrdersResponseDTO] from a map.
  /// 
  /// Parameters:
  ///   - [json] is a map that contains the orders data.
  ///
  /// Returns a [OrdersResponseDTO] object.
  factory OrdersResponseDTO.fromJson(Map<String, dynamic> json) {
    return OrdersResponseDTO(
      orders: (json['orders'] as List)
          .map((order) => OrderDTO.fromJson(order))
          .toList(),
    );
  }
}
