import 'package:ap_common/models/general_response.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

export 'package:dio/dio.dart';
export 'package:ap_common/models/general_response.dart';

class GeneralCallback {
  final Function(DioError e) onFailure;
  final Function(GeneralResponse e) onError;

  GeneralCallback({
    @required this.onFailure,
    @required this.onError,
  });

  static GeneralCallback simple(BuildContext context) {
    return GeneralCallback(
      onFailure: (DioError e) => ApUtils.handleDioError(context, e),
      onError: (GeneralResponse e) => ApUtils.showToast(context, e.message),
    );
  }
}
