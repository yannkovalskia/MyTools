import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ApiService {
  // IP LAN PC kamu — dipakai saat tes di HP fisik via USB/WiFi
  static const String _lanIp = '192.168.100.8';

  // 10.0.2.2 adalah alamat khusus Android emulator untuk akses localhost PC
  static const String _emulatorIp = '10.0.2.2';

  static const int _port = 8000;

  // Cache agar tidak cek device terus-terusan
  static String? _cachedBaseUrl;

  /// Otomatis pilih URL backend:
  /// - Emulator Android → 10.0.2.2 (host PC)
  /// - HP fisik         → 192.168.100.8 (IP LAN PC)
  static Future<String> getBaseUrl() async {
    if (_cachedBaseUrl != null) return _cachedBaseUrl!;

    bool isEmulator = false;
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        // isPhysicalDevice = false berarti ini emulator
        isEmulator = !androidInfo.isPhysicalDevice;
      }
    } catch (e) {
      debugPrint('device_info error: $e');
    }

    final ip = isEmulator ? _emulatorIp : _lanIp;
    _cachedBaseUrl = 'http://$ip:$_port';
    debugPrint('🔗 Backend URL: $_cachedBaseUrl (${isEmulator ? "emulator" : "physical device"})');
    return _cachedBaseUrl!;
  }

  // 1. Endpoint Remove Background
  static Future<Uint8List?> removeBackground(File imageFile) async {
    try {
      final baseUrl = await getBaseUrl();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/remove-bg'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      // Timeout 60 detik — remove-bg bisa makan waktu untuk gambar besar
      final response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () => throw Exception('Request timeout setelah 60 detik'),
      );

      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        debugPrint('Remove-bg Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Remove-bg Exception: $e');
      return null;
    }
  }

  // 2. Endpoint Upscale Image
  static Future<Uint8List?> upscaleImage(File imageFile, int scale) async {
    try {
      final baseUrl = await getBaseUrl();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/upscale'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
      request.fields['scale'] = scale.toString();

      // Timeout 60 detik
      final response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () => throw Exception('Request timeout setelah 60 detik'),
      );

      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        debugPrint('Upscale Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Upscale Exception: $e');
      return null;
    }
  }

  // 3. Endpoint Download Video
  static Future<String?> downloadVideo(String url) async {
    try {
      final baseUrl = await getBaseUrl();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/download-video'),
      );
      request.fields['url'] = url;

      // Timeout 120 detik — download video bisa sangat lama
      final response = await request.send().timeout(
        const Duration(seconds: 120),
        onTimeout: () => throw Exception('Download timeout setelah 120 detik'),
      );

      if (response.statusCode == 200) {
        // Simpan ke folder sementara di HP
        Directory tempDir = await getTemporaryDirectory();
        String tempPath =
            '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
        File file = File(tempPath);

        var bytes = await response.stream.toBytes();
        await file.writeAsBytes(bytes);

        return tempPath;
      } else {
        debugPrint('Download Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Download Exception: $e');
      return null;
    }
  }
}
