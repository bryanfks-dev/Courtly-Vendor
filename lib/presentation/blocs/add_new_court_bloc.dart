import 'dart:convert';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/add_new_court_form_dto.dart';
import 'package:courtly_vendor/domain/usercases/court_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/add_new_court_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AddNewCourtBloc] is a class that is used to manage the state of the Add New Court Page.
class AddNewCourtBloc extends Cubit<AddNewCourtState> {
  /// [courtUsecase] is the usecase for the court.
  final CourtUsecase courtUsecase;

  AddNewCourtBloc({required this.courtUsecase})
      : super(AddNewCourtInitialState());

  /// [addNewCourt] is a method to add a new court.
  ///
  /// Parameters:
  ///   - [pricePerHour] is the price per hour of the court.
  ///   - [imageBytes] is the image of the court as bytes.
  ///
  /// Returns a [Future] of [void].
  Future<void> addNewCourt(
      {required int pricePerHour,
      required List<int> imageBytes,
      required String courtType}) async {
    emit(AddNewCourtLoadingState());

    // Create a new instance of [AddNewCourtFormDTO]
    final AddNewCourtFormDTO formDto = AddNewCourtFormDTO(
        pricePerHour: pricePerHour, courtsImage: base64Encode(imageBytes));

    // Execute the add new court usecase
    final Failure? fail =
        await courtUsecase.addNewCourt(formDto: formDto, courtType: courtType);

    // Check if the request is not success
    if (fail != null) {
      emit(AddNewCourtErrorState(errorMessage: fail.errorMessage));

      return;
    }

    emit(AddNewCourtSuccessState());
  }
}
