/// [LogoutState] is the abstract class that will be extended by logout states.
abstract class LogoutState {}

/// [LogoutInitialState] is the initial state of the logout bloc.
/// This state is emitted when the logout bloc is initialized.
class LogoutInitialState extends LogoutState {}

/// [LogoutLoadingState] is the loading state of the logout bloc.
/// This state is emitted when the logout bloc is making a request to the API.
class LogoutLoadingState extends LogoutState {}

/// [LogoutSuccessState] is the success state of the logout bloc.
/// This state is emitted when the logout bloc successfully logs out the user.
class LogoutSuccessState extends LogoutState {}

/// [LogoutErrorState] is the error state of the logout bloc.
/// This state is emitted when the logout bloc encounters an error.
class LogoutErrorState extends LogoutState {
  final String errorMessage;

  LogoutErrorState({required this.errorMessage});
}
