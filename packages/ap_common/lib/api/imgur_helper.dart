import 'dart:async';
import 'dart:typed_data';

import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:path/path.dart' as p;

export 'package:ap_common_core/ap_common_core.dart';

class ImgurHelper {
  ImgurHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.imgur.com',
      ),
    );
  }

  static ImgurHelper? get instance {
    return _instance ??= ImgurHelper();
  }

  late Dio dio;

  static const String clientId = 'bf8e32144d00b04';

  static ImgurHelper? _instance;

  Future<ImgurUploadData?> uploadImageToImgur({
    required XFile file,
    GeneralCallback<ImgurUploadData?>? callback,
  }) async {
    try {
      final Uint8List bytes = await file.readAsBytes();
      final Response<Map<String, dynamic>> response = await dio.post(
        '/3/image',
        options: Options(
          headers: <String, String>{
            'Authorization': 'Client-ID $clientId',
          },
        ),
        data: FormData.fromMap(
          <String, dynamic>{
            'image': MultipartFile.fromBytes(
              bytes,
              filename: p.split(file.path).last,
            ),
          },
        ),
      );
      if (response.statusCode == 200) {
        final ImgurUploadResponse imgurUploadResponse =
            ImgurUploadResponse.fromJson(response.data!);
        return callback == null
            ? imgurUploadResponse.data
            : callback.onSuccess(imgurUploadResponse.data) as ImgurUploadData;
      } else {
        callback?.onError(
          GeneralResponse(
            statusCode: 201,
            message:
                response.statusMessage ?? ApLocalizations.current.unknownError,
          ),
        );

        return null;
      }
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.badResponse &&
          dioException.response?.statusCode == 400) {
        callback?.onError(
          GeneralResponse(
            statusCode: 201,
            message: ApLocalizations.current.notSupportImageType,
          ),
        );
      } else {
        callback?.onFailure(dioException);
      }
      return null;
    }
  }
}
