import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A tool card matching the Home screen mockup.
///
/// White background, 1px border (#E5E7EB), 8px radius.
/// Contains a colored icon badge, title, and description.
/// An optional gradient accent overlay appears on the right side.
class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
    this.accentColor,
  });

  /// Icon displayed in the badge area.
  final IconData icon;

  /// Tool name (e.g. "Remove Background").
  final String title;

  /// Short description text.
  final String description;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Optional accent gradient color for the card's right-side decoration.
  /// Defaults to a subtle blue tint if null.
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? AppColors.primaryContainer.withValues(alpha: 0.15);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppTheme.cardDecoration,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // ── Accent gradient overlay on the right ──────
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accent,
                      accent.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),

            // ── Card content ─────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon badge
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Title
                  Text(
                    title,
                    style: AppTypography.headlineSm.copyWith(
                      color: AppColors.onSurface,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Description
                  Text(
                    description,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
