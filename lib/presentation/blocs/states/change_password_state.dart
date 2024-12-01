/// [ChangePasswordState] is a abstract class which is used to define states of change password bloc.
abstract class ChangePasswordState {}

/// [ChangePasswordInitialState] is a class which is used to define initial state of change password bloc.
class ChangePasswordInitialState extends ChangePasswordState {}

/// [ChangePasswordVerfyingState] is a class which is used to define verifying state of change password bloc.
class ChangePasswordVerfyingState extends ChangePasswordState {}

/// [ChangePasswordVerifiedState] is a class which is used to define verified state of change password bloc.
class ChangePasswordVerifiedState extends ChangePasswordState {}

/// [ChangePasswordChangingState] is a class which is used to define loading state of change password bloc.
class ChangePasswordChangingState extends ChangePasswordState {}

/// [ChangePasswordSuccessState] is a class which is used to define success state of change password bloc.
class ChangePasswordSuccessState extends ChangePasswordState {}

/// [ChangePasswordErrorState] is a class which is used to define error state of change password bloc.
class ChangePasswordErrorState extends ChangePasswordState {
  /// [errorMessage] is a string which is used to store the error message.
  final dynamic errorMessage;

  ChangePasswordErrorState({required this.errorMessage});
}
