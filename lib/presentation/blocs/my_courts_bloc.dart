import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/domain/entities/courts_stats.dart';
import 'package:courtly_vendor/domain/usercases/court_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/my_courts_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [MyCourtsBloc] is a class that contains the business logic for the 
/// Court entity.
class MyCourtsBloc extends Cubit<MyCourtsState> {
  /// [courtUsecase] is an instance of [CourtUsecase] that contains the business logic for the Court entity.
  final CourtUsecase courtUsecase;

  MyCourtsBloc({required this.courtUsecase}) : super(MyCourtsInitialState());

  /// [getCourtsStats] is a method used to get the courts stats.
  /// 
  /// Returns a [Future] of [void].
  Future<void> getCourtsStats() async {
    emit(MyCourtsLoadingState());

    // Get the courts stats
    final Either<Failure, CourtsStats> result =
        await courtUsecase.getCourtsStats();

    // Check if the result is success or not
    result.fold(
      (l) => emit(MyCourtsErrorState(errorMessage: l.errorMessage)),
      (r) => emit(MyCourtsLoadedState(courtsStats: r)),
    );
  }
}
