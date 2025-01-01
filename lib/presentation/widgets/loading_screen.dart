import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [LoadingScreen] is a widget that displays a loading screen.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.label});

  /// [label] is the label for the loading screen.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(label ?? 'Loading...',
              style: TextStyle(fontSize: 14, color: ColorSchemes.text)),
        ],
      ),
    );
  }
}
