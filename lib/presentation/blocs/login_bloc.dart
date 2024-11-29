import 'package:courtly_vendor/data/dto/login_form_dto.dart';
import 'package:courtly_vendor/data/dto/login_response_dto.dart';
import 'package:courtly_vendor/data/dto/response_dto.dart';
import 'package:courtly_vendor/domain/usercases/login_usecase.dart';
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

    try {
      // Execute the login usecase
      final ResponseDTO<LoginResponseDTO> res =
          await loginUsecase.execute(formDto);

      // Check if the response is not successful
      if (!res.success) {
        emit(LoginErrorState(errorMessage: res.message));

        return;
      }

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
