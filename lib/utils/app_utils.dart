import 'dart:io';
import 'dart:typed_data';
import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AppUtils {
  AppUtils._();

  static Future<Uint8List> filePathToUint8List(String filePath) async {
    File file = File(filePath);
    return await file.readAsBytes();
  }

  static Future<File> compressImage(File file) async {
    Configuration config = Configuration(
      outputType: ImageOutputType.jpg,
      // useJpgPngNativeCompressor: false,
      useJpgPngNativeCompressor: true,
      quality: 80,
    );

    final param = ImageFileConfiguration(
        input: ImageFile(
            filePath: Uri.file(file.path).toFilePath(),
            rawBytes: await file.readAsBytes()),
        config: config);
    final output = await compressor.compress(param);

    return File(output.filePath);
  }

  static Future<Uint8List> compressImageWeb(Uint8List imageByte) async {
    var imageCompress =
        await FlutterImageCompress.compressWithList(imageByte, quality: 80);
    return imageCompress;
  }

  static Future<String?> getVideoThumbnail(File file) async {
    final plugin = FcNativeVideoThumbnail();
    try {
      final tempDir = await getTemporaryDirectory();
      String thumbnailName = const Uuid().v4();
      String thumbnailPath = '${tempDir.path}/$thumbnailName.jpg';
      final thumbnail = await plugin.getVideoThumbnail(
          srcFile: file.path,
          destFile: thumbnailPath,
          width: 300,
          height: 300,
          format: 'jpeg',
          quality: 90);
      print(">>>>>>>thumbnailPath: $thumbnailPath");
      return thumbnailPath;
    } catch (e) {
      print(">>>>>>>error: $e");
    }
    return null;
  }

  static Future<Uint8List?> getVideoThumbnailWeb(File file) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    return uint8list;
  }
}
