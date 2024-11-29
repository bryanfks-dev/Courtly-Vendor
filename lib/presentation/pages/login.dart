import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/data/repository/api/login_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:courtly_vendor/domain/usercases/login_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/login_bloc.dart';
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
  LoginPage({super.key, required this.toAppScaffoldPage});

  /// [toAppScaffoldPage] is the callback to navigate to the app scaffold page.
  final VoidCallback toAppScaffoldPage;

  /// [_loginFormValidator] is the login form validator.
  final LoginFormValidator _loginFormValidator = LoginFormValidator();

  /// [_formKey] is the key for the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// [_textInputControllers] is the map of text input keys.
  final Map<String, TextEditingController> _textInputControllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  /// [_obsecureTextNotifier] is the notifier for obsecure text.
  /// This notifier is used to toggle the password visibility.
  final ValueNotifier<bool> _obsecureTextNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginBloc(
            loginUsecase: LoginUsecase(
                loginRepository: LoginRepository(),
                tokenRepository: TokenRepository())),
        child: BlocConsumer<LoginBloc, LoginState>(
            listener: (BuildContext context, LoginState state) {
              // Check the state of the login bloc.
              if (state is LoginErrorState) {
                if (state.errorMessage is String) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                  ));

                  return;
                }
              }

              if (state is LoginSuccessState) {
                toAppScaffoldPage();
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
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          controller:
                                              _textInputControllers["email"],
                                          style: const TextStyle(fontSize: 14),
                                          decoration: const InputDecoration(
                                            label: Text("Email"),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 15),
                                          ),
                                          validator: (String? value) =>
                                              _loginFormValidator
                                                  .validateEmail(value)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable:
                                              _obsecureTextNotifier,
                                          builder: (BuildContext context,
                                              bool obsecureText, _) {
                                            return TextFormField(
                                              controller: _textInputControllers[
                                                  "password"],
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              obscureText: obsecureText,
                                              enableSuggestions: false,
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                label: const Text("Password"),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 15),
                                                suffixIcon: IconButton(
                                                  icon: HeroIcon((obsecureText)
                                                      ? HeroIcons.eyeSlash
                                                      : HeroIcons.eye),
                                                  iconSize: 16,
                                                  onPressed: () {
                                                    _obsecureTextNotifier
                                                        .value = !obsecureText;
                                                  },
                                                ),
                                              ),
                                              validator: (String? value) =>
                                                  _loginFormValidator
                                                      .validatePassword(value),
                                            );
                                          }),
                                    ],
                                  )),
                              const SizedBox(height: 40),
                              PrimaryButton(
                                onPressed: () {
                                  // Validate the form.
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  print("Heelo");

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
                )));
  }
}
