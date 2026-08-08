import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

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
  static Future<bool> downloadVideo(String url) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/download-video'),
      );
      request.fields['url'] = url;

      var response = await request.send();
      if (response.statusCode == 200) {
        // TODO: Logika untuk menyimpan file video ke memori HP (butuh package path_provider & permission_handler)
        debugPrint('Video siap didownload!');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Exception: $e');
      return false;
    }
  }
}
