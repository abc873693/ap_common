import 'dart:async';
import 'dart:typed_data';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';

class ImgbbHelper {
  ImgbbHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.imgbb.com/1',
        headers: <String, String>{
          'Accept': 'application/json',
          'User-Agent': 'Flutter App',
        },
      ),
    );
  }

  static ImgbbHelper? get instance {
    return _instance ??= ImgbbHelper();
  }

  late Dio dio;

  static const String apiKey = '20778f37dcc08538363199547e461796';

  static ImgbbHelper? _instance;

  Future<ApiResult<String>> uploadImage({
    required XFile file,
    DateTime? expireTime,
  }) async {
    try {
      final Uint8List bytes = await file.readAsBytes();
      final Response<Map<String, dynamic>> response = await dio.post(
        '/upload',
        data: FormData.fromMap(
          <String, dynamic>{
            'key': apiKey,
            'image': MultipartFile.fromBytes(
              bytes,
              filename: file.name,
            ),
            if (expireTime != null)
              'expiration': (expireTime.millisecondsSinceEpoch / 1000).round(),
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data?['data'] case final Map<String, dynamic> data?) {
          if (data['url'] case final String url?) {
            return ApiSuccess<String>(url);
          }
        }
        return ApiError<String>(
          GeneralResponse(
            statusCode: 500,
            message: ap.unknownError,
          ),
        );
      } else {
        return ApiError<String>(
          GeneralResponse(
            statusCode: 500,
            message: response.statusMessage ?? ap.unknownError,
          ),
        );
      }
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.badResponse &&
          dioException.response?.statusCode == 400) {
        return ApiError<String>(
          GeneralResponse(
            statusCode: 400,
            message: ap.notSupportImageType,
          ),
        );
      } else {
        return ApiFailure<String>(dioException);
      }
    }
  }
}
