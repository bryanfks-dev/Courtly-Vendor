import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/orders_response_dto.dart';
import 'package:courtly_vendor/data/dto/orders_stats_response_dto.dart';
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:courtly_vendor/data/repository/api/order_repository.dart';
import 'package:courtly_vendor/domain/entities/orders_stats.dart';
import 'package:dartz/dartz.dart' as dartz;

/// [OrderUsecase] is a class that contains the business logic for the Order entity.
class OrderUsecase {
  /// [orderRepository] is an instance of [OrderRepository] that is used to interact with the data layer.
  final OrderRepository orderRepository;

  OrderUsecase({required this.orderRepository});

  /// [getOrders] is a method that returns a list of orders.
  ///
  /// Returns a list of [Order] objects.
  Future<dartz.Either<Failure, List<Order>>> getOrders() async {
    // Fetch the orders from the repository.
    final dartz.Either<Failure, OrdersResponseDTO> orders =
        await orderRepository.getOrders();

    // Convert the list of order dtos to a list of order entities.
    return orders.fold(
      (l) => dartz.Left(l),
      (r) => dartz.right(r.orders.map((dto) => Order.fromDTO(dto)).toList()),
    );
  }

  /// [getOrdersStats] is a method that returns the orders stats.
  ///
  /// Returns an [OrdersStats] object.
  Future<dartz.Either<Failure, OrdersStats>> getOrdersStats() async {
    // Fetch the orders stats from the repository.
    final dartz.Either<Failure, OrdersStatsResponseDTO> ordersStats =
        await orderRepository.getOrdersStats();

    // Convert the order stats dto to an order stats entity.
    return ordersStats.fold(
      (l) => dartz.Left(l),
      (r) => dartz.Right(OrdersStats.fromDTO(r)),
    );
  }
}
