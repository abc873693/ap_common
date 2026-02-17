// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeCodeConfig {
  List<TimeCode> get timeCodes;

  /// Create a copy of TimeCodeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeCodeConfigCopyWith<TimeCodeConfig> get copyWith =>
      _$TimeCodeConfigCopyWithImpl<TimeCodeConfig>(
          this as TimeCodeConfig, _$identity);

  /// Serializes this TimeCodeConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimeCodeConfig &&
            const DeepCollectionEquality().equals(other.timeCodes, timeCodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(timeCodes));

  @override
  String toString() {
    return 'TimeCodeConfig(timeCodes: $timeCodes)';
  }
}

/// @nodoc
abstract mixin class $TimeCodeConfigCopyWith<$Res> {
  factory $TimeCodeConfigCopyWith(
          TimeCodeConfig value, $Res Function(TimeCodeConfig) _then) =
      _$TimeCodeConfigCopyWithImpl;
  @useResult
  $Res call({List<TimeCode> timeCodes});
}

/// @nodoc
class _$TimeCodeConfigCopyWithImpl<$Res>
    implements $TimeCodeConfigCopyWith<$Res> {
  _$TimeCodeConfigCopyWithImpl(this._self, this._then);

  final TimeCodeConfig _self;
  final $Res Function(TimeCodeConfig) _then;

  /// Create a copy of TimeCodeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeCodes = null,
  }) {
    return _then(_self.copyWith(
      timeCodes: null == timeCodes
          ? _self.timeCodes
          : timeCodes // ignore: cast_nullable_to_non_nullable
              as List<TimeCode>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimeCodeConfig].
extension TimeCodeConfigPatterns on TimeCodeConfig {
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
    TResult Function(_TimeCodeConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeCodeConfig() when $default != null:
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
    TResult Function(_TimeCodeConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCodeConfig():
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
    TResult? Function(_TimeCodeConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCodeConfig() when $default != null:
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
    TResult Function(List<TimeCode> timeCodes)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeCodeConfig() when $default != null:
        return $default(_that.timeCodes);
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
    TResult Function(List<TimeCode> timeCodes) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCodeConfig():
        return $default(_that.timeCodes);
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
    TResult? Function(List<TimeCode> timeCodes)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCodeConfig() when $default != null:
        return $default(_that.timeCodes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimeCodeConfig extends TimeCodeConfig {
  const _TimeCodeConfig({required final List<TimeCode> timeCodes})
      : _timeCodes = timeCodes,
        super._();
  factory _TimeCodeConfig.fromJson(Map<String, dynamic> json) =>
      _$TimeCodeConfigFromJson(json);

  final List<TimeCode> _timeCodes;
  @override
  List<TimeCode> get timeCodes {
    if (_timeCodes is EqualUnmodifiableListView) return _timeCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeCodes);
  }

  /// Create a copy of TimeCodeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimeCodeConfigCopyWith<_TimeCodeConfig> get copyWith =>
      __$TimeCodeConfigCopyWithImpl<_TimeCodeConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimeCodeConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimeCodeConfig &&
            const DeepCollectionEquality()
                .equals(other._timeCodes, _timeCodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_timeCodes));

  @override
  String toString() {
    return 'TimeCodeConfig(timeCodes: $timeCodes)';
  }
}

/// @nodoc
abstract mixin class _$TimeCodeConfigCopyWith<$Res>
    implements $TimeCodeConfigCopyWith<$Res> {
  factory _$TimeCodeConfigCopyWith(
          _TimeCodeConfig value, $Res Function(_TimeCodeConfig) _then) =
      __$TimeCodeConfigCopyWithImpl;
  @override
  @useResult
  $Res call({List<TimeCode> timeCodes});
}

/// @nodoc
class __$TimeCodeConfigCopyWithImpl<$Res>
    implements _$TimeCodeConfigCopyWith<$Res> {
  __$TimeCodeConfigCopyWithImpl(this._self, this._then);

  final _TimeCodeConfig _self;
  final $Res Function(_TimeCodeConfig) _then;

  /// Create a copy of TimeCodeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? timeCodes = null,
  }) {
    return _then(_TimeCodeConfig(
      timeCodes: null == timeCodes
          ? _self._timeCodes
          : timeCodes // ignore: cast_nullable_to_non_nullable
              as List<TimeCode>,
    ));
  }
}

// dart format on
