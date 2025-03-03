import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

class AppUtils {
  AppUtils._();

  static Future<Uint8List> filePathToUint8List(String filePath) async {
    File file = File(filePath);
    return await file.readAsBytes();
  }

  static Future<Uint8List?> readBlobUrl(String blobUrl) async {
    try {
      final response = await html.HttpRequest.request(
        blobUrl,
        responseType: "arraybuffer",
      );
      return Uint8List.fromList(response.response as List<int>);
    } catch (e) {
      print("Lỗi tải Blob: $e");
      return null;
    }
  }
}
