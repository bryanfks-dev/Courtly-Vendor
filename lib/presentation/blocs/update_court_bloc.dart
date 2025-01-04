import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/usecases/court_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/update_court_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [UpdateCourtBloc] is the BLoC that will manage the state of the
/// Update Court screen.
class UpdateCourtBloc extends Cubit<UpdateCourtState> {
  /// [courtUsecase] is the instance of the [CourtUsecase] that will be used
  /// to update the court details.
  final CourtUsecase courtUsecase;

  UpdateCourtBloc({required this.courtUsecase})
      : super(UpdateCourtInitialState());

  /// [updateCourt] is a method to update the court.
  ///
  /// Parameters:
  ///   - [courtType] is the court type
  ///   - [pricePerHour] is the court price per hour
  ///
  /// Returns [Future] of [void]
  Future<void> updateCourt(
      {required String courtType, required double pricePerHour}) async {
    emit(UpdateCourtLoadingState());

    // Update the court.
    final Failure? res = await courtUsecase.updateCourt(
        courtType: courtType, pricePerHour: pricePerHour);

    // Check if the request is not success
    if (res != null) {
      emit(UpdateCourtErrorState(errorMessage: res.errorMessage));

      return;
    }

    emit(UpdateCourtSuccessState());
  }
}
