// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SemesterData {
  List<Semester> get data;
  @JsonKey(name: 'default')
  Semester get defaultSemester;
  int get currentIndex;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SemesterDataCopyWith<SemesterData> get copyWith =>
      _$SemesterDataCopyWithImpl<SemesterData>(
          this as SemesterData, _$identity);

  /// Serializes this SemesterData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SemesterData &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.defaultSemester, defaultSemester) ||
                other.defaultSemester == defaultSemester) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), defaultSemester, currentIndex);

  @override
  String toString() {
    return 'SemesterData(data: $data, defaultSemester: $defaultSemester, currentIndex: $currentIndex)';
  }
}

/// @nodoc
abstract mixin class $SemesterDataCopyWith<$Res> {
  factory $SemesterDataCopyWith(
          SemesterData value, $Res Function(SemesterData) _then) =
      _$SemesterDataCopyWithImpl;
  @useResult
  $Res call(
      {List<Semester> data,
      @JsonKey(name: 'default') Semester defaultSemester,
      int currentIndex});

  $SemesterCopyWith<$Res> get defaultSemester;
}

/// @nodoc
class _$SemesterDataCopyWithImpl<$Res> implements $SemesterDataCopyWith<$Res> {
  _$SemesterDataCopyWithImpl(this._self, this._then);

  final SemesterData _self;
  final $Res Function(SemesterData) _then;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? defaultSemester = null,
    Object? currentIndex = null,
  }) {
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Semester>,
      defaultSemester: null == defaultSemester
          ? _self.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as Semester,
      currentIndex: null == currentIndex
          ? _self.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SemesterCopyWith<$Res> get defaultSemester {
    return $SemesterCopyWith<$Res>(_self.defaultSemester, (value) {
      return _then(_self.copyWith(defaultSemester: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SemesterData].
extension SemesterDataPatterns on SemesterData {
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
    TResult Function(_SemesterData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
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
    TResult Function(_SemesterData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData():
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
    TResult? Function(_SemesterData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
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
            List<Semester> data,
            @JsonKey(name: 'default') Semester defaultSemester,
            int currentIndex)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
        return $default(_that.data, _that.defaultSemester, _that.currentIndex);
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
            List<Semester> data,
            @JsonKey(name: 'default') Semester defaultSemester,
            int currentIndex)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData():
        return $default(_that.data, _that.defaultSemester, _that.currentIndex);
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
            List<Semester> data,
            @JsonKey(name: 'default') Semester defaultSemester,
            int currentIndex)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SemesterData() when $default != null:
        return $default(_that.data, _that.defaultSemester, _that.currentIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SemesterData extends SemesterData {
  const _SemesterData(
      {required final List<Semester> data,
      @JsonKey(name: 'default') required this.defaultSemester,
      this.currentIndex = 0})
      : _data = data,
        super._();
  factory _SemesterData.fromJson(Map<String, dynamic> json) =>
      _$SemesterDataFromJson(json);

  final List<Semester> _data;
  @override
  List<Semester> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'default')
  final Semester defaultSemester;
  @override
  @JsonKey()
  final int currentIndex;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SemesterDataCopyWith<_SemesterData> get copyWith =>
      __$SemesterDataCopyWithImpl<_SemesterData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SemesterDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SemesterData &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.defaultSemester, defaultSemester) ||
                other.defaultSemester == defaultSemester) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      defaultSemester,
      currentIndex);

  @override
  String toString() {
    return 'SemesterData(data: $data, defaultSemester: $defaultSemester, currentIndex: $currentIndex)';
  }
}

/// @nodoc
abstract mixin class _$SemesterDataCopyWith<$Res>
    implements $SemesterDataCopyWith<$Res> {
  factory _$SemesterDataCopyWith(
          _SemesterData value, $Res Function(_SemesterData) _then) =
      __$SemesterDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Semester> data,
      @JsonKey(name: 'default') Semester defaultSemester,
      int currentIndex});

  @override
  $SemesterCopyWith<$Res> get defaultSemester;
}

/// @nodoc
class __$SemesterDataCopyWithImpl<$Res>
    implements _$SemesterDataCopyWith<$Res> {
  __$SemesterDataCopyWithImpl(this._self, this._then);

  final _SemesterData _self;
  final $Res Function(_SemesterData) _then;

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? defaultSemester = null,
    Object? currentIndex = null,
  }) {
    return _then(_SemesterData(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Semester>,
      defaultSemester: null == defaultSemester
          ? _self.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as Semester,
      currentIndex: null == currentIndex
          ? _self.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SemesterData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SemesterCopyWith<$Res> get defaultSemester {
    return $SemesterCopyWith<$Res>(_self.defaultSemester, (value) {
      return _then(_self.copyWith(defaultSemester: value));
    });
  }
}

/// @nodoc
mixin _$Semester {
  String get year;
  String get value;
  String get text;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SemesterCopyWith<Semester> get copyWith =>
      _$SemesterCopyWithImpl<Semester>(this as Semester, _$identity);

  /// Serializes this Semester to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Semester &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, value, text);

  @override
  String toString() {
    return 'Semester(year: $year, value: $value, text: $text)';
  }
}

/// @nodoc
abstract mixin class $SemesterCopyWith<$Res> {
  factory $SemesterCopyWith(Semester value, $Res Function(Semester) _then) =
      _$SemesterCopyWithImpl;
  @useResult
  $Res call({String year, String value, String text});
}

/// @nodoc
class _$SemesterCopyWithImpl<$Res> implements $SemesterCopyWith<$Res> {
  _$SemesterCopyWithImpl(this._self, this._then);

  final Semester _self;
  final $Res Function(Semester) _then;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? value = null,
    Object? text = null,
  }) {
    return _then(_self.copyWith(
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Semester].
extension SemesterPatterns on Semester {
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
    TResult Function(_Semester value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Semester() when $default != null:
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
    TResult Function(_Semester value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Semester():
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
    TResult? Function(_Semester value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Semester() when $default != null:
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
    TResult Function(String year, String value, String text)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Semester() when $default != null:
        return $default(_that.year, _that.value, _that.text);
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
    TResult Function(String year, String value, String text) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Semester():
        return $default(_that.year, _that.value, _that.text);
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
    TResult? Function(String year, String value, String text)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Semester() when $default != null:
        return $default(_that.year, _that.value, _that.text);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Semester extends Semester {
  const _Semester({required this.year, required this.value, required this.text})
      : super._();
  factory _Semester.fromJson(Map<String, dynamic> json) =>
      _$SemesterFromJson(json);

  @override
  final String year;
  @override
  final String value;
  @override
  final String text;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SemesterCopyWith<_Semester> get copyWith =>
      __$SemesterCopyWithImpl<_Semester>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SemesterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Semester &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, value, text);

  @override
  String toString() {
    return 'Semester(year: $year, value: $value, text: $text)';
  }
}

/// @nodoc
abstract mixin class _$SemesterCopyWith<$Res>
    implements $SemesterCopyWith<$Res> {
  factory _$SemesterCopyWith(_Semester value, $Res Function(_Semester) _then) =
      __$SemesterCopyWithImpl;
  @override
  @useResult
  $Res call({String year, String value, String text});
}

/// @nodoc
class __$SemesterCopyWithImpl<$Res> implements _$SemesterCopyWith<$Res> {
  __$SemesterCopyWithImpl(this._self, this._then);

  final _Semester _self;
  final $Res Function(_Semester) _then;

  /// Create a copy of Semester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? year = null,
    Object? value = null,
    Object? text = null,
  }) {
    return _then(_Semester(
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
