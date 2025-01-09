import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

/// [TryAgainScreen] is a widget that will be shown when the user encounters
/// an error and wants to try again by pressing the try again button.
class TryAgainScreen extends StatelessWidget {
  const TryAgainScreen({super.key, required this.onTryAgain});

  /// [onTryAgain] is a function that will be called when the user presses
  /// the try again button
  final Function onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.png"),
              const SizedBox(height: 10),
              Text("Failed to load data",
                  style: TextStyle(
                      color: ColorSchemes.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              PrimaryButton(
                onPressed: () => onTryAgain(),
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16))),
                child: const Text("Try again",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          )),
    );
  }
}
