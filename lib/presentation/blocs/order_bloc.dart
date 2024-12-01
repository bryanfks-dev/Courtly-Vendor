import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/domain/usercases/order_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/order_state.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:courtly_vendor/domain/entities/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [OrderBloc] is a class that contains the business logic for the Order entity.
class OrderBloc extends Cubit<OrderState> {
  /// [orderUsecase] is an instance of [OrderUsecase] that contains the business logic for the Order entity.
  final OrderUsecase orderUsecase;

  OrderBloc({required this.orderUsecase}) : super(OrderInitialState());

  /// [getOrders] is a method that fetches the orders from the repository.
  Future<void> getOrders() async {
    emit(OrderLoadingState());

    // Fetch the orders from the repository.
    final dartz.Either<Failure, List<Order>> result =
        await orderUsecase.getOrders();

    result.fold(
      (failure) => emit(OrderErrorState(errorMessage: failure.errorMessage)),
      (orders) => emit(OrderLoadedState(orders: orders)),
    );
  }
}
