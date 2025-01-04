/// [AddCourtState] is the abstract class that will be extended by the add court
/// states
abstract class AddCourtState {}

/// [AddCourtInitialState] is the initial state of the add court bloc state.
/// This state is emitted when the bloc is initialized and ready to start.
class AddCourtInitialState extends AddCourtState {}

/// [AddCourtLoadingState] is the loading state of the add court bloc state.
/// This state is emitted when the bloc is processing the add court request.
class AddCourtLoadingState extends AddCourtState {}

/// [AddCourtSuccessState] is the success state of the add court bloc state.
/// This state is emitted when the add court request is successful.
class AddCourtSuccessState extends AddCourtState {}

/// [AddCourtErrorState] is the error state of the add court bloc state.
/// This state is emitted when the add court request fails.
class AddCourtErrorState extends AddCourtState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  AddCourtErrorState({required this.errorMessage});
}
