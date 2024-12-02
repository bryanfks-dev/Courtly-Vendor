import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/orders_response_dto.dart';
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:courtly_vendor/data/repository/api/order_repository.dart';
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

    // Check if there is failure
    if (orders.isLeft()) {
      return dartz.Left(orders.fold(
          (l) => l, (r) => const UnknownFailure("An unknown error occurred")));
    }

    // Convert the list of order dtos to a list of order entities.
    return dartz.Right(orders.fold(
      (l) => <Order>[],
      (r) => r.orders.map((dto) => Order.fromDTO(dto)).toList(),
    ));
  }
}
