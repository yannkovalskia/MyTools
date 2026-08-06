import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

/// Home screen matching the home.png mockup.
///
/// Contains: greeting, search bar, 3 tool cards, and a Recent Activity section.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onToolTap});

  /// Called with the tab index when a tool card is tapped,
  /// so the parent can switch the BottomNavigationBar.
  final ValueChanged<int>? onToolTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.lg),

          // ── Greeting ───────────────────────────────────
          Text(
            'Hello! What do you\nwant to do today?',
            style: AppTypography.displayLg.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Search Bar ─────────────────────────────────
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for tools...',
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.onSurfaceVariant,
              ),
              hintStyle: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Tool Cards ─────────────────────────────────
          ToolCard(
            icon: Icons.auto_fix_high,
            title: 'Remove Background',
            description:
                'Instantly isolate subjects from images with AI precision.',
            accentColor: AppColors.surfaceContainerHigh,
            onTap: () => onToolTap?.call(3), // Background tab
          ),
          const SizedBox(height: AppSpacing.sm),

          ToolCard(
            icon: Icons.download_rounded,
            title: 'Video Downloader',
            description:
                'Save high-quality videos from your favorite platforms.',
            accentColor:
                AppColors.primaryContainer.withValues(alpha: 0.15),
            onTap: () => onToolTap?.call(1), // Downloader tab
          ),
          const SizedBox(height: AppSpacing.sm),

          ToolCard(
            icon: Icons.photo_size_select_large_rounded,
            title: 'Image Upscaler',
            description:
                'Enhance resolution and clarity without losing detail.',
            accentColor:
                AppColors.tertiaryContainer.withValues(alpha: 0.12),
            onTap: () => onToolTap?.call(2), // Upscaler tab
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── Recent Activity ────────────────────────────
          Text(
            'Recent Activity',
            style: AppTypography.headlineSm.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Container(
            width: double.infinity,
            decoration: AppTheme.cardDecoration,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'No recent tools used.',
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
