import 'dart:io';
import 'dart:typed_data';

import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/crashlytics_utils.dart';
import 'package:ap_common/utils/file_saver_web.dart';
import 'package:ap_common/utils/toast.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

export 'package:dio/dio.dart';
export 'package:image_picker/image_picker.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:path_provider/path_provider.dart';

export 'toast.dart';

class ApUtils {
  static bool get isSupportCacheNetworkImage =>
      kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

  static void showToast(
    BuildContext context,
    String? message, {
    int? gravity,
  }) {
    Toast.show(
      message,
      context,
      duration: Toast.lengthLong,
      gravity: gravity ?? Toast.bottom,
      textStyle: TextStyle(
        color: ApTheme.of(context).toastText,
      ),
      backgroundColor: ApTheme.of(context).toastBackground,
    );
  }

  static void pushCupertinoStyle(
    BuildContext context,
    Widget page,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }

  static Future<void> launchUrl(String url) async {
    await url_launcher.launchUrl(Uri.parse(url));
  }

  static Future<void> callPhone(String url) async {
    String newUrl = url.replaceAll('#', ',');
    newUrl = newUrl.replaceAll('(', '');
    newUrl = newUrl.replaceAll(')', '');
    newUrl = newUrl.replaceAll('-', '');
    newUrl = newUrl.replaceAll(' ', '');
    newUrl = 'tel:$newUrl';
    await url_launcher.launchUrl(Uri.parse(newUrl));
  }

  static Future<void> shareTo(String content) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Share.share(
      '$content\n\n'
      'Send from ${packageInfo.appName} ${Platform.operatingSystem}',
    );
  }

  static Future<void> launchFbFansPage(
    BuildContext context,
    String fansPageId,
  ) async {
    final String fansPageUrl = 'https://www.facebook.com/$fansPageId/';
    if (Platform.isAndroid) {
      ApUtils.launchUrl('fb://messaging/$fansPageId').catchError(
        (dynamic onError) => ApUtils.launchUrl(fansPageUrl),
      );
    } else if (Platform.isIOS) {
      ApUtils.launchUrl('fb-messenger://user-thread/$fansPageId').catchError(
        (dynamic onError) => ApUtils.launchUrl(fansPageUrl),
      );
    } else {
      ApUtils.launchUrl(fansPageUrl).catchError(
        (dynamic onError) => ApUtils.showToast(
          context,
          ApLocalizations.of(context).platformError,
        ),
      );
    }
  }

  static Future<void> showAppReviewDialog(
    BuildContext context,
    String defaultUrl,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final ApLocalizations app = ApLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: app.ratingDialogTitle,
        contentWidget: Text(
          app.ratingDialogContent,
          style: TextStyle(
            color: ApTheme.of(context).grey,
            height: 1.3,
            fontSize: 16.0,
          ),
        ),
        leftActionText: app.later,
        rightActionText: app.rateNow,
        rightActionFunction: () => openAppReview(defaultUrl: defaultUrl),
      ),
    );
  }

  static Future<void> showAppReviewSheet(
    BuildContext context,
    String defaultUrl,
  ) async {
    // await Future.delayed(Duration(seconds: 1));
    final ApLocalizations app = ApLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Align(
              child: Text(
                app.ratingDialogTitle,
                style:
                    TextStyle(color: ApTheme.of(context).blue, fontSize: 20.0),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: ApTheme.of(context).grey,
                height: 1.3,
                fontSize: 18.0,
              ),
              children: <TextSpan>[
                TextSpan(text: app.ratingDialogContent),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  app.later,
                  style: TextStyle(
                    color: ApTheme.of(context).blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => openAppReview(defaultUrl: defaultUrl),
                child: Text(
                  app.rateNow,
                  style: TextStyle(
                    color: ApTheme.of(context).blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Future<void> openAppReview({
    String defaultUrl = '',
  }) async {
    final InAppReview inAppReview = InAppReview.instance;
    if (!kIsWeb &&
        (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) &&
        (await inAppReview.isAvailable())) {
      inAppReview.requestReview();
    } else {
      launchUrl(defaultUrl);
    }
  }

  static Future<XFile?> pickImage({
    ImageSource? imageSource,
    CameraDevice? preferredCameraDevice,
    List<String>? extensions,
  }) async {
    XFile? image;
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      final ImagePicker imagePicker = ImagePicker();
      image = await imagePicker.pickImage(
        source: imageSource ?? ImageSource.gallery,
        preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear,
      );
    } else {
      final XTypeGroup typeGroup = XTypeGroup(
        label: 'images',
        extensions: extensions ?? <String>['jpg', 'jpeg'],
      );
      image = await openFile(
        acceptedTypeGroups: <XTypeGroup>[typeGroup],
      );
    }
    return image;
  }

  static Future<void> saveImage(
    BuildContext context,
    ByteData byteData,
    String fileName,
    String successMessage,
  ) async {
    final ApLocalizations ap = ApLocalizations.of(context);
    try {
      PermissionState hasGrantPermission = PermissionState.notDetermined;
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        hasGrantPermission = await PhotoManager.requestPermissionExtend();
      }
      if (hasGrantPermission == PermissionState.authorized) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        String downloadDir = '';
        if (kIsWeb) {
          downloadDir = '';
        } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
          downloadDir = (await getDownloadsDirectory())!.path;
        } else {
          downloadDir = '';
        }
        final String filePath = path.join(downloadDir, '$fileName.png');
        bool success = true;
        if (kIsWeb) {
          await FileSaverWeb().downloadFile(
            pngBytes,
            fileName,
            'image/png',
          );
        } else if (Platform.isAndroid || Platform.isIOS) {
          final AssetEntity? imageEntity = await PhotoManager.editor.saveImage(
            pngBytes,
            title: fileName,
          );
          if (kDebugMode) debugPrint(imageEntity?.title);
          success = imageEntity != null;
        } else {
          await File(filePath).writeAsBytes(pngBytes);
        }
        ApUtils.showToast(
          context,
          success ? '$successMessage\n$filePath' : ap.unknownError,
        );
      } else {
        ApUtils.showToast(
          context,
          ap.grandPermissionFail,
        );
      }
    } catch (e, s) {
      ApUtils.showToast(context, ap.unknownError);
      if (CrashlyticsUtils.instance == null) {
        rethrow;
      } else {
        CrashlyticsUtils.instance?.recordError(e, s);
      }
    }
  }
}
