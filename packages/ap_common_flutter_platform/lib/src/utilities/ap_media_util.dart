import 'dart:io';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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
  Future<void> saveImage(
    BuildContext context, {
    required ByteData byteData,
    required String fileName,
    required String successMessage,
    GeneralResponseCallback? onSuccess,
    GeneralResponseCallback? onError,
  }) async {
    final ApLocalizations ap = ApLocalizations.of(context);
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
        bool success = true;
        String filePath = '$fileName.png';
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          final String tempPath = path.join(
            (await getApplicationDocumentsDirectory()).path,
            filePath,
          );
          final File file = await File(tempPath).writeAsBytes(pngBytes);
          final AssetEntity? imageEntity =
              await PhotoManager.editor.saveImageWithPath(
            file.path,
            title: fileName,
          );
          file.delete();
          if (kDebugMode) debugPrint(imageEntity?.title);
          success = imageEntity != null;
        } else {
          filePath = await FileSaver.instance.saveFile(
            name: '$fileName.png',
            bytes: pngBytes,
          );
        }
        onSuccess?.call(
          success
              ? GeneralResponse(
                  statusCode: 200,
                  message: '$successMessage\n$filePath',
                )
              : GeneralResponse.unknownError(),
        );
      } else {
        onSuccess?.call(
          GeneralResponse(
            statusCode: 401,
            message: ap.grandPermissionFail,
          ),
        );
      }
    } catch (e, s) {
      if (!context.mounted) return;
      UiUtil.instance.showToast(context, ap.unknownError);
      if (CrashlyticsUtil.instance == null) {
        rethrow;
      } else {
        CrashlyticsUtil.instance?.recordError(e, s);
      }
    }
  }
}
