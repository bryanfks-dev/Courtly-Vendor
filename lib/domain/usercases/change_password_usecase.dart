import 'dart:async';

import 'package:courtly_vendor/core/error/failure.dart';
import 'package:courtly_vendor/data/dto/change_password_form_dto.dart';
import 'package:courtly_vendor/data/dto/vendor_dto.dart';
import 'package:courtly_vendor/data/repository/api/change_password_repository.dart';
import 'package:dartz/dartz.dart';

/// [ChangePasswordUsecase] is a usecase class that is responsible for changing the password of the user.
class ChangePasswordUsecase {
  /// [changePasswordRepository] is the repository for changing the password.
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordUsecase({required this.changePasswordRepository});

  /// [changePassword] is a method used to change the password of the user.
  ///
  /// Parameters:
  ///   - [formDto] is the form data.
  ///
  /// Returns a [Failure] object.
  Future<Failure?> changePassword(
      {required ChangePasswordFormDTO formDto}) async {
    // Make a POST request to the API.
    final Either<Failure, VendorDTO> res =
        await changePasswordRepository.patchPassword(formDto: formDto);

    // Check if the request is not success
    return res.fold((l) => l, (r) => null);
  }
}
