// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_login_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementLoginData {
  String get key;

  /// Create a copy of AnnouncementLoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnnouncementLoginDataCopyWith<AnnouncementLoginData> get copyWith =>
      _$AnnouncementLoginDataCopyWithImpl<AnnouncementLoginData>(
          this as AnnouncementLoginData, _$identity);

  /// Serializes this AnnouncementLoginData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnnouncementLoginData &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'AnnouncementLoginData(key: $key)';
  }
}

/// @nodoc
abstract mixin class $AnnouncementLoginDataCopyWith<$Res> {
  factory $AnnouncementLoginDataCopyWith(AnnouncementLoginData value,
          $Res Function(AnnouncementLoginData) _then) =
      _$AnnouncementLoginDataCopyWithImpl;
  @useResult
  $Res call({String key});
}

/// @nodoc
class _$AnnouncementLoginDataCopyWithImpl<$Res>
    implements $AnnouncementLoginDataCopyWith<$Res> {
  _$AnnouncementLoginDataCopyWithImpl(this._self, this._then);

  final AnnouncementLoginData _self;
  final $Res Function(AnnouncementLoginData) _then;

  /// Create a copy of AnnouncementLoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_self.copyWith(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AnnouncementLoginData].
extension AnnouncementLoginDataPatterns on AnnouncementLoginData {
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
    TResult Function(_AnnouncementLoginData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnnouncementLoginData() when $default != null:
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
    TResult Function(_AnnouncementLoginData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementLoginData():
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
    TResult? Function(_AnnouncementLoginData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementLoginData() when $default != null:
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
    TResult Function(String key)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnnouncementLoginData() when $default != null:
        return $default(_that.key);
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
    TResult Function(String key) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementLoginData():
        return $default(_that.key);
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
    TResult? Function(String key)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementLoginData() when $default != null:
        return $default(_that.key);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AnnouncementLoginData extends AnnouncementLoginData {
  const _AnnouncementLoginData({required this.key}) : super._();
  factory _AnnouncementLoginData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementLoginDataFromJson(json);

  @override
  final String key;

  /// Create a copy of AnnouncementLoginData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnnouncementLoginDataCopyWith<_AnnouncementLoginData> get copyWith =>
      __$AnnouncementLoginDataCopyWithImpl<_AnnouncementLoginData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnnouncementLoginDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnnouncementLoginData &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'AnnouncementLoginData(key: $key)';
  }
}

/// @nodoc
abstract mixin class _$AnnouncementLoginDataCopyWith<$Res>
    implements $AnnouncementLoginDataCopyWith<$Res> {
  factory _$AnnouncementLoginDataCopyWith(_AnnouncementLoginData value,
          $Res Function(_AnnouncementLoginData) _then) =
      __$AnnouncementLoginDataCopyWithImpl;
  @override
  @useResult
  $Res call({String key});
}

/// @nodoc
class __$AnnouncementLoginDataCopyWithImpl<$Res>
    implements _$AnnouncementLoginDataCopyWith<$Res> {
  __$AnnouncementLoginDataCopyWithImpl(this._self, this._then);

  final _AnnouncementLoginData _self;
  final $Res Function(_AnnouncementLoginData) _then;

  /// Create a copy of AnnouncementLoginData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(_AnnouncementLoginData(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
