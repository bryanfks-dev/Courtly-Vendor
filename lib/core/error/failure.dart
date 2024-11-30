/// [Failure] is a base class for all errors that can occur in the application.
abstract class Failure {
  /// [errorMessage] is the error message that will be displayed to the user.
  final String errorMessage;

  const Failure(this.errorMessage);
}

/// [NetworkFailure] is a class for network errors.
class NetworkFailure extends Failure {
  const NetworkFailure(super.errorMessage);
}

/// [ServerFailure] is a class for server errors.
class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);
}

/// [FormFailure] is a class for form errors.
class FormFailure extends Failure {
  const FormFailure(super.errorMessage);
}

/// [UnknownFailure] is a class for unknown errors.
class UnknownFailure extends Failure {
  const UnknownFailure(super.errorMessage);
}
