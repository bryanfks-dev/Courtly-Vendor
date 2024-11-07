import 'package:flutter/material.dart';

/// [ColorSchemes] class contains all the color schemes used in the app.
/// It is used to maintain the color schemes in one place.
///
/// Each color scheme must contains the following colors:
/// - [Primary] the primary color of the app
/// - [Text] the default color of the text
/// - [Subtle] the softer and more neutral color to use
/// - [Highlight] the bright and attention grabbing color
/// - [Success] the color to indicate success
/// - [Warning] the color to indicate warning
/// - [Danger] the color to indicate danger
/// - [Star] the color to indicate star
/// - [PrimaryBackground] the primary background color
/// - [SecondaryBackground] the secondary background color
class ColorSchemes {
  static Color primary = const Color(0xFF00BFB2);

  static Color text = const Color(0xFF000000);
  static Color subtle = const Color(0xFFD9D9D9);
  static Color highlight = const Color(0xFF757575);

  static Color success = const Color(0xFF4CAF50);
  static Color warning = const Color(0xFFFFCC00);
  static Color error = const Color(0xFFF44336);

  static Color star = const Color(0xFFFFD93D);

  static Color primaryBackground = const Color(0xFFFFFFFF);
  static Color secondaryBackground = const Color(0xFFF5F5F5);
}
