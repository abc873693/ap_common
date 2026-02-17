// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInfo {
  String? get educationSystem;
  String? get department;
  String? get className;
  String get id;
  String? get name;
  String? get pictureUrl;
  String? get email;
  @JsonKey(includeToJson: false, includeFromJson: false)
  Uint8List? get pictureBytes;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<UserInfo> get copyWith =>
      _$UserInfoCopyWithImpl<UserInfo>(this as UserInfo, _$identity);

  /// Serializes this UserInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserInfo &&
            (identical(other.educationSystem, educationSystem) ||
                other.educationSystem == educationSystem) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other.pictureBytes, pictureBytes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      educationSystem,
      department,
      className,
      id,
      name,
      pictureUrl,
      email,
      const DeepCollectionEquality().hash(pictureBytes));

  @override
  String toString() {
    return 'UserInfo(educationSystem: $educationSystem, department: $department, className: $className, id: $id, name: $name, pictureUrl: $pictureUrl, email: $email, pictureBytes: $pictureBytes)';
  }
}

/// @nodoc
abstract mixin class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) _then) =
      _$UserInfoCopyWithImpl;
  @useResult
  $Res call(
      {String? educationSystem,
      String? department,
      String? className,
      String id,
      String? name,
      String? pictureUrl,
      String? email,
      @JsonKey(includeToJson: false, includeFromJson: false)
      Uint8List? pictureBytes});
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res> implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._self, this._then);

  final UserInfo _self;
  final $Res Function(UserInfo) _then;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? educationSystem = freezed,
    Object? department = freezed,
    Object? className = freezed,
    Object? id = null,
    Object? name = freezed,
    Object? pictureUrl = freezed,
    Object? email = freezed,
    Object? pictureBytes = freezed,
  }) {
    return _then(_self.copyWith(
      educationSystem: freezed == educationSystem
          ? _self.educationSystem
          : educationSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _self.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: freezed == pictureUrl
          ? _self.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureBytes: freezed == pictureBytes
          ? _self.pictureBytes
          : pictureBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserInfo].
extension UserInfoPatterns on UserInfo {
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
    TResult Function(_UserInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserInfo() when $default != null:
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
    TResult Function(_UserInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfo():
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
    TResult? Function(_UserInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfo() when $default != null:
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
    TResult Function(
            String? educationSystem,
            String? department,
            String? className,
            String id,
            String? name,
            String? pictureUrl,
            String? email,
            @JsonKey(includeToJson: false, includeFromJson: false)
            Uint8List? pictureBytes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserInfo() when $default != null:
        return $default(
            _that.educationSystem,
            _that.department,
            _that.className,
            _that.id,
            _that.name,
            _that.pictureUrl,
            _that.email,
            _that.pictureBytes);
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
    TResult Function(
            String? educationSystem,
            String? department,
            String? className,
            String id,
            String? name,
            String? pictureUrl,
            String? email,
            @JsonKey(includeToJson: false, includeFromJson: false)
            Uint8List? pictureBytes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfo():
        return $default(
            _that.educationSystem,
            _that.department,
            _that.className,
            _that.id,
            _that.name,
            _that.pictureUrl,
            _that.email,
            _that.pictureBytes);
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
    TResult? Function(
            String? educationSystem,
            String? department,
            String? className,
            String id,
            String? name,
            String? pictureUrl,
            String? email,
            @JsonKey(includeToJson: false, includeFromJson: false)
            Uint8List? pictureBytes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserInfo() when $default != null:
        return $default(
            _that.educationSystem,
            _that.department,
            _that.className,
            _that.id,
            _that.name,
            _that.pictureUrl,
            _that.email,
            _that.pictureBytes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserInfo extends UserInfo {
  const _UserInfo(
      {this.educationSystem,
      required this.department,
      this.className,
      required this.id,
      required this.name,
      this.pictureUrl,
      this.email,
      @JsonKey(includeToJson: false, includeFromJson: false) this.pictureBytes})
      : super._();
  factory _UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  @override
  final String? educationSystem;
  @override
  final String? department;
  @override
  final String? className;
  @override
  final String id;
  @override
  final String? name;
  @override
  final String? pictureUrl;
  @override
  final String? email;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Uint8List? pictureBytes;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserInfoCopyWith<_UserInfo> get copyWith =>
      __$UserInfoCopyWithImpl<_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserInfo &&
            (identical(other.educationSystem, educationSystem) ||
                other.educationSystem == educationSystem) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other.pictureBytes, pictureBytes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      educationSystem,
      department,
      className,
      id,
      name,
      pictureUrl,
      email,
      const DeepCollectionEquality().hash(pictureBytes));

  @override
  String toString() {
    return 'UserInfo(educationSystem: $educationSystem, department: $department, className: $className, id: $id, name: $name, pictureUrl: $pictureUrl, email: $email, pictureBytes: $pictureBytes)';
  }
}

/// @nodoc
abstract mixin class _$UserInfoCopyWith<$Res>
    implements $UserInfoCopyWith<$Res> {
  factory _$UserInfoCopyWith(_UserInfo value, $Res Function(_UserInfo) _then) =
      __$UserInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? educationSystem,
      String? department,
      String? className,
      String id,
      String? name,
      String? pictureUrl,
      String? email,
      @JsonKey(includeToJson: false, includeFromJson: false)
      Uint8List? pictureBytes});
}

/// @nodoc
class __$UserInfoCopyWithImpl<$Res> implements _$UserInfoCopyWith<$Res> {
  __$UserInfoCopyWithImpl(this._self, this._then);

  final _UserInfo _self;
  final $Res Function(_UserInfo) _then;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? educationSystem = freezed,
    Object? department = freezed,
    Object? className = freezed,
    Object? id = null,
    Object? name = freezed,
    Object? pictureUrl = freezed,
    Object? email = freezed,
    Object? pictureBytes = freezed,
  }) {
    return _then(_UserInfo(
      educationSystem: freezed == educationSystem
          ? _self.educationSystem
          : educationSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _self.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: freezed == pictureUrl
          ? _self.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureBytes: freezed == pictureBytes
          ? _self.pictureBytes
          : pictureBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

// dart format on
