import 'package:courtly_vendor/domain/entities/order.dart';

/// [OrderState] is an abstract class that will be extended by the states of the order bloc.
abstract class OrderState {}

/// [OrderInitialState] is a state that represents the initial state of the order bloc.
/// This state is used when the order bloc is initialized.
class OrderInitialState extends OrderState {}

/// [OrderLoadingState] is a state that represents the loading state of the order bloc.
/// This state is used when the order bloc is fetching data from the server.
class OrderLoadingState extends OrderState {}

/// [OrderLoadedState] is a state that represents the loaded state of the order bloc.
/// This state is used when the order bloc has successfully fetched data from the server.
class OrderLoadedState extends OrderState {
  /// [orders] is a list of orders.
  final List<Order> orders;

  /// [OrderLoadedState] is a constructor for [OrderLoadedState].
  OrderLoadedState({required this.orders});
}

/// [OrderErrorState] is a state that represents the error state of the order bloc.
/// This state is used when the order bloc encounters an error while fetching data from the server.
class OrderErrorState extends OrderState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  /// [OrderErrorState] is a constructor for [OrderErrorState].
  OrderErrorState({required this.errorMessage});
}
