import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData myTheme = ThemeData(
  scaffoldBackgroundColor: ThemeColor.lightWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeColor.lightWhite,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  ),
  fontFamily: "Poppins",
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ThemeColor.primary,
    shape: const CircleBorder(),
    foregroundColor: ThemeColor.lightWhite,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: ThemeColor.lightWhite,
        backgroundColor: ThemeColor.button,
    ),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide.none,
    ),
    labelPadding: EdgeInsets.zero,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    side: BorderSide.none,
    backgroundColor: ThemeColor.mediumGrey,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const CircleBorder(),
      padding: EdgeInsets.zero,
      foregroundColor: ThemeColor.lightWhite,
    )
  ),
  useMaterial3: true,
);