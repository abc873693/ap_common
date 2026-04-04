import 'package:ap_common_core/src/models/data_state.dart';
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

/// Extension to convert [ApiResult] into [DataState] for UI state management.
extension ApiResultToDataState<T> on ApiResult<T> {
  /// Converts this [ApiResult] to a [DataState].
  ///
  /// - [ApiSuccess] with non-null data → [DataLoaded]
  /// - [ApiSuccess] with null data → [DataEmpty]
  /// - [ApiError] → [DataError] with the error message as hint
  /// - [ApiFailure] → [DataError] with the exception message as hint
  DataState<T> toDataState() => switch (this) {
        ApiSuccess<T>(:final T data) => DataLoaded<T>(data),
        ApiError<T>(:final GeneralResponse response) =>
          DataError<T>(hint: response.message),
        ApiFailure<T>(:final DioException exception) =>
          DataError<T>(hint: exception.message),
      };
}
