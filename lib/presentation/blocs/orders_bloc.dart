import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/usecases/order_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/orders_state.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [OrdersBloc] is a class that contains the business logic for the Order entity.
class OrdersBloc extends Cubit<OrdersState> {
  /// [orderUsecase] is an instance of [OrderUsecase] that contains the business logic for the Order entity.
  final OrderUsecase orderUsecase;

  OrdersBloc({required this.orderUsecase}) : super(OrdersInitialState());

  /// [getOrders] is a method that fetches the orders from the repository.
  /// 
  /// Returns [Future] of [void]
  Future<void> getOrders({String? courtType}) async {
    emit(OrdersLoadingState());

    // Fetch the orders from the repository.
    final dartz.Either<Failure, List<Order>> result =
        await orderUsecase.getOrders(courtType: courtType);

    result.fold(
      (failure) => emit(OrdersErrorState(errorMessage: failure.errorMessage)),
      (orders) => emit(OrdersLoadedState(orders: orders)),
    );
  }
}
