import 'dart:io';
import 'dart:typed_data';

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/crashlytics_utils.dart';
import 'package:ap_common/utils/toast.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:photo_manager/photo_manager.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:dio/dio.dart';
export 'package:path_provider/path_provider.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:image_picker/image_picker.dart';
export 'toast.dart';

class ApUtils {
  static bool get isSupportCacheNetworkImage =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

  static void showToast(BuildContext context, String message, {int gravity}) {
    Toast.show(
      message,
      context,
      duration: Toast.lengthShort,
      gravity: gravity ?? Toast.bottom,
      textStyle: TextStyle(
        color: ApTheme.of(context).toastText,
      ),
      backgroundColor: ApTheme.of(context).toastBackground,
    );
  }

  static pushCupertinoStyle(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }),
    );
  }

  static void handleDioError(BuildContext context, DioError dioError,
      {int gravity}) {
    switch (dioError.type) {
      case DioErrorType.DEFAULT:
        showToast(context, ApLocalizations.of(context).noInternet,
            gravity: gravity);
        break;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
        showToast(context, ApLocalizations.of(context).timeoutMessage,
            gravity: gravity);
        break;
      case DioErrorType.RESPONSE:
        showToast(context, dioError.message, gravity: gravity);
        break;
      case DioErrorType.CANCEL:
        break;
    }
  }

  static Future<void> launchUrl(var url) async {
    await launch(url);
  }

  static callPhone(String url) async {
    url = url.replaceAll('#', ',');
    url = url.replaceAll('(', '');
    url = url.replaceAll(')', '');
    url = url.replaceAll('-', '');
    url = url.replaceAll(' ', '');
    url = "tel:$url";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void shareTo(String content) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Share.share("$content\n\n"
        "Send from ${packageInfo.appName} ${Platform.operatingSystem}");
  }

  static Future<void> launchFbFansPage(
    BuildContext context,
    String fansPageId,
  ) async {
    final fansPageUrl = 'https://www.facebook.com/$fansPageId/';
    if (Platform.isAndroid)
      ApUtils.launchUrl('fb://messaging/$fansPageId')
          .catchError((onError) => ApUtils.launchUrl(fansPageUrl));
    else if (Platform.isIOS)
      ApUtils.launchUrl('fb-messenger://user-thread/$fansPageId')
          .catchError((onError) => ApUtils.launchUrl(fansPageUrl));
    else {
      ApUtils.launchUrl(fansPageUrl).catchError((onError) => ApUtils.showToast(
          context, ApLocalizations.of(context).platformError));
    }
  }

  static void showAppReviewDialog(
    BuildContext context,
    String defaultUrl,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    final app = ApLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: app.ratingDialogTitle,
        contentWidget: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                  color: ApTheme.of(context).grey, height: 1.3, fontSize: 16.0),
              children: [
                TextSpan(text: app.ratingDialogContent),
              ]),
        ),
        leftActionText: app.later,
        rightActionText: app.rateNow,
        leftActionFunction: null,
        rightActionFunction: () => openAppReview(defaultUrl: defaultUrl),
      ),
    );
  }

  static void showAppReviewSheet(
    BuildContext context,
    String defaultUrl,
  ) async {
    // await Future.delayed(Duration(seconds: 1));
    final app = ApLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Align(
              alignment: Alignment.center,
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
                    fontSize: 18.0),
                children: [
                  TextSpan(text: app.ratingDialogContent),
                ]),
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
                      color: ApTheme.of(context).blue, fontSize: 16.0),
                ),
              ),
              TextButton(
                onPressed: () => openAppReview(defaultUrl: defaultUrl),
                child: Text(
                  app.rateNow,
                  style: TextStyle(
                      color: ApTheme.of(context).blue, fontSize: 16.0),
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
    } else
      launchUrl(defaultUrl);
  }

  static Future<PickedFile> pickImage({
    ImageSource imageSource,
    CameraDevice preferredCameraDevice,
    List<String> extensions,
  }) async {
    PickedFile image;
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      final imagePicker = ImagePicker();
      image = await imagePicker.getImage(
        source: imageSource ?? ImageSource.gallery,
        preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear,
      );
    } else {
      final typeGroup = XTypeGroup(
        label: 'images',
        extensions: extensions ?? ['jpg', 'jpeg'],
      );
      final file = await openFile(acceptedTypeGroups: [typeGroup]);
      if (file != null) image = PickedFile(file.path);
    }
    return image;
  }

  static Future<void> saveImage(
    BuildContext context,
    ByteData byteData,
    String fileName,
    String successMessage,
  ) async {
    final ap = ApLocalizations.of(context);
    try {
      bool hasGrantPermission = true;
      if (kIsWeb) {
      } else if (Platform.isAndroid || Platform.isIOS) {
        hasGrantPermission = await PhotoManager.requestPermission();
      }
      if (hasGrantPermission) {
        final pngBytes = byteData.buffer.asUint8List();
        var downloadDir = '';
        if (kIsWeb)
          downloadDir = '';
        else if (Platform.isMacOS)
          downloadDir = (await getDownloadsDirectory()).path;
        else
          downloadDir = '';
        print(downloadDir);
        final filePath = path.join(downloadDir, '$fileName.png');
        bool success = true;
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          final AssetEntity imageEntity = await PhotoManager.editor.saveImage(
            pngBytes,
            title: fileName,
          );
          if (kDebugMode) print(imageEntity.title);
          success = imageEntity != null;
        } else {
          await File(filePath).writeAsBytes(pngBytes);
        }
        ApUtils.showToast(context, success ? successMessage : ap.unknownError);
      } else
        ApUtils.showToast(context, ap.grandPermissionFail);
    } catch (e, s) {
      ApUtils.showToast(context, ap.unknownError);
      if (CrashlyticsUtils.instance == null)
        throw e;
      else
        CrashlyticsUtils.instance?.recordError(e, s);
    }
  }

  static var overlayEntry;

  static showOverlay(BuildContext context, String text) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(text: text),
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  static removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }
}

class InputDoneView extends StatelessWidget {
  final String text;

  const InputDoneView({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.only(right: 12.0, top: 8.0, bottom: 8.0),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ApTheme.of(context).blue,
            ),
          ),
        ),
      ),
    );
  }
}
