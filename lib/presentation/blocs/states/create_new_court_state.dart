/// [CreateNewCourtState] is an abstract class that is used to define the states of the Add New Court Page.
abstract class CreateNewCourtState {}

/// [CreateNewCourtInitialState] is a class that is used to define the initial state of the Add New Court Page.
/// This state is used when the Add New Court Page is initialized.
class CreateNewCourtInitialState extends CreateNewCourtState {}

/// [CreateNewCourtLoadingState] is a class that is used to define the loading state of the Add New Court Page.
/// This state is used when the Add New Court Page is in the loading state.
class CreateNewCourtLoadingState extends CreateNewCourtState {}

/// [CreateNewCourtSuccessState] is a class that is used to define the success state of the Add New Court Page.
/// This state is used when the Add New Court Page is successful.
class CreateNewCourtSuccessState extends CreateNewCourtState {}

/// [CreateNewCourtErrorState] is a class that is used to define the error state of the Add New Court Page.
/// This state is used when the Add New Court Page has an error.
class CreateNewCourtErrorState extends CreateNewCourtState {
  /// [errorMessage] is the error message.
  final dynamic errorMessage;

  CreateNewCourtErrorState({required this.errorMessage});
}
