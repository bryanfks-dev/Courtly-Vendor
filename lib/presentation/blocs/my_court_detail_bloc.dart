import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/booking.dart';
import 'package:courtly_vendor/domain/entities/court.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/domain/usecases/court_usecase.dart';
import 'package:courtly_vendor/domain/usecases/vendor_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/my_court_detail_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [MyCourtDetailBloc] is the BLoC that will manage the state of the
/// My Court Detail screen.
class MyCourtDetailBloc extends Cubit<MyCourtDetailState> {
  /// [courtUsecase] is the instance of the [CourtUsecase] that will be used
  /// to fetch the court details.
  final CourtUsecase courtUsecase;

  /// [vendorUsecase] is the instance of the [VendorUsecase] that will be used
  /// to fetch the vendor details.
  final VendorUsecase vendorUsecase;

  MyCourtDetailBloc({required this.courtUsecase, required this.vendorUsecase})
      : super(MyCourtDetailInitialState());

  /// [getCourtsData] is a method that fetches the court details and the
  /// bookings for the given date.
  /// 
  /// Parameters:
  ///   - [courtType]: The type of the court.
  ///   - [date]: The date for which the bookings are to be fetched.
  ///
  /// Returns [void].
  Future<void> getCourtsData(
      {required String courtType, required DateTime date}) async {
    emit(MyCourtDetailLoadingState());

    // Fetch the court details.
    final res = await Future.wait([
      courtUsecase.getCourts(courtType: courtType),
      courtUsecase.getCourtBookings(courtType: courtType, date: date),
      vendorUsecase.getVendor()
    ]);

    // Fetch the court details.
    final Either<Failure, List<Court>> courts =
        res[0] as Either<Failure, List<Court>>;

    final Either<Failure, List<Booking>> bookings =
        res[1] as Either<Failure, List<Booking>>;

    // Fetch the vendor.
    final Either<Failure, Vendor> vendor = res[2] as Either<Failure, Vendor>;

    // Check if the request is not success
    if (courts.isLeft()) {
      emit(MyCourtDetailErrorState(
          errorMessage: courts.fold((l) => l.errorMessage,
              (r) => const UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    if (bookings.isLeft()) {
      emit(MyCourtDetailErrorState(
          errorMessage: bookings.fold((l) => l.errorMessage,
              (r) => const UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    if (vendor.isLeft()) {
      emit(MyCourtDetailErrorState(
          errorMessage: vendor.fold((l) => l.errorMessage,
              (r) => const UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    // Emit the loaded state.
    emit(MyCourtDetailLoadedState(
        courts: courts.getOrElse(() => throw "No Courts Response"),
        bookings: bookings.getOrElse(() => throw "No Bookings Response"),
        vendor: vendor.getOrElse(() => throw "No Vendor Response")));
  }
}
