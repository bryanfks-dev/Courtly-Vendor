import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/order_detail.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/domain/usecases/order_usecase.dart';
import 'package:courtly_vendor/domain/usecases/vendor_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/order_detail_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [OrderDetailBloc] is a class that contains the business logic for the
/// OrderDetail entity.
class OrderDetailBloc extends Cubit<OrderDetailState> {
  /// [vendorUsecase] is an instance of [VendorUsecase].
  final VendorUsecase vendorUsecase;

  /// [orderUsecase] is an instance of [OrderUsecase].
  final OrderUsecase orderUsecase;

  OrderDetailBloc({required this.orderUsecase, required this.vendorUsecase})
      : super(OrderDetailInitialState());

  /// [getOrderDetail] is a method that fetches the order details
  /// and the vendor details.
  /// 
  /// Parameters:
  ///   - [orderId]: The ID of the order.
  /// 
  /// Returns [void]
  Future<void> getOrderDetail({required int orderId}) async {
    emit(OrderDetailLoadingState());

    // Fetch the order details and the vendor details in parallel.
    final res = await Future.wait([
      orderUsecase.getOrderDetail(orderId: orderId),
      vendorUsecase.getVendor(),
    ]);

    // Extract the results.
    final Either<Failure, OrderDetail> orderDetail =
        res[0] as Either<Failure, OrderDetail>;

    final Either<Failure, Vendor> vendor = res[1] as Either<Failure, Vendor>;

    // Check if the result is a success or a failure.
    if (orderDetail.isLeft()) {
      emit(OrderDetailErrorState(
          errorMessage: orderDetail.fold((l) => l.errorMessage,
              (r) => const UnknownFailure("Unknown Error").errorMessage)));

      return;
    }

    if (vendor.isLeft()) {
      emit(OrderDetailErrorState(
          errorMessage: vendor.fold((l) => l.errorMessage,
              (r) => const UnknownFailure("Unknown Error").errorMessage)));

      return;
    }

    // Emit the success state.
    emit(OrderDetailLoadedState(
        orderDetail:
            orderDetail.getOrElse(() => throw "No Order Detail Response"),
        vendor: vendor.getOrElse(() => throw "No Vendor Response")));
  }
}
