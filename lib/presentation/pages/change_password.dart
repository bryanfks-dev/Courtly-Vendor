import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/blocs/change_password_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/change_password_state.dart';
import 'package:courtly_vendor/presentation/validators/change_password_form_validator.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:courtly_vendor/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

/// [ChangePasswordPage] is the page for changing password.
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  /// [_textInputControllers] is the register form controllers.
  /// This controllers is used to store the register form controllers.
  final Map<String, TextEditingController> _textInputControllers = {
    "oldPassword": TextEditingController(),
    "newPassword": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };

  /// [_changePasswordFormValidator] is the change password form validator.
  final ChangePasswordFormValidator _changePasswordFormValidator =
      ChangePasswordFormValidator();

  /// [_errorTexts] is the map of error texts.
  /// This map is used to store the error texts for the text inputs.
  final Map<String, String?> _errorTexts = {
    "oldPassword": null,
    "newPassword": null,
    "confirmPassword": null,
  };

  /// [_currentStep] is the current register step.
  /// This is set to 0 by default.
  int _currentStep = 0;

  /// [_nextStep] is a function to go to the next step.
  ///
  /// - Returns: void
  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  /// [_obsecurePassword] is a boolean to obsecure the password.
  /// This is set to true by default.
  bool _obsecurePassword = true;

  /// [_validateVerifyPasswordForm] is a function to validate the verify password form.
  ///
  /// Returns: bool
  bool _validateVerifyPasswordForm() {
    setState(() {
      // Set the error text for old password
      _errorTexts["oldPassword"] =
          _changePasswordFormValidator.validateOldPassword(
              oldPassword: _textInputControllers["oldPassword"]!.text);
    });

    return _errorTexts["oldPassword"] == null;
  }

  /// [_validateChangePasswordForm] is a function to validate the change password form.
  ///
  /// Returns: bool
  bool _validateChangePasswordForm() {
    setState(() {
      // Set the error text for new password
      _errorTexts["newPassword"] =
          _changePasswordFormValidator.validateNewPassword(
              newPassword: _textInputControllers["newPassword"]!.text);

      // Set the error text for confirm password
      _errorTexts["confirmPassword"] =
          _changePasswordFormValidator.validateConfirmPassword(
              newPassword: _textInputControllers["newPassword"]!.text,
              confirmPassword: _textInputControllers["confirmPassword"]!.text);
    });

    return _errorTexts["newPassword"] == null &&
        _errorTexts["confirmPassword"] == null;
  }

  @override
  Widget build(BuildContext context) {
    /// [controller] is the change password bloc.
    final ChangePasswordBloc controller =
        BlocProvider.of<ChangePasswordBloc>(context);

    /// [changePasswordSteps] is the list of steps for changing password.
    /// This list is used to store the steps of changing password.
    final List<Widget> changePasswordSteps = [
      BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (BuildContext context, ChangePasswordState state) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                        fontSize: 28,
                        color: ColorSchemes.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Please enter your current password to set a new one",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _textInputControllers["oldPassword"],
                          style: const TextStyle(fontSize: 14),
                          obscureText: _obsecurePassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            label: const Text("Current Password"),
                            errorText: _errorTexts["oldPassword"],
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            suffixIcon: IconButton(
                              icon: HeroIcon((_obsecurePassword)
                                  ? HeroIcons.eyeSlash
                                  : HeroIcons.eye),
                              iconSize: 16,
                              onPressed: () {
                                setState(() {
                                  _obsecurePassword = !_obsecurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            PrimaryButton(
                              onPressed: () {
                                // Validate the form
                                if (!_validateVerifyPasswordForm()) {
                                  return;
                                }

                                // Verify the current password
                                controller.verifyCurrentPassword(
                                    currentPassword:
                                        _textInputControllers["oldPassword"]!
                                            .text);
                              },
                              style: ButtonStyle(
                                minimumSize: WidgetStateProperty.all(
                                    const Size.fromHeight(0)),
                              ),
                              child: const Text("Check & Proceed"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SecondaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  minimumSize: WidgetStateProperty.all(
                                      const Size.fromHeight(0)),
                                ),
                                child: const Text("Cancel")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
      BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (BuildContext context, ChangePasswordState state) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                        fontSize: 28,
                        color: ColorSchemes.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Create a strong & unique password to keep your information safe!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            TextFormField(
                                controller:
                                    _textInputControllers["newPassword"],
                                style: const TextStyle(fontSize: 14),
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  label: const Text("New Password"),
                                  errorText: _errorTexts["newPassword"],
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller:
                                    _textInputControllers["confirmPassword"],
                                style: const TextStyle(fontSize: 14),
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  label: const Text("Confirm Password"),
                                  errorText: _errorTexts["confirmPassword"],
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            PrimaryButton(
                              onPressed: () {
                                // Validate the form
                                if (!_validateChangePasswordForm()) {
                                  return;
                                }

                                // Change the password
                                controller.changePassword(
                                    oldPassword:
                                        _textInputControllers["oldPassword"]!
                                            .text,
                                    newPassword:
                                        _textInputControllers["newPassword"]!
                                            .text,
                                    confirmPassword: _textInputControllers[
                                            "confirmPassword"]!
                                        .text);
                              },
                              style: ButtonStyle(
                                minimumSize: WidgetStateProperty.all(
                                    const Size.fromHeight(0)),
                              ),
                              child: const Text("Change"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SecondaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  minimumSize: WidgetStateProperty.all(
                                      const Size.fromHeight(0)),
                                ),
                                child: const Text("Cancel")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ))
    ];

    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (BuildContext context, ChangePasswordState state) {
      // Check states for errors.
      if (state is ChangePasswordErrorState) {
        // Check if the error message is a string.
        if (state.errorMessage is String) {
          // Show the error message in the snackbar.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));

          return;
        }

        // Check if the error message is a map.
        if (state.errorMessage is Map) {
          setState(() {
            // Set the error text for old password
            _errorTexts["oldPassword"] = state.errorMessage["password"]?.first;

            // Set the error text for new password
            _errorTexts["newPassword"] =
                state.errorMessage["new_password"]?.first;

            // Set the error text for confirm password
            _errorTexts["confirmPassword"] =
                state.errorMessage["confirm_password"]?.first;
          });
        }
      }

      // Check if the password is verified.
      if (state is ChangePasswordVerifiedState) {
        _nextStep();
      }

      // Check if the password is changed.
      if (state is ChangePasswordSuccessState) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password changed successfully!"),
        ));
      }
    }, builder: (BuildContext context, ChangePasswordState state) {
      return Scaffold(
          backgroundColor: ColorSchemes.primaryBackground,
          body: SafeArea(child:
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                  builder: (BuildContext context, ChangePasswordState state) {
            // Check the state.
            if (state is ChangePasswordVerfyingState ||
                state is ChangePasswordChangingState) {
              return const LoadingScreen();
            }

            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
                child: changePasswordSteps[_currentStep]);
          })));
    });
  }
}
