import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_flutter_core/src/utilities/ui_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiResult isSuccess', () {
    test('should return true for ApiSuccess', () {
      const ApiResult<String> result = ApiSuccess<String>('data');
      expect(result.isSuccess, isTrue);
    });

    test('should return false for ApiFailure', () {
      final ApiResult<String> result = ApiFailure<String>(
        DioException(requestOptions: RequestOptions()),
      );
      expect(result.isSuccess, isFalse);
    });

    test('should return false for ApiError', () {
      const ApiResult<String> result = ApiError<String>(
        GeneralResponse(statusCode: 400, message: 'error'),
      );
      expect(result.isSuccess, isFalse);
    });
  });
}
