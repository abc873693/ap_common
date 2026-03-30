import 'package:ap_common_core/ap_common_core.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('ApiResult', () {
    test('ApiSuccess should hold data', () {
      const ApiResult<String> result = ApiSuccess<String>('hello');

      expect(result, isA<ApiSuccess<String>>());
      expect((result as ApiSuccess<String>).data, 'hello');
    });

    test('ApiFailure should hold DioException', () {
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      final ApiResult<String> result = ApiFailure<String>(exception);

      expect(result, isA<ApiFailure<String>>());
      expect(
        (result as ApiFailure<String>).exception.type,
        DioExceptionType.connectionTimeout,
      );
    });

    test('ApiError should hold GeneralResponse', () {
      const ApiResult<String> result = ApiError<String>(
        GeneralResponse(statusCode: 404, message: 'Not Found'),
      );

      expect(result, isA<ApiError<String>>());
      const ApiError<String> error = result as ApiError<String>;
      expect(error.response.statusCode, 404);
      expect(error.response.message, 'Not Found');
    });

    test('pattern matching should work exhaustively', () {
      const ApiResult<int> success = ApiSuccess<int>(42);
      final ApiResult<int> failure = ApiFailure<int>(
        DioException(requestOptions: RequestOptions(path: '/')),
      );
      const ApiResult<int> error = ApiError<int>(
        GeneralResponse(statusCode: 500, message: 'Error'),
      );

      String classify(ApiResult<int> result) => switch (result) {
            ApiSuccess<int>() => 'success',
            ApiFailure<int>() => 'failure',
            ApiError<int>() => 'error',
          };

      expect(classify(success), 'success');
      expect(classify(failure), 'failure');
      expect(classify(error), 'error');
    });

    test('pattern matching should destructure fields', () {
      const ApiResult<String> result = ApiSuccess<String>('data');

      final String value = switch (result) {
        ApiSuccess<String>(:final String data) => data,
        ApiFailure<String>() => 'fail',
        ApiError<String>() => 'error',
      };

      expect(value, 'data');
    });
  });
}
