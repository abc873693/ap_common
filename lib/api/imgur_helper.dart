import 'dart:async';
import 'package:ap_common/models/imgur_upload_response.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:path/path.dart' as p;

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

export 'package:ap_common/callback/general_callback.dart';
export 'package:ap_common/models/announcement_login_data.dart';

class ImgurHelper {
  static const String clientId = 'bf8e32144d00b04';

  static ImgurHelper? _instance;

  late Dio dio;

  static ImgurHelper? get instance {
    return _instance ??= ImgurHelper();
  }

  ImgurHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.imgur.com',
      ),
    );
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
            ? imgurUploadResponse.data
            : callback.onSuccess(imgurUploadResponse.data);
      } else {
        return callback == null
            ? null
            : callback.onError(
                GeneralResponse(
                  statusCode: 201,
                  message: response.statusMessage ??
                      ApLocalizations.current.unknownError,
                ),
              );
      }
    } on DioError catch (dioError) {
      if (dioError.type == DioErrorType.response &&
          dioError.response?.statusCode == 400)
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
