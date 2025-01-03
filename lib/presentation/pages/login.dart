import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/blocs/auth_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/events/auth_event.dart';
import 'package:courtly_vendor/presentation/blocs/login_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/auth_state.dart';
import 'package:courtly_vendor/presentation/blocs/states/login_state.dart';
import 'package:courtly_vendor/presentation/validators/login_form_validator.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

/// [LoginPage] is page for /login route.
/// This page is used to login into existing account.
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  /// [_loginFormValidator] is the login form validator.
  final LoginFormValidator _loginFormValidator = LoginFormValidator();

  /// [_textInputControllers] is the map of text input keys.
  final Map<String, TextEditingController> _textInputControllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  /// [_errorTexts] is the map of error texts.
  /// This map is used to store the error texts for the text inputs.
  ///
  /// The keys are the text input keys and the values are the error texts.
  final Map<String, String?> _errorTexts = {
    "email": null,
    "password": null,
  };

  /// [_obsecureTextNotifier] is the notifier for obsecure text.
  /// This notifier is used to toggle the password visibility.
  final ValueNotifier<bool> _obsecureTextNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState authState) {
      return BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState loginState) {
            // Check the state of the login bloc.
            if (loginState is LoginErrorState) {
              // Check if the error message is a string.
              if (loginState.errorMessage is String) {
                // Show the error message in the snackbar.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(loginState.errorMessage),
                ));

                return;
              }

              // Check if the error message is a map.
              if (loginState.errorMessage is Map) {
                // Set the error text for the email.
                _errorTexts["email"] = loginState.errorMessage["email"]?.first;

                // Set the error text for the password.
                _errorTexts["password"] =
                    loginState.errorMessage["password"]?.first;
              }
            }

            // Check if the login is successful.
            if (loginState is LoginSuccessState) {
              context.read<AuthBloc>().add(CheckAuthEvent());
            }
          },
          builder: (BuildContext context, LoginState state) => Scaffold(
                backgroundColor: ColorSchemes.primaryBackground,
                body: SafeArea(
                  child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (BuildContext context, LoginState state) {
                    // Check the state of the login bloc.
                    if (state is LoginLoadingState) {
                      return const LoadingScreen();
                    }

                    // Create a reference to the login bloc.
                    LoginBloc controller = context.read<LoginBloc>();

                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PAGE_PADDING_MOBILE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: ColorSchemes.primary,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Signing into vendor account",
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
                                    controller: _textInputControllers["email"],
                                    style: const TextStyle(fontSize: 14),
                                    decoration: InputDecoration(
                                      label: const Text("Email"),
                                      errorText: _errorTexts["email"],
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 15),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                ValueListenableBuilder(
                                    valueListenable: _obsecureTextNotifier,
                                    builder: (BuildContext context,
                                        bool obsecureText, _) {
                                      return TextFormField(
                                        controller:
                                            _textInputControllers["password"],
                                        style: const TextStyle(fontSize: 14),
                                        obscureText: obsecureText,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          label: const Text("Password"),
                                          errorText: _errorTexts["password"],
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 15),
                                          suffixIcon: IconButton(
                                            icon: HeroIcon((obsecureText)
                                                ? HeroIcons.eyeSlash
                                                : HeroIcons.eye),
                                            iconSize: 16,
                                            onPressed: () {
                                              _obsecureTextNotifier.value =
                                                  !obsecureText;
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            )),
                            const SizedBox(height: 40),
                            PrimaryButton(
                              onPressed: () {
                                // Set the error texts for the email and password.
                                _errorTexts["email"] =
                                    _loginFormValidator.validateEmail(
                                        _textInputControllers["email"]!.text);

                                _errorTexts["password"] =
                                    _loginFormValidator.validatePassword(
                                        _textInputControllers["password"]!
                                            .text);

                                // Submit the login form.
                                controller.login(
                                  email: _textInputControllers["email"]!.text,
                                  password:
                                      _textInputControllers["password"]!.text,
                                );
                              },
                              style: ButtonStyle(
                                minimumSize: WidgetStateProperty.all(
                                    const Size.fromHeight(0)),
                              ),
                              child: const Text("Login"),
                            )
                          ],
                        ));
                  }),
                ),
              ));
    });
  }
}
