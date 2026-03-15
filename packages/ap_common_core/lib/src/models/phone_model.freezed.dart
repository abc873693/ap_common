// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneModel {
  String get name;
  String get number;

  /// Create a copy of PhoneModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PhoneModelCopyWith<PhoneModel> get copyWith =>
      _$PhoneModelCopyWithImpl<PhoneModel>(this as PhoneModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PhoneModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, number);

  @override
  String toString() {
    return 'PhoneModel(name: $name, number: $number)';
  }
}

/// @nodoc
abstract mixin class $PhoneModelCopyWith<$Res> {
  factory $PhoneModelCopyWith(
          PhoneModel value, $Res Function(PhoneModel) _then) =
      _$PhoneModelCopyWithImpl;
  @useResult
  $Res call({String name, String number});
}

/// @nodoc
class _$PhoneModelCopyWithImpl<$Res> implements $PhoneModelCopyWith<$Res> {
  _$PhoneModelCopyWithImpl(this._self, this._then);

  final PhoneModel _self;
  final $Res Function(PhoneModel) _then;

  /// Create a copy of PhoneModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? number = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PhoneModel].
extension PhoneModelPatterns on PhoneModel {
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
    TResult Function(_PhoneModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PhoneModel() when $default != null:
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
    TResult Function(_PhoneModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneModel():
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
    TResult? Function(_PhoneModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneModel() when $default != null:
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
    TResult Function(String name, String number)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PhoneModel() when $default != null:
        return $default(_that.name, _that.number);
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
    TResult Function(String name, String number) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneModel():
        return $default(_that.name, _that.number);
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
    TResult? Function(String name, String number)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneModel() when $default != null:
        return $default(_that.name, _that.number);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PhoneModel implements PhoneModel {
  const _PhoneModel(this.name, this.number);

  @override
  final String name;
  @override
  final String number;

  /// Create a copy of PhoneModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PhoneModelCopyWith<_PhoneModel> get copyWith =>
      __$PhoneModelCopyWithImpl<_PhoneModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PhoneModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, number);

  @override
  String toString() {
    return 'PhoneModel(name: $name, number: $number)';
  }
}

/// @nodoc
abstract mixin class _$PhoneModelCopyWith<$Res>
    implements $PhoneModelCopyWith<$Res> {
  factory _$PhoneModelCopyWith(
          _PhoneModel value, $Res Function(_PhoneModel) _then) =
      __$PhoneModelCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String number});
}

/// @nodoc
class __$PhoneModelCopyWithImpl<$Res> implements _$PhoneModelCopyWith<$Res> {
  __$PhoneModelCopyWithImpl(this._self, this._then);

  final _PhoneModel _self;
  final $Res Function(_PhoneModel) _then;

  /// Create a copy of PhoneModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? number = null,
  }) {
    return _then(_PhoneModel(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
