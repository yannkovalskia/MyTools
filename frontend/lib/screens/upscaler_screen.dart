import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import '../services/api_service.dart';

class UpscalerScreen extends StatefulWidget {
  const UpscalerScreen({super.key});

  @override
  State<UpscalerScreen> createState() => _UpscalerScreenState();
}

class _UpscalerScreenState extends State<UpscalerScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  Uint8List? _processedImage;
  int _selectedScale = 2; // Default scale 2x

  // Fungsi untuk upload dan proses upscale
  Future<void> _pickAndProcessImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
        _processedImage = null;
      });

      File imageFile = File(pickedFile.path);

      // Kirim gambar dan nilai scale ke backend
      Uint8List? result = await ApiService.upscaleImage(
        imageFile,
        _selectedScale,
      );

      setState(() {
        _processedImage = result;
        _isLoading = false;
      });

      if (result == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal melakukan upscale. Cek koneksi server.'),
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
            'Image Upscaler',
            style: AppTypography.displayLg.copyWith(color: AppColors.onSurface),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Enhance image resolution up to 8x without losing quality.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Preview Card ───────────────────────────────
          SectionCard(
            title: 'PREVIEW',
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: CheckerboardBackground(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : _processedImage != null
                      ? Image.memory(_processedImage!, fit: BoxFit.contain)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_search,
                              size: 80,
                              color: AppColors.onSurfaceVariant.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Upscaled image preview',
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

          // ── Scale Selection Card ───────────────────────
          // Menonaktifkan pilihan scale saat sedang loading
          AbsorbPointer(
            absorbing: _isLoading,
            child: Opacity(
              opacity: _isLoading ? 0.5 : 1.0,
              child: SectionCard(
                title: 'SCALE FACTOR',
                child: ScaleFactorSelector(
                  initialScale: _selectedScale,
                  onScaleChanged: (scale) {
                    setState(() {
                      _selectedScale = scale;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Success State Card ─────────────────────────
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
                    'Image successfully upscaled to ${_selectedScale}x.',
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: 'Download PNG',
                    icon: Icons.download,
                    onPressed: () {
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

          // ── Upload Button ──────────────────────────────
          DashedUploadArea(
            icon: Icons.upload_file,
            primaryText: _processedImage == null && !_isLoading
                ? 'Upload Image'
                : 'Upload Another',
            secondaryText: 'Tap to browse gallery\n\nSupports JPG, PNG, WEBP',
            onTap: _isLoading ? null : _pickAndProcessImage,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
