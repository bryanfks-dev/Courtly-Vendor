import 'package:courtly_vendor/data/dto/orders_stats_response_dto.dart';
import 'package:courtly_vendor/domain/entities/order.dart';

/// [OrdersStats] is a class that represents the statistics of orders.
class OrdersStats {
  /// [totalOrders] is the total number of orders.
  final int totalOrders;

  /// [totalOrdersToday] is the total number of orders today.
  final int totalOrdersToday;

  /// [recentOrders] is a list of recent orders.
  final List<Order> recentOrders;

  OrdersStats({
    required this.totalOrders,
    required this.totalOrdersToday,
    required this.recentOrders,
  });

  /// [fromDTO] is a factory method that creates an instance of [OrdersStats]
  /// from a [OrdersStatsResponseDTO].
  ///
  /// Parameters:
  ///   - [dto] is an [OrdersStatsResponseDTO] object.
  ///
  /// Returns: An instance of [OrdersStats].
  factory OrdersStats.fromDTO(OrdersStatsResponseDTO dto) {
    return OrdersStats(
      totalOrders: dto.totalOrders,
      totalOrdersToday: dto.totalOrdersToday,
      recentOrders: dto.recentOrders.map((e) => Order.fromDTO(e)).toList(),
    );
  }
}
