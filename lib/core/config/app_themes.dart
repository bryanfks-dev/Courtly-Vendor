import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [AppThemes] is a class that contains all the theme data for the application.
class AppThemes {
  // Light theme
  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: ColorSchemes.primary,
      textTheme: ThemeData.light().textTheme.apply(fontFamily: "Inter"),
      primaryTextTheme:
          ThemeData.light().primaryTextTheme.apply(fontFamily: "Inter"),
      chipTheme: ChipThemeData(
        labelStyle: TextStyle(
            color: ColorSchemes.highlight,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: "Inter"),
        secondaryLabelStyle: TextStyle(
            color: ColorSchemes.primaryBackground, fontWeight: FontWeight.w500),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return BorderSide(color: ColorSchemes.subtle);
          }

          return BorderSide(color: ColorSchemes.primary);
        }),
        color: WidgetStateColor.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return ColorSchemes.primaryBackground;
          }

          return ColorSchemes.primary;
        }),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor: ColorSchemes.subtle,
          color: ColorSchemes.primary,
          circularTrackColor: ColorSchemes.subtle),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: ColorSchemes.primaryBackground),
      inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: ColorSchemes.highlight,
          suffixIconColor: ColorSchemes.highlight,
          floatingLabelStyle:
              TextStyle(color: ColorSchemes.primary, fontFamily: "Inter"),
          labelStyle: TextStyle(
              color: ColorSchemes.highlight, fontSize: 14, fontFamily: "Inter"),
          hintStyle: TextStyle(
              color: ColorSchemes.highlight, fontSize: 14, fontFamily: "Inter"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.subtle),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.error),
          ),
          errorStyle: TextStyle(color: ColorSchemes.error),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.error),
          )),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(ColorSchemes.highlight),
        textStyle: const WidgetStatePropertyAll(TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Inter")),
      )),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            textStyle: WidgetStatePropertyAll(TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter"))),
      ),
      dividerTheme: DividerThemeData(color: ColorSchemes.subtle),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorSchemes.primaryBackground,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorSchemes.primaryBackground,
          selectedIconTheme: IconThemeData(
            color: ColorSchemes.primary,
          ),
          unselectedIconTheme: IconThemeData(
            color: ColorSchemes.highlight,
          )));
}
