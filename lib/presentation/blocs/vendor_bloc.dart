import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/domain/usercases/vendor_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/vendor_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [VendorBloc] is the bloc for vendor.
/// This bloc will handle the vendor process.
class VendorBloc extends Cubit<VendorState> {
  /// [vendorUsecase] is the usecase for vendor.
  final VendorUsecase vendorUsecase;

  VendorBloc({required this.vendorUsecase}) : super(VendorInitialState());

  /// [fetchVendorData] is a function to fetch vendor data.
  ///
  /// Returns: [Future] of [Void]
  Future<void> fetchVendorData() async {
    emit(VendorLoadingState());

    // Fetch the vendor data
    final Either<Failure, Vendor> res = await vendorUsecase.getVendor();

    res.fold(
        (failure) => emit(VendorErrorState(errorMessage: failure.errorMessage)),
        (vendor) => emit(VendorLoadedState(vendor: vendor)));
  }
}
