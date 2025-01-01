import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/orders_stats.dart';
import 'package:courtly_vendor/domain/usecases/order_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/home_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [HomeBloc] is a class that contains the business logic for the Home screen.
class HomeBloc extends Cubit<HomeState> {
  /// [orderUsecase] is an instance of [OrderUsecase].
  final OrderUsecase orderUsecase;

  HomeBloc({required this.orderUsecase}) : super(HomeInitialState());

  /// [getOrdersStats] is a method that fetches the statistics of orders.
  /// 
  /// Returns a [Future] of [void].
  Future<void> getOrdersStats() async {
    emit(HomeLoadingState());

    // Fetch the orders stats from the repository.
    final Either<Failure, OrdersStats> ordersStats =
        await orderUsecase.getOrdersStats();

    // Check if the request was successful.
    ordersStats.fold(
      (l) => emit(HomeErrorState(errorMessage: l.errorMessage)),
      (r) => emit(HomeLoadedState(ordersStats: r)),
    );
  }
}
