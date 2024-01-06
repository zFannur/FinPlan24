import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

export 'app_colors.dart';
export 'app_icons.dart';
export 'app_text_style.dart';
export 'consts.dart';

final mainThemeData = ThemeData(
  fontFamily: 'Inter',
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    secondary: AppColors.orange,
    background: AppColors.black,
  ),
  scaffoldBackgroundColor: AppColors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.greyDark,
    titleTextStyle: AppTextStyle.bold24,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.greyDark,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.greyDark,
    selectedItemColor: AppColors.orange,
    unselectedItemColor: AppColors.grey,
  ),
);
