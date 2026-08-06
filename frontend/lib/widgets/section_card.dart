import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A standard section card container used across all screens.
///
/// Wraps content in a white card with 1px border, 8px radius, and
/// 16px internal padding. Optionally shows a title header row.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.title,
    this.titleAction,
    this.padding,
  });

  /// Card content.
  final Widget child;

  /// Optional title label displayed at the top-left.
  final String? title;

  /// Optional widget displayed at the top-right of the title row
  /// (e.g. zoom icons, toggle buttons).
  final Widget? titleAction;

  /// Overrides the default 16px padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppTheme.cardDecoration,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                ?titleAction,
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          child,
        ],
      ),
    );
  }
}
