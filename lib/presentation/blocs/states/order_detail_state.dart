import 'package:courtly_vendor/domain/entities/order_detail.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';

/// [OrderDetailState] is a abstract class that will be extended by the states
/// of the order detail bloc.
abstract class OrderDetailState {}

/// [OrderDetailInitialState] is a class that represents the initial state of the
/// order detail bloc.
/// This state is emitted when the order detail bloc is initialized.
class OrderDetailInitialState extends OrderDetailState {}

/// [OrderDetailLoadingState] is a class that represents the loading state of the
/// order detail bloc.
/// This state is emitted when the order detail bloc is loading.
class OrderDetailLoadingState extends OrderDetailState {}

/// [OrderDetailLoadedState] is a class that represents the loaded state of the
/// order detail bloc.
/// This state is emitted when the order detail bloc has successfully loaded the
/// order detail.
class OrderDetailLoadedState extends OrderDetailState {
  /// [orderDetail] is the detail of the order
  final OrderDetail orderDetail;

  /// [vendor] is the vendor
  final Vendor vendor;

  OrderDetailLoadedState({required this.orderDetail, required this.vendor});
}

/// [OrderDetailErrorState] is a class that represents the error state of the
/// order detail bloc.
/// This state is emitted when the order detail bloc has failed to load the
/// order detail.
class OrderDetailErrorState extends OrderDetailState {
  /// [errorMessage] is a string that represents the error message.
  final String errorMessage;

  OrderDetailErrorState({required this.errorMessage});
}
