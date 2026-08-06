import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A dashed-border upload area used in the Upscaler and Background Remover
/// screens.
///
/// Displays a dashed border (using a custom painter), a centered icon,
/// primary text, secondary text, and an optional action button.
class DashedUploadArea extends StatelessWidget {
  const DashedUploadArea({
    super.key,
    required this.icon,
    required this.primaryText,
    required this.secondaryText,
    this.onTap,
    this.buttonLabel,
    this.height = 180,
  });

  final IconData icon;
  final String primaryText;
  final String secondaryText;
  final VoidCallback? onTap;

  /// If provided, renders a small Action Blue button below the text.
  final String? buttonLabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.outlineVariant,
          radius: AppRadius.lg,
          strokeWidth: 1.5,
          dashWidth: 6,
          dashSpace: 4,
        ),
        child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: AppColors.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                primaryText,
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                secondaryText,
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (buttonLabel != null) ...[
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                  child: Text(
                    buttonLabel!,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Paints a dashed rounded-rectangle border.
class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final nextDash = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(
            distance,
            nextDash > metric.length ? metric.length : nextDash,
          ),
          paint,
        );
        distance = nextDash + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      radius != oldDelegate.radius ||
      strokeWidth != oldDelegate.strokeWidth;
}
