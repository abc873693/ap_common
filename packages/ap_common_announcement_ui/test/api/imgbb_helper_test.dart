import 'dart:typed_data';

import 'package:ap_common_announcement_ui/src/api/imgbb_helper.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_mock_adapter/src/handlers/request_handler.dart';

void main() {
  late ImgbbHelper helper;
  late DioAdapter dioAdapter;

  setUp(() {
    helper = ImgbbHelper();
    dioAdapter = DioAdapter(dio: helper.dio);
  });

  group('ImgbbHelper constants', () {
    test('apiKey should be set', () {
      expect(ImgbbHelper.apiKey, isNotEmpty);
    });

    test('base URL should be imgbb API', () {
      expect(helper.dio.options.baseUrl, 'https://api.imgbb.com/1');
    });
  });

  group('uploadImage', () {
    test('returns ApiSuccess with URL on 200', () async {
      dioAdapter.onPost(
        '/upload',
        (MockServer server) => server.reply(
          200,
          <String, dynamic>{
            'data': <String, dynamic>{
              'url': 'https://i.ibb.co/test.png',
            },
            'success': true,
            'status': 200,
          },
        ),
        data: Matchers.any,
      );

      final ApiResult<String> result = await helper.uploadImage(
        file: XFile.fromData(
          Uint8List.fromList(<int>[0, 1, 2]),
          name: 'test.png',
          path: '/test.png',
        ),
      );
      expect(result, isA<ApiSuccess<String>>());
      expect(
        (result as ApiSuccess<String>).data,
        'https://i.ibb.co/test.png',
      );
    });

    test('returns ApiError when data has no url', () async {
      dioAdapter.onPost(
        '/upload',
        (MockServer server) => server.reply(
          200,
          <String, dynamic>{
            'data': <String, dynamic>{
              'other': 'value',
            },
            'success': true,
            'status': 200,
          },
        ),
        data: Matchers.any,
      );

      final ApiResult<String> result = await helper.uploadImage(
        file: XFile.fromData(
          Uint8List.fromList(<int>[0, 1, 2]),
          name: 'test.png',
          path: '/test.png',
        ),
      );
      expect(result, isA<ApiError<String>>());
    });

    test('returns ApiError on 400 bad request', () async {
      dioAdapter.onPost(
        '/upload',
        (MockServer server) => server.throws(
          400,
          DioException(
            requestOptions: RequestOptions(path: '/upload'),
            type: DioExceptionType.badResponse,
            response: Response<dynamic>(
              requestOptions: RequestOptions(path: '/upload'),
              statusCode: 400,
            ),
          ),
        ),
        data: Matchers.any,
      );

      final ApiResult<String> result = await helper.uploadImage(
        file: XFile.fromData(
          Uint8List.fromList(<int>[0, 1, 2]),
          name: 'test.png',
          path: '/test.png',
        ),
      );
      expect(result, isA<ApiError<String>>());
    });

    test('returns ApiFailure on network error', () async {
      dioAdapter.onPost(
        '/upload',
        (MockServer server) => server.throws(
          500,
          DioException(
            requestOptions: RequestOptions(path: '/upload'),
            type: DioExceptionType.connectionTimeout,
          ),
        ),
        data: Matchers.any,
      );

      final ApiResult<String> result = await helper.uploadImage(
        file: XFile.fromData(
          Uint8List.fromList(<int>[0, 1, 2]),
          name: 'test.png',
          path: '/test.png',
        ),
      );
      expect(result, isA<ApiFailure<String>>());
    });
  });
}
