/// [UpdateCourtState] is the abstract class that will be extended by the
/// update court states.
abstract class UpdateCourtState {}

/// [UpdateCourtInitialState] is the initial state of the update court state.
/// This state is the default state of the update court state.
class UpdateCourtInitialState extends UpdateCourtState {}

/// [UpdateCourtLoadingState] is the loading state of the update court state.
/// This state is triggered when the update court state is in the process of
/// updating the court.
class UpdateCourtLoadingState extends UpdateCourtState {}

/// [UpdateCourtSuccessState] is the success state of the update court state.
/// This state is triggered when the update court state has successfully updated
/// the court.
class UpdateCourtSuccessState extends UpdateCourtState {}

/// [UpdateCourtErrorState] is the error state of the update court state.
/// This state is triggered when the update court state has failed to update the
/// court.
class UpdateCourtErrorState extends UpdateCourtState {
  /// [errorMessage] is the error message.
  final dynamic errorMessage;

  /// [UpdateCourtErrorState] constructor.
  UpdateCourtErrorState({required this.errorMessage});
}
