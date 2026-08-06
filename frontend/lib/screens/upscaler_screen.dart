import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

/// Image Upscaler screen matching the img_upscaler.png mockup.
///
/// Contains: title, dashed source image upload area, 2x/4x/8x toggle,
/// Upscale Image button, and a Before/After preview area.
class UpscalerScreen extends StatefulWidget {
  const UpscalerScreen({super.key});

  @override
  State<UpscalerScreen> createState() => _UpscalerScreenState();
}

class _UpscalerScreenState extends State<UpscalerScreen> {
  String _selectedFactor = '4x';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.lg),

          // ── Title ──────────────────────────────────────
          Text(
            'Image Upscaler',
            style: AppTypography.displayLg.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Enhance resolution and clarity of your images using AI.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Source Image Card ───────────────────────────
          SectionCard(
            title: 'Source Image',
            child: DashedUploadArea(
              icon: Icons.upload_file_outlined,
              primaryText: 'Click to upload or drag and drop',
              secondaryText: 'PNG, JPG or WEBP (Max 5MB)',
              buttonLabel: 'Browse Files',
              height: 160,
              onTap: () {
                // TODO: open file picker, then call ApiService.upscaleImage()
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Upscale Factor Card ────────────────────────
          SectionCard(
            title: 'Upscale Factor',
            child: Column(
              children: [
                ScaleFactorSelector(
                  factors: const ['2x', '4x', '8x'],
                  selectedFactor: _selectedFactor,
                  onSelected: (factor) {
                    setState(() => _selectedFactor = factor);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  label: 'Upscale Image',
                  icon: Icons.auto_awesome,
                  onPressed: () {
                    // TODO: call ApiService.upscaleImage() with selected factor
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Preview Card ───────────────────────────────
          SectionCard(
            title: 'Preview',
            titleAction: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.compare,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Before / After',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadius.base),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_size_select_large_rounded,
                        size: 36,
                        color: AppColors.outlineVariant,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'No image uploaded yet.',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Upload an image to see the before and after\ncomparison here.',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
