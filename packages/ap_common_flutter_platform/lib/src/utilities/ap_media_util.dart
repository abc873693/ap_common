import 'dart:io';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final String filePath = '$fileName.png';
      if (!kIsWeb &&
          (Platform.isAndroid ||
              Platform.isIOS ||
              Platform.isMacOS ||
              Platform.isWindows)) {
        final String tempPath = path.join(
          (await getApplicationDocumentsDirectory()).path,
          filePath,
        );
        final File file =
            await File(tempPath).writeAsBytes(pngBytes);
        await Gal.putImage(file.path, album: 'AP');
        await file.delete();
        return SaveImageSuccess(filePath);
      } else {
        final String savedPath = await FileSaver.instance.saveFile(
          name: '$fileName.png',
          bytes: pngBytes,
        );
        return SaveImageSuccess(savedPath);
      }
    } on GalException catch (e, s) {
      CrashlyticsUtil.instance.recordError(e, s);
      return SaveImageError(e.type.message);
    } catch (e, s) {
      CrashlyticsUtil.instance.recordError(e, s);
      return SaveImageError(e.toString());
    }
  }
}
