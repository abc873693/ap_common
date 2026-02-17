// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VersionInfo {
  int get code;
  bool get isForceUpdate;
  String get content;

  /// Create a copy of VersionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VersionInfoCopyWith<VersionInfo> get copyWith =>
      _$VersionInfoCopyWithImpl<VersionInfo>(this as VersionInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VersionInfo &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.isForceUpdate, isForceUpdate) ||
                other.isForceUpdate == isForceUpdate) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, isForceUpdate, content);

  @override
  String toString() {
    return 'VersionInfo(code: $code, isForceUpdate: $isForceUpdate, content: $content)';
  }
}

/// @nodoc
abstract mixin class $VersionInfoCopyWith<$Res> {
  factory $VersionInfoCopyWith(
          VersionInfo value, $Res Function(VersionInfo) _then) =
      _$VersionInfoCopyWithImpl;
  @useResult
  $Res call({int code, bool isForceUpdate, String content});
}

/// @nodoc
class _$VersionInfoCopyWithImpl<$Res> implements $VersionInfoCopyWith<$Res> {
  _$VersionInfoCopyWithImpl(this._self, this._then);

  final VersionInfo _self;
  final $Res Function(VersionInfo) _then;

  /// Create a copy of VersionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? isForceUpdate = null,
    Object? content = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      isForceUpdate: null == isForceUpdate
          ? _self.isForceUpdate
          : isForceUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [VersionInfo].
extension VersionInfoPatterns on VersionInfo {
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
    TResult Function(_VersionInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VersionInfo() when $default != null:
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
    TResult Function(_VersionInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VersionInfo():
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
    TResult? Function(_VersionInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VersionInfo() when $default != null:
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
    TResult Function(int code, bool isForceUpdate, String content)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VersionInfo() when $default != null:
        return $default(_that.code, _that.isForceUpdate, _that.content);
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
    TResult Function(int code, bool isForceUpdate, String content) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VersionInfo():
        return $default(_that.code, _that.isForceUpdate, _that.content);
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
    TResult? Function(int code, bool isForceUpdate, String content)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VersionInfo() when $default != null:
        return $default(_that.code, _that.isForceUpdate, _that.content);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VersionInfo implements VersionInfo {
  const _VersionInfo(
      {required this.code, required this.isForceUpdate, required this.content});

  @override
  final int code;
  @override
  final bool isForceUpdate;
  @override
  final String content;

  /// Create a copy of VersionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VersionInfoCopyWith<_VersionInfo> get copyWith =>
      __$VersionInfoCopyWithImpl<_VersionInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VersionInfo &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.isForceUpdate, isForceUpdate) ||
                other.isForceUpdate == isForceUpdate) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, isForceUpdate, content);

  @override
  String toString() {
    return 'VersionInfo(code: $code, isForceUpdate: $isForceUpdate, content: $content)';
  }
}

/// @nodoc
abstract mixin class _$VersionInfoCopyWith<$Res>
    implements $VersionInfoCopyWith<$Res> {
  factory _$VersionInfoCopyWith(
          _VersionInfo value, $Res Function(_VersionInfo) _then) =
      __$VersionInfoCopyWithImpl;
  @override
  @useResult
  $Res call({int code, bool isForceUpdate, String content});
}

/// @nodoc
class __$VersionInfoCopyWithImpl<$Res> implements _$VersionInfoCopyWith<$Res> {
  __$VersionInfoCopyWithImpl(this._self, this._then);

  final _VersionInfo _self;
  final $Res Function(_VersionInfo) _then;

  /// Create a copy of VersionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? isForceUpdate = null,
    Object? content = null,
  }) {
    return _then(_VersionInfo(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      isForceUpdate: null == isForceUpdate
          ? _self.isForceUpdate
          : isForceUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
