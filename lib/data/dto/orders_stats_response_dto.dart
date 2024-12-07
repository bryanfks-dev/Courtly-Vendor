import 'package:courtly_vendor/data/dto/order_dto.dart';

/// [OrdersStatsResponseDTO] is a DTO class that holds the response data
/// of the orders statistics.
class OrdersStatsResponseDTO {
  /// [totalOrders] is the total number of orders.
  final int totalOrders;

  /// [totalOrdersToday] is the total number of orders today.
  final int totalOrdersToday;

  /// [recentOrders] is the list of recent orders.
  final List<OrderDTO> recentOrders;

  OrdersStatsResponseDTO({
    required this.totalOrders,
    required this.totalOrdersToday,
    required this.recentOrders,
  });

  /// [fromJson] is a method that converts a JSON object to a
  /// [OrdersStatsResponseDTO] object.
  ///
  /// Parameters:
  ///   - [json] is a JSON object.
  ///
  /// Returns a [OrdersStatsResponseDTO]
  factory OrdersStatsResponseDTO.fromJson(Map<String, dynamic> json) {
    return OrdersStatsResponseDTO(
      totalOrders: json['total_orders'],
      totalOrdersToday: json['total_orders_today'],
      recentOrders: json['recent_orders'],
    );
  }
}
