import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/domain/usercases/vendor_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/events/vendor_event.dart';
import 'package:courtly_vendor/presentation/blocs/states/vendor_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [VendorBloc] is the bloc for vendor.
/// This bloc will handle the vendor process.
class VendorBloc extends Bloc<VendorEvent, VendorState> {
  /// [vendorUsecase] is the usecase for vendor.
  final VendorUsecase vendorUsecase;

  VendorBloc({required this.vendorUsecase}) : super(VendorInitialState()) {
    on<FetchVendorEvent>(_onFetchVendorEvent);
  }

  /// [_onFetchVendorEvent] is a function to handle the fetch vendor event.
  ///
  /// Parameters:
  ///   - [event] is the fetch vendor event.
  ///   - [emit] is the emitter.
  ///
  /// Returns: [Future] of [Void]
  Future<void> _onFetchVendorEvent(VendorEvent event, Emitter emit) async {
    emit(VendorLoadingState());

    // Fetch the vendor data
    final Either<Failure, Vendor> res = await vendorUsecase.getVendor();

    res.fold(
        (failure) => emit(
            VendorErrorState(errorMessage: failure.errorMessage.toString())),
        (vendor) => emit(VendorLoadedState(vendor: vendor)));
  }
}
