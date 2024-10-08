import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_core/src/callback/general_callback.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class MediaUtil {
  static MediaUtil get instance => injector.get<MediaUtil>();

  Future<XFile?> pickImage();

  Future<void> saveImage(
    BuildContext context, {
    required ByteData byteData,
    required String fileName,
    required String successMessage,
    GeneralResponseCallback? onSuccess,
    GeneralResponseCallback? onError,
  });
}
