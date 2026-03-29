import 'package:ap_common_core/src/models/general_response.dart';
import 'package:dio/dio.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);
  final T data;
}

class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure(this.exception);
  final DioException exception;
}

class ApiError<T> extends ApiResult<T> {
  const ApiError(this.response);
  final GeneralResponse response;
}
