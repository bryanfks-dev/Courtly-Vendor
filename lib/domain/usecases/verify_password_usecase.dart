import 'dart:async';

import 'package:courtly_vendor/core/errors/failure.dart';
import 'package:courtly_vendor/data/dto/verify_password_form_dto.dart';
import 'package:courtly_vendor/data/repository/api/verify_password_repository.dart';

class VerifyPasswordUsecase {
  /// [verifyPasswordRepository] is the repository for verifying the password.
  final VerifyPasswordRepository verifyPasswordRepository;

  VerifyPasswordUsecase({required this.verifyPasswordRepository});

  /// [verifyPassword] is a method used to verify the password.
  ///
  /// Parameters:
  ///   - [formDto] is the form data.
  ///
  /// Returns a [Failure] object.
  Future<Failure?> verifyPassword(
      {required VerifyPasswordFormDTO formDto}) async {
    // Make a POST request to the API.
    final Failure? res =
        await verifyPasswordRepository.postPassword(formDto: formDto);

    return res;
  }
}
