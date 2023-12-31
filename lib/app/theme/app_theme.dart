import 'package:flutter/material.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallet.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallet.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallet.blueColor,
    ),
  );
}