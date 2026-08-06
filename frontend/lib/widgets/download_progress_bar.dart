import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A pill-shaped progress bar matching the Efficient Utility design system.
///
/// Track: 6px height, #E5E7EB gray, fully rounded.
/// Fill: Action Blue (#2563EB), fully rounded.
/// Animates smoothly between [progress] values (0.0 → 1.0).
class DownloadProgressBar extends StatelessWidget {
  const DownloadProgressBar({
    super.key,
    required this.progress,
    this.height = 6.0,
    this.trackColor,
    this.fillColor,
  });

  /// Progress value from 0.0 to 1.0.
  final double progress;

  /// Height of the bar in logical pixels.
  final double height;

  /// Overrides the default track color.
  final Color? trackColor;

  /// Overrides the default fill color.
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            // Track
            Container(
              decoration: BoxDecoration(
                color: trackColor ?? AppColors.progressTrack,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
            // Fill
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: fillColor ?? AppColors.progressFill,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
