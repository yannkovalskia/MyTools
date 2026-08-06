import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A download item tile used in the Video Downloader "Recent Downloads" list.
///
/// Shows a thumbnail placeholder on the left, title, metadata (format, quality,
/// size), and either a progress bar (for in-progress downloads) or a completed
/// status icon.
class DownloadItemTile extends StatelessWidget {
  const DownloadItemTile({
    super.key,
    required this.title,
    required this.metadata,
    this.thumbnailColor,
    this.duration,
    this.progress,
    this.isDownloading = false,
    this.onCancel,
  });

  /// Video title.
  final String title;

  /// Metadata line, e.g. "MP4 • 1080p • 45MB".
  final String metadata;

  /// Placeholder color for the thumbnail area.
  final Color? thumbnailColor;

  /// Video duration label, e.g. "10:24".
  final String? duration;

  /// Download progress from 0.0 to 1.0. Shown only when [isDownloading].
  final double? progress;

  /// Whether a download is in progress.
  final bool isDownloading;

  /// Called when the cancel button is pressed on an active download.
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          // ── Thumbnail ──────────────────────────────────
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: thumbnailColor ?? AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppRadius.base),
            ),
            child: Stack(
              children: [
                if (duration != null)
                  Positioned(
                    left: 4,
                    bottom: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        duration!,
                        style: AppTypography.labelSm.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // ── Info section ───────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),

                if (isDownloading && progress != null) ...[
                  // Downloading state
                  Row(
                    children: [
                      Text(
                        'Downloading...',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(progress! * 100).toInt()}%',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: AppColors.progressTrack,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.progressFill,
                      ),
                    ),
                  ),
                ] else ...[
                  // Completed state
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 14,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          metadata,
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // ── Cancel button (only when downloading) ──────
          if (isDownloading)
            IconButton(
              onPressed: onCancel,
              icon: const Icon(
                Icons.close,
                size: 20,
                color: AppColors.onSurfaceVariant,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
        ],
      ),
    );
  }
}
