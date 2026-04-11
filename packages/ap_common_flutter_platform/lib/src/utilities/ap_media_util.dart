import 'dart:developer';
import 'dart:io';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class ApMediaUtil extends MediaUtil {
  @override
  Future<XFile?> pickImage() {
    final ImagePicker imagePicker = ImagePicker();
    return imagePicker.pickImage(
      source: ImageSource.gallery,
    );
  }

  @override
  Future<SaveImageResult> saveImage({
    required ByteData byteData,
    required String fileName,
  }) async {
    try {
      PermissionState hasGrantPermission = PermissionState.notDetermined;
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        hasGrantPermission = await PhotoManager.requestPermissionExtend();
      } else {
        hasGrantPermission = PermissionState.authorized;
      }
      if (hasGrantPermission == PermissionState.authorized ||
          hasGrantPermission == PermissionState.limited) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        String filePath = '$fileName.png';
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          final String tempPath = path.join(
            (await getApplicationDocumentsDirectory()).path,
            filePath,
          );
          final File file = await File(tempPath).writeAsBytes(pngBytes);
          final AssetEntity imageEntity =
              await PhotoManager.editor.saveImageWithPath(
            file.path,
            title: fileName,
          );
          file.delete();
          if (kDebugMode) log(imageEntity.title ?? '');
        } else {
          filePath = await FileSaver.instance.saveFile(
            name: '$fileName.png',
            bytes: pngBytes,
          );
        }
        return SaveImageSuccess(filePath);
      } else {
        return const SaveImageError('permission_denied');
      }
    } catch (e, s) {
      CrashlyticsUtil.instance.recordError(e, s);
      return SaveImageError(e.toString());
    }
  }
}
