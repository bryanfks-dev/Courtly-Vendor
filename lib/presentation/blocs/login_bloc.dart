import 'dart:async';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/login_form_dto.dart';
import 'package:courtly_vendor/domain/usecases/login_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [LoginBloc] is the bloc for login.
class LoginBloc extends Cubit<LoginState> {
  /// [LoginBloc] is the bloc for login.
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginInitialState());

  /// [login] is the function to perform login.
  /// This function will emit the states based on the login response.
  ///
  /// Parameters:
  ///   - [email] is the email.
  ///   - [password] is the password.
  ///
  /// Returns a [Future<void>].
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    // Create a new instance of [LoginResponseDTO]
    final formDto = LoginFormDTO(email: email, password: password);

    // Execute the login usecase
    final Failure? fail = await loginUsecase.login(formDto);

    // Check if the response is not successful
    if (fail != null) {
      emit(LoginErrorState(errorMessage: fail.errorMessage));

      return;
    }

    emit(LoginSuccessState());
  }
}
