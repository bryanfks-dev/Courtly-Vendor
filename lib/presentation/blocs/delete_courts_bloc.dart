import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/usecases/court_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/delete_courts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [DeleteCourtsBloc] is a class which is used to manage the delete courts
/// state.
class DeleteCourtsBloc extends Cubit<DeleteCourtsState> {
  /// [DeleteCourtsBloc] is a class which is used to manage the delete courts
  final CourtUsecase courtUsecase;

  DeleteCourtsBloc({required this.courtUsecase})
      : super(DeleteCourtsInitialState());

  /// [deleteCourts] is a function that delete the courts.
  ///
  /// Parameters:
  ///   - [courtIds] is a list of court ids to be deleted.
  ///
  /// Returns [Future] of [void]
  Future<void> deleteCourts({required List<int> courtIds}) async {
    emit(DeleteCourtsLoadingState());

    // Delete the court
    final Failure? res = await courtUsecase.deleteCourts(courtIds: courtIds);

    // Check if there is an error
    if (res != null) {
      emit(DeleteCourtsErrorState(errorMessage: res.errorMessage));

      return;
    }

    emit(DeleteCourtsSuccessState());
  }
}
