import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens from the Efficient Utility design system.
///
/// All styles use the Inter font family via Google Fonts.
/// Sizes, weights, line-heights, and letter-spacings are
/// taken directly from DESIGN.md.
class AppTypography {
  AppTypography._();

  // ── Display ──────────────────────────────────────────────

  /// display-lg: 32px / 700 / 40px line-height / -0.02em
  static TextStyle get displayLg => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 40 / 32, // lineHeight / fontSize
        letterSpacing: -0.02 * 32, // -0.02em
      );

  // ── Headlines ────────────────────────────────────────────

  /// headline-md: 24px / 600 / 32px / -0.01em
  static TextStyle get headlineMd => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        letterSpacing: -0.01 * 24,
      );

  /// headline-sm: 20px / 600 / 28px
  static TextStyle get headlineSm => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
      );

  /// headline-md-mobile: 20px / 600 / 28px
  /// Same metrics as headline-sm; provided as a semantic alias.
  static TextStyle get headlineMdMobile => headlineSm;

  // ── Body ─────────────────────────────────────────────────

  /// body-lg: 16px / 400 / 24px
  static TextStyle get bodyLg => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      );

  /// body-md: 14px / 400 / 20px  — the workhorse style
  static TextStyle get bodyMd => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      );

  // ── Labels ───────────────────────────────────────────────

  /// label-md: 12px / 600 / 16px / 0.05em
  static TextStyle get labelMd => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 16 / 12,
        letterSpacing: 0.05 * 12,
      );

  /// label-sm: 11px / 500 / 14px
  static TextStyle get labelSm => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 14 / 11,
      );
}
