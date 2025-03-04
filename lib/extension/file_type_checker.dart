import 'dart:typed_data';
import 'package:image/image.dart' as img;

extension FileTypeChecker on String {
  /// Danh sách các định dạng hình ảnh phổ biến
  static const List<String> _imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'webp',
    'svg'
  ];

  /// Danh sách các định dạng video phổ biến
  static const List<String> _videoExtensions = [
    'mp4',
    'mov',
    'avi',
    'mkv',
    'flv',
    'wmv',
    'webm'
  ];

  /// Danh sách các định dạng file phổ biến (hình ảnh + video + tài liệu)
  static const List<String> _fileExtensions = [
    ..._imageExtensions,
    ..._videoExtensions,
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
  bool get isImage => _hasExtension && _imageExtensions.contains(_extension);

  /// Kiểm tra có phải file video không
  bool get isVideo => _hasExtension && _videoExtensions.contains(_extension);

  /// Kiểm tra có phải là file hợp lệ không (có phần mở rộng và nằm trong danh sách)
  bool get isFile => _hasExtension && _fileExtensions.contains(_extension);

  /// Kiểm tra xem tên file có phần mở rộng hay không
  bool get _hasExtension => contains('.');

  /// Lấy phần mở rộng của file từ tên file (đã chuyển về chữ thường)
  String get _extension {
    if (!_hasExtension)
      return ''; // Nếu không có phần mở rộng, trả về chuỗi rỗng
    final parts = split('.');
    return parts.last.toLowerCase();
  }

  /// Kiểm tra xem Uint8List có phải là image không.
  static bool isImageByte(Uint8List bytes) {
    try {
      return img.decodeImage(bytes) != null;
    } catch (_) {
      return false;
    }
  }
}
