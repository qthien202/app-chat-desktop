import 'dart:typed_data';
import 'package:image/image.dart' as img;

extension FileTypeChecker on String {
  /// Danh sách các định dạng hình ảnh phổ biến
  static final List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'webp',
    'svg'
  ];

  /// Danh sách các định dạng video phổ biến
  static final List<String> videoExtensions = [
    'mp4',
    'mov',
    'avi',
    'mkv',
    'flv',
    'wmv',
    'webm'
  ];

  /// Danh sách các định dạng file phổ biến (hình ảnh + video + tài liệu)
  static final List<String> fileExtensions = [
    ...imageExtensions,
    ...videoExtensions,
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'zip',
    'rar'
  ];

  /// Kiểm tra có phải file ảnh không
  bool get isImage => imageExtensions.contains(extension.toLowerCase());

  static bool isImageByte(Uint8List bytes) {
    try {
      return img.decodeImage(bytes) != null;
    } catch (e) {
      return false;
    }
  }

  /// Kiểm tra có phải file video không
  bool get isVideo => videoExtensions.contains(extension.toLowerCase());

  /// Kiểm tra có phải là file hợp lệ không (có phần mở rộng và nằm trong danh sách)
  bool get isFile =>
      contains('.') && fileExtensions.contains(extension.toLowerCase());

  /// Lấy phần mở rộng của file từ tên file
  String get extension {
    final parts = split('.');
    return (parts.length > 1) ? parts.last.toLowerCase() : '';
  }
}
