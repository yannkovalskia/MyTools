import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import '../services/api_service.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  Uint8List? _processedImage;

  // Fungsi untuk membuka galeri, memilih foto, dan mengirim ke API
  Future<void> _pickAndProcessImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
        _processedImage = null; // Reset gambar sebelumnya jika ada
      });

      File imageFile = File(pickedFile.path);

      // Memanggil endpoint FastAPI dari api_service.dart
      Uint8List? result = await ApiService.removeBackground(imageFile);

      setState(() {
        _processedImage = result;
        _isLoading = false;
      });

      if (result == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal menghapus background. Cek koneksi server.'),
            ),
          );
        }
      }
    }
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
            'Background Remover',
            style: AppTypography.displayLg.copyWith(color: AppColors.onSurface),
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
                  // Logika Tampilan: Loading -> Hasil Gambar -> Placeholder
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : _processedImage != null
                      ? Image.memory(_processedImage!, fit: BoxFit.contain)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.headphones,
                              size: 80,
                              color: AppColors.onSurfaceVariant.withValues(
                                alpha: 0.5,
                              ),
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

          // ── Success State Card (Hanya muncul jika gambar berhasil diproses)
          if (_processedImage != null && !_isLoading) ...[
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
                    'Background removed perfectly.',
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  PrimaryButton(
                    label: 'Download PNG',
                    icon: Icons.download,
                    onPressed: () {
                      // TODO: Logika save ke galeri HP
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur download segera hadir!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],

          // ── Upload Another (Dashed) ────────────────────
          DashedUploadArea(
            icon: Icons.add_photo_alternate_outlined,
            primaryText: _processedImage == null && !_isLoading
                ? 'Upload Image'
                : 'Upload Another',
            secondaryText: 'Tap to browse gallery\n\nSupports JPG, PNG, WEBP',
            onTap: _isLoading
                ? null
                : _pickAndProcessImage, // Nonaktifkan tombol saat loading
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _zoomButton(IconData icon) {
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
