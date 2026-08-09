import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ScaleFactorSelector extends StatelessWidget {
  final int initialScale;
  final Function(int) onScaleChanged;

  const ScaleFactorSelector({
    super.key,
    this.initialScale = 2,
    required this.onScaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScaleOption(2),
        _buildScaleOption(4),
        _buildScaleOption(8),
      ],
    );
  }

  Widget _buildScaleOption(int scale) {
    final bool isSelected = initialScale == scale;

    return GestureDetector(
      onTap: () => onScaleChanged(scale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          '${scale}x',
          style: AppTypography.bodyMd.copyWith(
            color: isSelected
                ? AppColors.onPrimary
                : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
