import 'dart:async';
import 'package:ap_common/models/imgur_upload_response.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:path/path.dart' as p;

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

export 'package:ap_common/callback/general_callback.dart';
export 'package:ap_common/models/announcement_login_data.dart';

class ImgurHelper {
  static String? clientId;

  static ImgurHelper? _instance;
  static late BaseOptions options;
  static late Dio dio;

  static ImgurHelper get instance {
    return _instance ??= ImgurHelper();
  }

  ImgurHelper() {
    options = BaseOptions(
      baseUrl: 'https://api.imgur.com',
    );
    dio = Dio(options);
  }

  Future<ImgurUploadData> uploadImageToImgur({
    required PickedFile file,
    GeneralCallback<ImgurUploadData?>? callback,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      var response = await dio.post(
        "/3/image",
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
        data: FormData.fromMap(
          {
            "image": MultipartFile.fromBytes(
              bytes,
              filename: p.split(file.path).last,
            ),
          },
        ),
      );
      if (response.statusCode == 200) {
        final imgurUploadResponse = ImgurUploadResponse.fromJson(response.data);
        return callback == null
            ? imgurUploadResponse
            : callback.onSuccess(imgurUploadResponse.data);
      } else {
        return callback == null
            ? null
            : callback.onError(
                GeneralResponse(
                  statusCode: 201,
                  message: response.statusMessage,
                ),
              );
      }
    } on DioError catch (dioError) {
      if (dioError.type == DioErrorType.RESPONSE &&
          dioError.response.statusCode == 400)
        return callback == null
            ? null
            : callback.onError(
                GeneralResponse(
                  statusCode: 201,
                  message: ApLocalizations.current.notSupportImageType,
                ),
              );
      else
        return callback == null ? null : callback.onFailure(dioError);
    }
  }
}
