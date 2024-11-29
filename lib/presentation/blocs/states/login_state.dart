/// [LoginState] is the abstract class that will be extended by the different states of the login bloc.
abstract class LoginState {}

/// [LoginInitialState] is the initial state of the login bloc.
class LoginInitialState extends LoginState {}

/// [LoginLoadingState] is the loading state of the login bloc.
class LoginLoadingState extends LoginState {}

/// [LoginSuccessState] is the success state of the login bloc.
class LoginSuccessState extends LoginState {}

/// [LoginErrorState] is the error state of the login bloc.
class LoginErrorState extends LoginState {
  // [errorMessage] is the error message.
  final dynamic errorMessage;

  LoginErrorState({required this.errorMessage});
}
