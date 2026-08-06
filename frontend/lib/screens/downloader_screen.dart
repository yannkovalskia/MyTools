import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

/// Video Downloader screen matching the vid_downloader.jpg mockup.
///
/// Contains: title, URL input, supported platform icons, Analyze Link button,
/// and a Recent Downloads list with progress bars.
class DownloaderScreen extends StatefulWidget {
  const DownloaderScreen({super.key});

  @override
  State<DownloaderScreen> createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  final _urlController = TextEditingController();

  // ── Dummy data matching the mockup ───────────────────────
  final List<_DownloadItem> _recentDownloads = [
    _DownloadItem(
      title: 'Coastal Drive - 4K Cinematic Ci...',
      metadata: 'MP4 • 1080p • 45MB',
      duration: '10:24',
      isDownloading: false,
      progress: 1.0,
      thumbnailColor: const Color(0xFFD4A574), // warm tone
    ),
    _DownloadItem(
      title: 'Mechanical Keyboard A...',
      metadata: 'Downloading...',
      duration: null,
      isDownloading: true,
      progress: 0.64,
      thumbnailColor: const Color(0xFF4A6FA5), // blue tone
    ),
    _DownloadItem(
      title: 'Handmade Pasta Masterclass',
      metadata: 'MP3 • Audio • 8MB',
      duration: '05:12',
      isDownloading: false,
      progress: 1.0,
      thumbnailColor: const Color(0xFFA67B5B), // brown tone
    ),
  ];

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.lg),

          // ── Title ──────────────────────────────────────
          Text(
            'Fetch Video',
            style: AppTypography.displayLg.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Paste a link to extract and download high-quality video formats.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── URL Input Card ─────────────────────────────
          Container(
            decoration: AppTheme.cardDecoration,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Video URL',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: 'https://...',
                    prefixIcon: const Icon(
                      Icons.link,
                      color: AppColors.onSurfaceVariant,
                      size: 20,
                    ),
                    hintStyle: AppTypography.bodyMd.copyWith(
                      color: AppColors.outlineVariant,
                    ),
                  ),
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Supported platforms
                Row(
                  children: [
                    Text(
                      'Supported:',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _platformIcon(Icons.smart_display_outlined),
                    const SizedBox(width: AppSpacing.sm),
                    _platformIcon(Icons.language),
                    const SizedBox(width: AppSpacing.sm),
                    _platformIcon(Icons.camera_alt_outlined),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Analyze Link button
                PrimaryButton(
                  label: 'Analyze Link',
                  icon: Icons.search,
                  onPressed: () {
                    // TODO: call ApiService.analyzeVideoLink(_urlController.text)
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── Recent Downloads Header ────────────────────
          Text(
            'Recent Downloads',
            style: AppTypography.headlineSm.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Download Items ─────────────────────────────
          ..._recentDownloads.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: DownloadItemTile(
                title: item.title,
                metadata: item.metadata,
                duration: item.duration,
                isDownloading: item.isDownloading,
                progress: item.progress,
                thumbnailColor: item.thumbnailColor,
                onCancel: item.isDownloading
                    ? () {
                        // TODO: cancel download
                      }
                    : null,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _platformIcon(IconData icon) {
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

class _DownloadItem {
  final String title;
  final String metadata;
  final String? duration;
  final bool isDownloading;
  final double progress;
  final Color? thumbnailColor;

  _DownloadItem({
    required this.title,
    required this.metadata,
    this.duration,
    this.isDownloading = false,
    this.progress = 0,
    this.thumbnailColor,
  });
}
