import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [LoadingScreen] is a widget that displays a loading screen.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.label});

  /// [label] is the label for the loading screen.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorSchemes.primaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  label ?? "Loading...",
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        ));
  }
}
