import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/domain/usecases/vendor_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/events/profile_event.dart';
import 'package:courtly_vendor/presentation/blocs/states/profile_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ProfileBloc] is the bloc for vendor.
/// This bloc will handle the vendor process.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  /// [vendorUsecase] is the usecase for vendor.
  final VendorUsecase vendorUsecase;

  ProfileBloc({required this.vendorUsecase}) : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_onFetchProfileEvent);
  }

  /// [_onFetchProfileEvent] is a function to handle the fetch vendor event.
  ///
  /// Parameters:
  ///   - [event] is the fetch vendor event.
  ///   - [emit] is the emitter.
  ///
  /// Returns: [Future] of [Void]
  Future<void> _onFetchProfileEvent(ProfileEvent event, Emitter emit) async {
    emit(ProfileLoadingState());

    // Fetch the vendor data
    final Either<Failure, Vendor> res = await vendorUsecase.getVendor();

    res.fold(
        (failure) => emit(
            ProfileErrorState(errorMessage: failure.errorMessage.toString())),
        (vendor) => emit(ProfileLoadedState(vendor: vendor)));
  }
}
