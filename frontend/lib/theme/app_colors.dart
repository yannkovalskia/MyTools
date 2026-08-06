import 'package:flutter/material.dart';

/// All color tokens from the Efficient Utility design system.
/// Sourced from DESIGN.md color palette.
class AppColors {
  AppColors._();

  // ── Primary ──────────────────────────────────────────────
  static const Color primary = Color(0xFF004AC6);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF2563EB);
  static const Color onPrimaryContainer = Color(0xFFEEEFFF);
  static const Color inversePrimary = Color(0xFFB4C5FF);

  // ── Secondary ────────────────────────────────────────────
  static const Color secondary = Color(0xFF505F76);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD0E1FB);
  static const Color onSecondaryContainer = Color(0xFF54647A);

  // ── Tertiary ─────────────────────────────────────────────
  static const Color tertiary = Color(0xFF943700);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBC4800);
  static const Color onTertiaryContainer = Color(0xFFFFEDE6);

  // ── Error ────────────────────────────────────────────────
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // ── Surface ──────────────────────────────────────────────
  static const Color surface = Color(0xFFF8F9FB);
  static const Color surfaceDim = Color(0xFFD9DADC);
  static const Color surfaceBright = Color(0xFFF8F9FB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF3F4F6);
  static const Color surfaceContainer = Color(0xFFEDEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE7E8EA);
  static const Color surfaceContainerHighest = Color(0xFFE1E2E4);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF434655);
  static const Color inverseSurface = Color(0xFF2E3132);
  static const Color inverseOnSurface = Color(0xFFF0F1F3);
  static const Color surfaceTint = Color(0xFF0053DB);

  // ── Outline ──────────────────────────────────────────────
  static const Color outline = Color(0xFF737686);
  static const Color outlineVariant = Color(0xFFC3C6D7);

  // ── Background (alias for surface) ──────────────────────
  static const Color background = Color(0xFFF8F9FB);
  static const Color onBackground = Color(0xFF191C1E);

  // ── Fixed colors ─────────────────────────────────────────
  static const Color primaryFixed = Color(0xFFDBE1FF);
  static const Color primaryFixedDim = Color(0xFFB4C5FF);
  static const Color onPrimaryFixed = Color(0xFF00174B);
  static const Color onPrimaryFixedVariant = Color(0xFF003EA8);

  static const Color secondaryFixed = Color(0xFFD3E4FE);
  static const Color secondaryFixedDim = Color(0xFFB7C8E1);
  static const Color onSecondaryFixed = Color(0xFF0B1C30);
  static const Color onSecondaryFixedVariant = Color(0xFF38485D);

  static const Color tertiaryFixed = Color(0xFFFFDBCD);
  static const Color tertiaryFixedDim = Color(0xFFFFB596);
  static const Color onTertiaryFixed = Color(0xFF360F00);
  static const Color onTertiaryFixedVariant = Color(0xFF7D2D00);

  // ── Semantic shortcuts from DESIGN.md ────────────────────
  /// Action Blue – primary interactive elements
  static const Color actionBlue = primary;

  /// Utility Gray – base application background
  static const Color utilityGray = surfaceContainerLow; // #F3F4F6

  /// Card / container background
  static const Color cardWhite = surfaceContainerLowest; // #FFFFFF

  /// Standard border color (1px depth)
  static const Color border = Color(0xFFE5E7EB);

  /// Progress bar track
  static const Color progressTrack = border; // #E5E7EB

  /// Progress bar fill
  static const Color progressFill = primaryContainer; // #2563EB

  // ── Surface variant alias ────────────────────────────────
  static const Color surfaceVariant = Color(0xFFE1E2E4);
}
