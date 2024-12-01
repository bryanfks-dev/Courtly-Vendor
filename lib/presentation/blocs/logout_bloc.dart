import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/domain/usercases/logout_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [LogoutBloc] is the BLoC class for logout.
class LogoutBloc extends Cubit<LogoutState> {
  /// [logoutUsecase] is the usecase for logout.
  final LogoutUsecase logoutUsecase;

  LogoutBloc({required this.logoutUsecase}) : super(LogoutInitialState());

  /// [logout] is a function to logout the user.
  ///
  /// Returns a [Future] of [void].
  Future<void> logout() async {
    emit(LogoutLoadingState());

    // Make a request to the API.
    final Failure? failure = await logoutUsecase.logout();

    // Check if the request is successful.
    if (failure != null) {
      emit(LogoutErrorState(errorMessage: failure.errorMessage));

      return;
    }

    emit(LogoutSuccessState());
  }
}
