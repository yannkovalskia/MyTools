import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import '../services/api_service.dart';
import 'package:gal/gal.dart';

class DownloaderScreen extends StatefulWidget {
  const DownloaderScreen({super.key});

  @override
  State<DownloaderScreen> createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  Future<void> _processDownload() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan URL video terlebih dahulu!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });

    // 1. Mengirim URL ke backend dan menerima path file dari memori HP
    String? videoPath = await ApiService.downloadVideo(url);

    if (videoPath != null) {
      try {
        // 2. Minta izin akses galeri
        bool hasAccess = await Gal.hasAccess();
        if (!hasAccess) {
          await Gal.requestAccess();
        }

        // 3. Simpan video dari folder sementara ke Galeri
        await Gal.putVideo(videoPath);

        setState(() {
          _isSuccess = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video berhasil disimpan ke Galeri')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan video ke galeri: $e')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengunduh video. Cek koneksi atau URL.'),
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

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
            'Video Downloader',
            style: AppTypography.displayLg.copyWith(color: AppColors.onSurface),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Download videos from YouTube, TikTok, IG, etc.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── URL Input Card ─────────────────────────────
          SectionCard(
            title: 'VIDEO URL',
            child: Column(
              children: [
                TextField(
                  controller: _urlController,
                  enabled: !_isLoading,
                  decoration: InputDecoration(
                    hintText: 'https://youtube.com/watch?v=...',
                    hintStyle: TextStyle(
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.base),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    prefixIcon: Icon(
                      Icons.link,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Tombol Download
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _processDownload,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.download),
                    label: Text(
                      _isLoading
                          ? 'Processing (Can take a while)...'
                          : 'Download Video',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.base),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Success State Card ─────────────────────────
          if (_isSuccess) ...[
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
                    'Video berhasil didownload dan disimpan ke galeri',
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
