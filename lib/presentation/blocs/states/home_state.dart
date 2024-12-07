import 'package:courtly_vendor/domain/entities/orders_stats.dart';

/// [HomeState] is the abstract class that will be extended by the different
/// states of the HomeBloc.
abstract class HomeState {}

/// [HomeInitialState] is the initial state of the HomeBloc.
/// This state is emitted when the HomeBloc is initialized.
class HomeInitialState extends HomeState {}

/// [HomeLoadingState] is the loading state of the HomeBloc.
/// This state is emitted when the HomeBloc is loading data.
class HomeLoadingState extends HomeState {}

/// [HomeLoadedState] is the loaded state of the HomeBloc.
/// This state is emitted when the HomeBloc has loaded data.
class HomeLoadedState extends HomeState {
  /// [ordersStats] is an instance of [OrdersStats].
  final OrdersStats ordersStats;

  HomeLoadedState({required this.ordersStats});
}

/// [HomeErrorState] is the error state of the HomeBloc.
/// This state is emitted when the HomeBloc encounters an error.
class HomeErrorState extends HomeState {
  /// [errorMessage] is a string that contains the error message.
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}
