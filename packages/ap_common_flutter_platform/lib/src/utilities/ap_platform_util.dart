import 'dart:io';
import 'dart:ui';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ApPlatformUtil extends PlatformUtil {
  @override
  Future<void> launchUrl(String url) async {
    await url_launcher.launchUrl(Uri.parse(url));
  }

  @override
  Future<void> callPhone(String url) async {
    String newUrl = url.replaceAll('#', ',');
    newUrl = newUrl.replaceAll('(', '');
    newUrl = newUrl.replaceAll(')', '');
    newUrl = newUrl.replaceAll('-', '');
    newUrl = newUrl.replaceAll(' ', '');
    newUrl = 'tel:$newUrl';
    await url_launcher.launchUrl(Uri.parse(newUrl));
  }

  @override
  Future<void> shareTo(
    String content, {
    Rect? sharePositionOrigin,
  }) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Share.share(
      '$content\n\n'
      'Send from ${packageInfo.appName} ${Platform.operatingSystem}',
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}
