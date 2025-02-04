import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/order_detail_dto.dart';
import 'package:courtly_vendor/data/dto/orders_response_dto.dart';
import 'package:courtly_vendor/data/dto/orders_stats_response_dto.dart';
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:courtly_vendor/data/repository/api/order_repository.dart';
import 'package:courtly_vendor/domain/entities/order_detail.dart';
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
  Future<dartz.Either<Failure, List<Order>>> getOrders(
      {String? courtType}) async {
    // Fetch the orders from the repository.
    final dartz.Either<Failure, OrdersResponseDTO> orders =
        await orderRepository.getOrders(courtType: courtType);

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

  /// [getOrderDetail] is a method that returns the order detail.
  ///
  /// Parameters:
  ///   - [orderId] is the ID of the order.
  ///
  /// Returns an [OrderDetail] object.
  Future<dartz.Either<Failure, OrderDetail>> getOrderDetail(
      {required int orderId}) async {
    // Fetch the order detail from the repository.
    final dartz.Either<Failure, OrderDetailDTO> orderDetail =
        await orderRepository.getOrderDetail(orderId: orderId);

    // Convert the order detail dto to an order detail entity.
    return orderDetail.fold(
      (l) => dartz.Left(l),
      (r) => dartz.Right(OrderDetail.fromDTO(r)),
    );
  }
}
