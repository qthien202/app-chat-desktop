import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

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
}
