import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/entities/court.dart';
import 'package:courtly_vendor/domain/usecases/court_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/add_court_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AddCourtBloc] is the business logic component for adding a court.
class AddCourtBloc extends Cubit<AddCourtState> {
  /// [courtUsecase] is the usecase for court.
  final CourtUsecase courtUsecase;

  AddCourtBloc({required this.courtUsecase}) : super(AddCourtInitialState());

  /// [addCourt] is a method to add a court.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [void]
  Future<void> addCourt({required String courtType}) async {
    emit(AddCourtLoadingState());

    // Make a POST request to the API.
    final Either<Failure, Court> res =
        await courtUsecase.addCourt(courtType: courtType);

    res.fold((l) => emit(AddCourtErrorState(errorMessage: l.errorMessage)),
        (r) => emit(AddCourtSuccessState()));
  }
}
