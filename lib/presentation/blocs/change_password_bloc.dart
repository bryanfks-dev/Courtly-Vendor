import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/change_password_form_dto.dart';
import 'package:courtly_vendor/data/dto/verify_password_form_dto.dart';
import 'package:courtly_vendor/domain/usercases/change_password_usecase.dart';
import 'package:courtly_vendor/domain/usercases/verify_password_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/states/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ChangePasswordBloc] is used to manage the state of the change password screen
class ChangePasswordBloc extends Cubit<ChangePasswordState> {
  /// [verifyPasswordUsecase] is the usecase to verify the password
  final VerifyPasswordUsecase verifyPasswordUsecase;

  /// [changePasswordUsecase] is the usecase to change the password
  final ChangePasswordUsecase changePasswordUsecase;

  ChangePasswordBloc(
      {required this.verifyPasswordUsecase,
      required this.changePasswordUsecase})
      : super(ChangePasswordInitialState());

  /// [verifyCurrentPassword] is a method used to verify the current password
  Future<void> verifyCurrentPassword({required String currentPassword}) async {
    emit(ChangePasswordVerfyingState());

    /// [formDto] is the data transfer object for the password
    VerifyPasswordFormDTO formDto = VerifyPasswordFormDTO(
      password: currentPassword,
    );

    // Verify the password
    final Failure? failure =
        await verifyPasswordUsecase.verifyPassword(formDto: formDto);

    // Check if the response is not successful
    if (failure != null) {
      emit(ChangePasswordErrorState(errorMessage: failure.errorMessage));

      return;
    }

    emit(ChangePasswordVerifiedState());
  }

  /// [changePassword] is a method used to change the password
  ///
  /// Parameters:
  ///   - [oldPassword] is the old password
  ///   - [newPassword] is the new password
  ///   - [confirmPassword] is the confirm password
  ///
  /// Returns a [Future] of [void]
  Future<void> changePassword(
      {required oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    emit(ChangePasswordChangingState());

    // Create a new instance of [ChangePasswordFormDTO]
    final ChangePasswordFormDTO formDto = ChangePasswordFormDTO(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    // Change the password
    final Failure? failure =
        await changePasswordUsecase.changePassword(formDto: formDto);

    // Check if the response is not successful
    if (failure != null) {
      emit(ChangePasswordErrorState(errorMessage: failure.errorMessage));

      return;
    }

    emit(ChangePasswordSuccessState());
  }
}
