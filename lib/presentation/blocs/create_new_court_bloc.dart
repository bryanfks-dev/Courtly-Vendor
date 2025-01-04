import 'dart:io';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/domain/usecases/court_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/create_new_court_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [CreateNewCourtBloc] is a class that is used to manage the state of the Add New Court Page.
class CreateNewCourtBloc extends Cubit<CreateNewCourtState> {
  /// [courtUsecase] is the usecase for the court.
  final CourtUsecase courtUsecase;

  CreateNewCourtBloc({required this.courtUsecase})
      : super(CreateNewCourtInitialState());

  /// [createNewCourt] is a method to create a new court.
  ///
  /// Parameters:
  ///   - [pricePerHour] is the price per hour of the court.
  ///   - [imageFile] is the image file of the court.
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [void].
  Future<void> createNewCourt(
      {required double pricePerHour,
      required File imageFile,
      required String courtType}) async {
    emit(CreateNewCourtLoadingState());

    // Execute the add new court usecase
    final Failure? fail = await courtUsecase.createNewCourt(
        pricePerHour: pricePerHour, imageFile: imageFile, courtType: courtType);

    // Check if the request is not success
    if (fail != null) {
      emit(CreateNewCourtErrorState(errorMessage: fail.errorMessage));

      return;
    }

    emit(CreateNewCourtSuccessState());
  }
}
