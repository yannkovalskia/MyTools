/// Spacing tokens from the Efficient Utility design system.
///
/// Based on a 4px baseline grid as specified in DESIGN.md.
class AppSpacing {
  AppSpacing._();

  /// 4px – base unit / xs
  static const double base = 4.0;

  /// 4px – extra-small
  static const double xs = 4.0;

  /// 8px – small
  static const double sm = 8.0;

  /// 16px – medium (standard card padding, side margins)
  static const double md = 16.0;

  /// 24px – large (section separation)
  static const double lg = 24.0;

  /// 32px – extra-large (distinct section separation)
  static const double xl = 32.0;

  /// 16px – gutter between columns
  static const double gutter = 16.0;

  /// 16px – mobile screen margin
  static const double marginMobile = 16.0;

  /// 32px – desktop screen margin
  static const double marginDesktop = 32.0;
}

/// Border radius tokens from the Efficient Utility design system.
class AppRadius {
  AppRadius._();

  /// 2px – sm
  static const double sm = 2.0;

  /// 4px – default (buttons, inputs)
  static const double base = 4.0;

  /// 6px – md
  static const double md = 6.0;

  /// 8px – lg (tool cards)
  static const double lg = 8.0;

  /// 12px – xl
  static const double xl = 12.0;

  /// 9999px – fully rounded (pill shapes, progress bars)
  static const double full = 9999.0;
}
