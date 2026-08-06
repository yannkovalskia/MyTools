import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

/// Background Remover screen matching the removebg.png mockup.
///
/// Contains: title, checkerboard preview area with zoom controls,
/// success state card (with download/copy buttons), and a dashed
/// "Upload Another" card.
class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.lg),

          // ── Title ──────────────────────────────────────
          Text(
            'Background Remover',
            style: AppTypography.displayLg.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Instantly remove backgrounds from your images with one click.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Preview Card with Checkerboard ─────────────
          SectionCard(
            title: 'PREVIEW',
            titleAction: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _zoomButton(Icons.zoom_in),
                const SizedBox(width: AppSpacing.xs),
                _zoomButton(Icons.zoom_out),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: CheckerboardBackground(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Placeholder for the processed image
                      Icon(
                        Icons.headphones,
                        size: 80,
                        color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Processed image preview',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Success State Card ─────────────────────────
          Container(
            decoration: AppTheme.cardDecoration,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Success!',
                  style: AppTypography.headlineSm.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Background removed perfectly in 1.2s.',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Download PNG button
                PrimaryButton(
                  label: 'Download PNG',
                  icon: Icons.download,
                  onPressed: () {
                    // TODO: save processed image
                  },
                ),
                const SizedBox(height: AppSpacing.sm),

                // Copy to Clipboard button
                SecondaryButton(
                  label: 'Copy to Clipboard',
                  onPressed: () {
                    // TODO: copy image to clipboard
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Upload Another (Dashed) ────────────────────
          DashedUploadArea(
            icon: Icons.add_photo_alternate_outlined,
            primaryText: 'Upload Another',
            secondaryText: 'Drag & drop or click\n\nSupports JPG, PNG, WEBP',
            height: 170,
            onTap: () {
              // TODO: open file picker, then call ApiService.removeBackground()
            },
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  static Widget _zoomButton(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.base),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Icon(icon, size: 16, color: AppColors.onSurfaceVariant),
    );
  }
}
