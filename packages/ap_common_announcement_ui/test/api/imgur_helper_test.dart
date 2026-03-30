import 'dart:typed_data';

import 'package:ap_common_announcement_ui/src/api/imgur_helper.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_mock_adapter/src/handlers/request_handler.dart';

void main() {
  late ImgurHelper helper;
  late DioAdapter dioAdapter;

  setUp(() {
    helper = ImgurHelper();
    dioAdapter = DioAdapter(dio: helper.dio);
  });

  group('ImgurHelper constants', () {
    test('clientId should be set', () {
      expect(ImgurHelper.clientId, isNotEmpty);
    });

    test('base URL should be imgur API', () {
      expect(helper.dio.options.baseUrl, 'https://api.imgur.com');
    });
  });

  group('uploadImage', () {
    test('returns ApiSuccess with link on 200', () async {
      dioAdapter.onPost(
        '/3/image',
        (MockServer server) => server.reply(
          200,
          <String, dynamic>{
            'data': <String, dynamic>{
              'link': 'https://i.imgur.com/test.png',
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
        'https://i.imgur.com/test.png',
      );
    });

    test('returns ApiError on non-200 status', () async {
      dioAdapter.onPost(
        '/3/image',
        (MockServer server) => server.reply(
          201,
          <String, dynamic>{
            'success': false,
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
        '/3/image',
        (MockServer server) => server.throws(
          400,
          DioException(
            requestOptions: RequestOptions(path: '/3/image'),
            type: DioExceptionType.badResponse,
            response: Response<dynamic>(
              requestOptions: RequestOptions(path: '/3/image'),
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
        '/3/image',
        (MockServer server) => server.throws(
          500,
          DioException(
            requestOptions: RequestOptions(path: '/3/image'),
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
