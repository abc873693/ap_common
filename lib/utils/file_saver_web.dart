import 'dart:async';
import 'dart:typed_data';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'package:universal_html/html.dart';

/// Reference: https://github.com/incrediblezayed/file_saver/blob/main/lib/file_saver_web.dart
/// A web implementation of the FileSaver plugin.
class FileSaverWeb {
  Future<bool> downloadFile(
    Uint8List bytes,
    String name,
    String type,
  ) async {
    bool success = false;
    try {
      final String url =
          Url.createObjectUrlFromBlob(Blob(<Uint8List>[bytes], type));
      final HtmlDocument htmlDocument = document;
      final AnchorElement anchor =
          htmlDocument.createElement('a') as AnchorElement;
      //ignore: unsafe_html
      anchor.href = url;
      anchor.style.display = name;
      anchor.download = name;
      document.body!.children.add(anchor);
      anchor.click();
      document.body!.children.remove(anchor);
      success = true;
    } catch (e) {
      rethrow;
    }
    return success;
  }
}
