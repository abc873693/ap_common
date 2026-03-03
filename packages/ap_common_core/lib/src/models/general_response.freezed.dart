// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneralResponse {
  @JsonKey(name: 'code')
  int get statusCode;
  @JsonKey(name: 'description')
  String get message;

  /// Create a copy of GeneralResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeneralResponseCopyWith<GeneralResponse> get copyWith =>
      _$GeneralResponseCopyWithImpl<GeneralResponse>(
          this as GeneralResponse, _$identity);

  /// Serializes this GeneralResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeneralResponse &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @override
  String toString() {
    return 'GeneralResponse(statusCode: $statusCode, message: $message)';
  }
}

/// @nodoc
abstract mixin class $GeneralResponseCopyWith<$Res> {
  factory $GeneralResponseCopyWith(
          GeneralResponse value, $Res Function(GeneralResponse) _then) =
      _$GeneralResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') int statusCode,
      @JsonKey(name: 'description') String message});
}

/// @nodoc
class _$GeneralResponseCopyWithImpl<$Res>
    implements $GeneralResponseCopyWith<$Res> {
  _$GeneralResponseCopyWithImpl(this._self, this._then);

  final GeneralResponse _self;
  final $Res Function(GeneralResponse) _then;

  /// Create a copy of GeneralResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GeneralResponse].
extension GeneralResponsePatterns on GeneralResponse {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GeneralResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneralResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GeneralResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GeneralResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(@JsonKey(name: 'code') int statusCode,
            @JsonKey(name: 'description') String message)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneralResponse() when $default != null:
        return $default(_that.statusCode, _that.message);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(@JsonKey(name: 'code') int statusCode,
            @JsonKey(name: 'description') String message)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralResponse():
        return $default(_that.statusCode, _that.message);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(@JsonKey(name: 'code') int statusCode,
            @JsonKey(name: 'description') String message)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneralResponse() when $default != null:
        return $default(_that.statusCode, _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GeneralResponse extends GeneralResponse {
  const _GeneralResponse(
      {@JsonKey(name: 'code') required this.statusCode,
      @JsonKey(name: 'description') required this.message})
      : super._();
  factory _GeneralResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralResponseFromJson(json);

  @override
  @JsonKey(name: 'code')
  final int statusCode;
  @override
  @JsonKey(name: 'description')
  final String message;

  /// Create a copy of GeneralResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeneralResponseCopyWith<_GeneralResponse> get copyWith =>
      __$GeneralResponseCopyWithImpl<_GeneralResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeneralResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeneralResponse &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @override
  String toString() {
    return 'GeneralResponse(statusCode: $statusCode, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$GeneralResponseCopyWith<$Res>
    implements $GeneralResponseCopyWith<$Res> {
  factory _$GeneralResponseCopyWith(
          _GeneralResponse value, $Res Function(_GeneralResponse) _then) =
      __$GeneralResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') int statusCode,
      @JsonKey(name: 'description') String message});
}

/// @nodoc
class __$GeneralResponseCopyWithImpl<$Res>
    implements _$GeneralResponseCopyWith<$Res> {
  __$GeneralResponseCopyWithImpl(this._self, this._then);

  final _GeneralResponse _self;
  final $Res Function(_GeneralResponse) _then;

  /// Create a copy of GeneralResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_GeneralResponse(
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
