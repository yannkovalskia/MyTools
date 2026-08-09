import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  // Ganti dengan IPv4 laptopmu
  static const String baseUrl = 'http://192.168.100.8:8000';

  // 1. Endpoint Remove Background
  static Future<Uint8List?> removeBackground(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/remove-bg'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        return await response.stream
            .toBytes(); // Mengembalikan bytes gambar transparan
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }

  // 2. Endpoint Upscale Image
  static Future<Uint8List?> upscaleImage(File imageFile, int scale) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/upscale'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
      request.fields['scale'] = scale.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        return await response.stream
            .toBytes(); // Mengembalikan bytes gambar tajam
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }

  // 3. Endpoint Download Video (Masih berupa cetak biru dasar)
  // 3. Endpoint Download Video
  static Future<String?> downloadVideo(String url) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/download-video'),
      );
      request.fields['url'] = url;

      var response = await request.send();
      if (response.statusCode == 200) {
        // Dapatkan folder sementara di HP
        Directory tempDir = await getTemporaryDirectory();
        // Buat nama file unik
        String tempPath =
            '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
        File file = File(tempPath);

        // Tulis aliran data video ke file tersebut
        var bytes = await response.stream.toBytes();
        await file.writeAsBytes(bytes);

        // Kembalikan lokasi file-nya
        return tempPath;
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }
}
