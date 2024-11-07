import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [SecondaryButton] is a secondary button used in the app.
/// It is a custom button with white background color and red border.
///
/// [SecondaryButton] takes [child] to display and [onPressed] function to be
/// called when button is pressed.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.style,
    required this.onPressed,
    required this.child,
  });

  /// [style] is the style of the button.
  final ButtonStyle? style;

  /// [onPressed] is the function to be called when button is pressed.
  final VoidCallback onPressed;

  /// [child] is the widget to be displayed inside the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              side: style?.side?.resolve({}) ??
                  BorderSide(width: 1, color: ColorSchemes.primary),
              padding: style?.padding?.resolve({}) ??
                  const EdgeInsets.symmetric(vertical: 12),
              foregroundColor: ColorSchemes.primary,
              shape: style?.shape?.resolve({}) ??
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.transparent)
          .merge(style),
      onPressed: onPressed,
      child: child,
    );
  }
}
