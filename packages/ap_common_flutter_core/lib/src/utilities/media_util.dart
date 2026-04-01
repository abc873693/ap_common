import 'package:ap_common_core/injector.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';

sealed class SaveImageResult {
  const SaveImageResult();
}

class SaveImageSuccess extends SaveImageResult {
  const SaveImageSuccess(this.filePath);
  final String filePath;
}

class SaveImageError extends SaveImageResult {
  const SaveImageError(this.message);
  final String message;
}

abstract class MediaUtil {
  static MediaUtil get instance => injector.get<MediaUtil>();

  Future<XFile?> pickImage();

  Future<SaveImageResult> saveImage({
    required ByteData byteData,
    required String fileName,
  });
}
