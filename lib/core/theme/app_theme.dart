import 'package:flutter/material.dart';

/// Design tokens from the mobile design brief, section 4. Screens read colours and spacing from here only.
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.primaryTint, required this.secondaryText, required this.border, required this.information,
    required this.success, required this.warning, required this.highYield});

  final Color primaryTint;
  final Color secondaryText;
  final Color border;
  final Color information;
  final Color success;
  final Color warning;
  /// Reserved for Exam High-Yield.
  final Color highYield;

  static const light = AppColors(primaryTint: Color(0xFFECFDF9), secondaryText: Color(0xFF526174), border: Color(0xFFDCE3E8),
      information: Color(0xFF2563EB), success: Color(0xFF15803D), warning: Color(0xFFD97706), highYield: Color(0xFF7C3AED));
  static const dark = AppColors(primaryTint: Color(0xFF123B38), secondaryText: Color(0xFFB8C4CF), border: Color(0xFF304152),
      information: Color(0xFF60A5FA), success: Color(0xFF4ADE80), warning: Color(0xFFFBBF24), highYield: Color(0xFFC4B5FD));

  @override
  AppColors copyWith() => this;
  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) => other is AppColors && t >= 0.5 ? other : this;
}

extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get scheme => Theme.of(this).colorScheme;
}

/// 4 px grid.
abstract final class Space {
  static const xs = 4.0, sm = 8.0, md = 12.0, lg = 16.0, xl = 24.0, xxl = 32.0;
}

abstract final class Radii {
  static const card = 12.0, control = 10.0;
}

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final tokens = dark ? AppColors.dark : AppColors.light;
  final ink = dark ? const Color(0xFFF3F7FA) : const Color(0xFF132238);
  final scheme = ColorScheme(
    brightness: brightness,
    primary: dark ? const Color(0xFF5EEAD4) : const Color(0xFF0F766E),
    onPrimary: dark ? const Color(0xFF0D1722) : Colors.white,
    secondary: tokens.information,
    onSecondary: Colors.white,
    error: dark ? const Color(0xFFF87171) : const Color(0xFFDC2626),
    onError: Colors.white,
    surface: dark ? const Color(0xFF162331) : Colors.white,
    onSurface: ink,
    outline: tokens.border,
  );
  final base = ThemeData(useMaterial3: true, colorScheme: scheme, scaffoldBackgroundColor: dark ? const Color(0xFF0D1722) : const Color(0xFFF5F7F9));
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.control));
  return base.copyWith(
    extensions: [tokens],
    // Sizes are logical pixels; Flutter applies the system text scale on top, so nothing here pins text size.
    textTheme: base.textTheme.copyWith(
      displaySmall: TextStyle(fontSize: 30, height: 36 / 30, fontWeight: FontWeight.w600, color: ink),
      headlineSmall: TextStyle(fontSize: 24, height: 30 / 24, fontWeight: FontWeight.w600, color: ink),
      titleMedium: TextStyle(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w600, color: ink),
      bodyLarge: TextStyle(fontSize: 16, height: 24 / 16, color: ink),
      bodyMedium: TextStyle(fontSize: 14, height: 20 / 14, color: tokens.secondaryText),
      labelMedium: TextStyle(fontSize: 13, height: 16 / 13, fontWeight: FontWeight.w500, color: tokens.secondaryText),
    ),
    appBarTheme: AppBarTheme(backgroundColor: scheme.surface, foregroundColor: ink, elevation: 0, scrolledUnderElevation: 0.5,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ink)),
    cardTheme: CardThemeData(color: scheme.surface, elevation: 0, margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.card), side: BorderSide(color: tokens.border))),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(minimumSize: const Size(48, 48), shape: shape,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
    outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48), shape: shape,
        side: BorderSide(color: tokens.border), foregroundColor: ink)),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(minimumSize: const Size(48, 48))),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: scheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Radii.control), borderSide: BorderSide(color: tokens.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Radii.control), borderSide: BorderSide(color: tokens.border))),
    dividerTheme: DividerThemeData(color: tokens.border, space: 1),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: scheme.surface, indicatorColor: tokens.primaryTint, elevation: 0),
  );
}
