import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A toggle selector for upscale factors (2x, 4x, 8x) used in the
/// Image Upscaler screen.
///
/// Displays a row of equally-sized selectable chips. The active chip gets
/// an Action Blue border and tinted background.
class ScaleFactorSelector extends StatelessWidget {
  const ScaleFactorSelector({
    super.key,
    required this.factors,
    required this.selectedFactor,
    required this.onSelected,
  });

  /// Available factor labels (e.g. ["2x", "4x", "8x"]).
  final List<String> factors;

  /// Currently selected factor label.
  final String selectedFactor;

  /// Called with the selected factor label.
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: factors.map((factor) {
        final isSelected = factor == selectedFactor;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: factor != factors.last ? AppSpacing.sm : 0,
            ),
            child: GestureDetector(
              onTap: () => onSelected(factor),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryContainer.withValues(alpha: 0.1)
                      : AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(AppRadius.base),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  factor,
                  style: AppTypography.bodyMd.copyWith(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : AppColors.onSurfaceVariant,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
