import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [CenteredAppBar] is a custom AppBar widget that is used as the AppBar
/// for the application that contains a centered title.
class CenteredAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CenteredAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(56);

  @override

  /// [preferredSize] is the preferred size of the AppBar.
  final Size preferredSize;

  /// [title] is the custom title of the AppBar.
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorSchemes.text,
        ),
        centerTitle: true,
        title: Text(title));
  }
}
