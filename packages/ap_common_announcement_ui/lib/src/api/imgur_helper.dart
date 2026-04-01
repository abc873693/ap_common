import 'dart:async';
import 'dart:typed_data';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:path/path.dart' as p;

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

  Future<ApiResult<String>> uploadImage({
    required XFile file,
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
        final String? link = imgurUploadResponse.data?.link;
        if (link != null) {
          return ApiSuccess<String>(link);
        }
        return ApiError<String>(
          GeneralResponse(
            statusCode: 200,
            message: ap.unknownError,
          ),
        );
      } else {
        return ApiError<String>(
          GeneralResponse(
            statusCode: 201,
            message: response.statusMessage ?? ap.unknownError,
          ),
        );
      }
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.badResponse &&
          dioException.response?.statusCode == 400) {
        return ApiError<String>(
          GeneralResponse(
            statusCode: 201,
            message: ap.notSupportImageType,
          ),
        );
      } else {
        return ApiFailure<String>(dioException);
      }
    }
  }
}
