/// [DeleteCourtsState] is a abstract class which is used to define states for
/// delete courts.
abstract class DeleteCourtsState {}

/// [DeleteCourtsInitialState] is a class which is used to define the initial state
/// of the delete courts.
/// This state is used to show the initial state of the delete courts.
class DeleteCourtsInitialState extends DeleteCourtsState {}

/// [DeleteCourtsLoadingState] is a class which is used to define the loading state
/// of the delete courts.
/// This state is used to show the loading state of the delete courts.
class DeleteCourtsLoadingState extends DeleteCourtsState {}

/// [DeleteCourtsSuccessState] is a class which is used to define the success state
/// of the delete courts.
/// This state is used to show the success state of the delete courts.
class DeleteCourtsSuccessState extends DeleteCourtsState {}

/// [DeleteCourtsErrorState] is a class which is used to define the error state
/// of the delete courts.
/// This state is used to show the error state of the delete courts.
class DeleteCourtsErrorState extends DeleteCourtsState {
  /// [errorMessage] is a string which is used to show the error message.
  final String errorMessage;

  DeleteCourtsErrorState({required this.errorMessage});
}
