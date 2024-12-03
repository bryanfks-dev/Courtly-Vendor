/// [AddNewCourtState] is an abstract class that is used to define the states of the Add New Court Page.
abstract class AddNewCourtState {}

/// [AddNewCourtInitialState] is a class that is used to define the initial state of the Add New Court Page.
/// This state is used when the Add New Court Page is initialized.
class AddNewCourtInitialState extends AddNewCourtState {}

/// [AddNewCourtLoadingState] is a class that is used to define the loading state of the Add New Court Page.
/// This state is used when the Add New Court Page is in the loading state.
class AddNewCourtLoadingState extends AddNewCourtState {}

/// [AddNewCourtSuccessState] is a class that is used to define the success state of the Add New Court Page.
/// This state is used when the Add New Court Page is successful.
class AddNewCourtSuccessState extends AddNewCourtState {}

/// [AddNewCourtErrorState] is a class that is used to define the error state of the Add New Court Page.
/// This state is used when the Add New Court Page has an error.
class AddNewCourtErrorState extends AddNewCourtState {
  /// [errorMessage] is the error message.
  final dynamic errorMessage;

  AddNewCourtErrorState({required this.errorMessage});
}
