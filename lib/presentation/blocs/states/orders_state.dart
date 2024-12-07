import 'package:courtly_vendor/domain/entities/order.dart';

/// [OrdersState] is an abstract class that will be extended by the states of the order bloc.
abstract class OrdersState {}

/// [OrdersInitialState] is a state that represents the initial state of the order bloc.
/// This state is used when the order bloc is initialized.
class OrdersInitialState extends OrdersState {}

/// [OrdersLoadingState] is a state that represents the loading state of the order bloc.
/// This state is used when the order bloc is fetching data from the server.
class OrdersLoadingState extends OrdersState {}

/// [OrdersLoadedState] is a state that represents the loaded state of the order bloc.
/// This state is used when the order bloc has successfully fetched data from the server.
class OrdersLoadedState extends OrdersState {
  /// [orders] is a list of orders.
  final List<Order> orders;

  /// [OrdersLoadedState] is a constructor for [OrdersLoadedState].
  OrdersLoadedState({required this.orders});
}

/// [OrdersErrorState] is a state that represents the error state of the order bloc.
/// This state is used when the order bloc encounters an error while fetching data from the server.
class OrdersErrorState extends OrdersState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  /// [OrdersErrorState] is a constructor for [OrdersErrorState].
  OrdersErrorState({required this.errorMessage});
}
