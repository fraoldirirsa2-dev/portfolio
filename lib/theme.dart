import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF05060A);
  static const bgSoft = Color(0xFF0B0F1A);
  static const card = Color(0xFF0F1421);
  static const border = Color(0xFF1E2636);
  static const primary = Color(0xFF7C5CFF);
  static const primarySoft = Color(0xFF9B84FF);
  static const accent = Color(0xFF23D5AB);
  static const accent2 = Color(0xFFFF6B9D);
  static const text = Color(0xFFF4F6FB);
  static const muted = Color(0xFF8A94A7);
}

class Gradients {
  static const primary = LinearGradient(
    colors: [Color(0xFF7C5CFF), Color(0xFF23D5AB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const hero = LinearGradient(
    colors: [Color(0xFF7C5CFF), Color(0xFFFF6B9D), Color(0xFF23D5AB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

bool hasAmharic(String text) {
  for (final rune in text.runes) {
    if (rune >= 0x1200 && rune <= 0x137F) return true;
  }
  return false;
}

ThemeData buildTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  final interTheme = GoogleFonts.interTextTheme(base.textTheme);

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.card,
    ),
    textTheme: interTheme.apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        AppColors.primary.withValues(alpha: 0.4),
      ),
      thickness: WidgetStateProperty.all(6),
      radius: const Radius.circular(999),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgSoft.withValues(alpha: 0.6),
      hintStyle: GoogleFonts.inter(color: AppColors.muted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
      ),
    ),
  );
}

TextStyle displayFont({
  double size = 48,
  FontWeight weight = FontWeight.w700,
  Color color = AppColors.text,
  double height = 1.1,
  double letterSpacing = -1.5,
  String? text,
}) {
  if (text != null && hasAmharic(text)) {
    return GoogleFonts.notoSansEthiopic(
      fontSize: size * 0.88,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: 0,
    );
  }
  return GoogleFonts.spaceGrotesk(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

TextStyle bodyFont({
  double size = 15,
  FontWeight weight = FontWeight.w400,
  Color color = AppColors.muted,
  double height = 1.6,
  String? text,
}) {
  if (text != null && hasAmharic(text)) {
    return GoogleFonts.notoSansEthiopic(
      fontSize: size + 1,
      fontWeight: weight,
      color: color,
      height: height + 0.15,
    );
  }
  return GoogleFonts.inter(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );
}
