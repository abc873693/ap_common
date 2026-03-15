// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_notify_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseNotifyData {
  int get version;
  int get lastId;
  List<CourseNotify> get data;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get tag;

  /// Create a copy of CourseNotifyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseNotifyDataCopyWith<CourseNotifyData> get copyWith =>
      _$CourseNotifyDataCopyWithImpl<CourseNotifyData>(
          this as CourseNotifyData, _$identity);

  /// Serializes this CourseNotifyData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseNotifyData &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lastId, lastId) || other.lastId == lastId) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, lastId,
      const DeepCollectionEquality().hash(data), tag);

  @override
  String toString() {
    return 'CourseNotifyData(version: $version, lastId: $lastId, data: $data, tag: $tag)';
  }
}

/// @nodoc
abstract mixin class $CourseNotifyDataCopyWith<$Res> {
  factory $CourseNotifyDataCopyWith(
          CourseNotifyData value, $Res Function(CourseNotifyData) _then) =
      _$CourseNotifyDataCopyWithImpl;
  @useResult
  $Res call(
      {int version,
      int lastId,
      List<CourseNotify> data,
      @JsonKey(includeToJson: false, includeFromJson: false) String? tag});
}

/// @nodoc
class _$CourseNotifyDataCopyWithImpl<$Res>
    implements $CourseNotifyDataCopyWith<$Res> {
  _$CourseNotifyDataCopyWithImpl(this._self, this._then);

  final CourseNotifyData _self;
  final $Res Function(CourseNotifyData) _then;

  /// Create a copy of CourseNotifyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? lastId = null,
    Object? data = null,
    Object? tag = freezed,
  }) {
    return _then(_self.copyWith(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      lastId: null == lastId
          ? _self.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CourseNotify>,
      tag: freezed == tag
          ? _self.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CourseNotifyData].
extension CourseNotifyDataPatterns on CourseNotifyData {
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
    TResult Function(_CourseNotifyData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseNotifyData() when $default != null:
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
    TResult Function(_CourseNotifyData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotifyData():
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
    TResult? Function(_CourseNotifyData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotifyData() when $default != null:
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
    TResult Function(int version, int lastId, List<CourseNotify> data,
            @JsonKey(includeToJson: false, includeFromJson: false) String? tag)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseNotifyData() when $default != null:
        return $default(_that.version, _that.lastId, _that.data, _that.tag);
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
    TResult Function(int version, int lastId, List<CourseNotify> data,
            @JsonKey(includeToJson: false, includeFromJson: false) String? tag)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotifyData():
        return $default(_that.version, _that.lastId, _that.data, _that.tag);
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
    TResult? Function(int version, int lastId, List<CourseNotify> data,
            @JsonKey(includeToJson: false, includeFromJson: false) String? tag)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotifyData() when $default != null:
        return $default(_that.version, _that.lastId, _that.data, _that.tag);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseNotifyData extends CourseNotifyData {
  const _CourseNotifyData(
      {this.version = 2,
      this.lastId = 1,
      final List<CourseNotify> data = const <CourseNotify>[],
      @JsonKey(includeToJson: false, includeFromJson: false) this.tag})
      : _data = data,
        super._();
  factory _CourseNotifyData.fromJson(Map<String, dynamic> json) =>
      _$CourseNotifyDataFromJson(json);

  @override
  @JsonKey()
  final int version;
  @override
  @JsonKey()
  final int lastId;
  final List<CourseNotify> _data;
  @override
  @JsonKey()
  List<CourseNotify> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? tag;

  /// Create a copy of CourseNotifyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseNotifyDataCopyWith<_CourseNotifyData> get copyWith =>
      __$CourseNotifyDataCopyWithImpl<_CourseNotifyData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseNotifyDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseNotifyData &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lastId, lastId) || other.lastId == lastId) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, lastId,
      const DeepCollectionEquality().hash(_data), tag);

  @override
  String toString() {
    return 'CourseNotifyData(version: $version, lastId: $lastId, data: $data, tag: $tag)';
  }
}

/// @nodoc
abstract mixin class _$CourseNotifyDataCopyWith<$Res>
    implements $CourseNotifyDataCopyWith<$Res> {
  factory _$CourseNotifyDataCopyWith(
          _CourseNotifyData value, $Res Function(_CourseNotifyData) _then) =
      __$CourseNotifyDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int version,
      int lastId,
      List<CourseNotify> data,
      @JsonKey(includeToJson: false, includeFromJson: false) String? tag});
}

/// @nodoc
class __$CourseNotifyDataCopyWithImpl<$Res>
    implements _$CourseNotifyDataCopyWith<$Res> {
  __$CourseNotifyDataCopyWithImpl(this._self, this._then);

  final _CourseNotifyData _self;
  final $Res Function(_CourseNotifyData) _then;

  /// Create a copy of CourseNotifyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? version = null,
    Object? lastId = null,
    Object? data = null,
    Object? tag = freezed,
  }) {
    return _then(_CourseNotifyData(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      lastId: null == lastId
          ? _self.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CourseNotify>,
      tag: freezed == tag
          ? _self.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$CourseNotify {
  int get id;

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  int get weekday;
  String get startTime;
  String? get title;
  String? get location;
  String? get code;

  /// Create a copy of CourseNotify
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseNotifyCopyWith<CourseNotify> get copyWith =>
      _$CourseNotifyCopyWithImpl<CourseNotify>(
          this as CourseNotify, _$identity);

  /// Serializes this CourseNotify to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseNotify &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, weekday, startTime, title, location, code);

  @override
  String toString() {
    return 'CourseNotify(id: $id, weekday: $weekday, startTime: $startTime, title: $title, location: $location, code: $code)';
  }
}

/// @nodoc
abstract mixin class $CourseNotifyCopyWith<$Res> {
  factory $CourseNotifyCopyWith(
          CourseNotify value, $Res Function(CourseNotify) _then) =
      _$CourseNotifyCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int weekday,
      String startTime,
      String? title,
      String? location,
      String? code});
}

/// @nodoc
class _$CourseNotifyCopyWithImpl<$Res> implements $CourseNotifyCopyWith<$Res> {
  _$CourseNotifyCopyWithImpl(this._self, this._then);

  final CourseNotify _self;
  final $Res Function(CourseNotify) _then;

  /// Create a copy of CourseNotify
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? startTime = null,
    Object? title = freezed,
    Object? location = freezed,
    Object? code = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weekday: null == weekday
          ? _self.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CourseNotify].
extension CourseNotifyPatterns on CourseNotify {
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
    TResult Function(_CourseNotify value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseNotify() when $default != null:
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
    TResult Function(_CourseNotify value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotify():
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
    TResult? Function(_CourseNotify value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotify() when $default != null:
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
    TResult Function(int id, int weekday, String startTime, String? title,
            String? location, String? code)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseNotify() when $default != null:
        return $default(_that.id, _that.weekday, _that.startTime, _that.title,
            _that.location, _that.code);
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
    TResult Function(int id, int weekday, String startTime, String? title,
            String? location, String? code)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotify():
        return $default(_that.id, _that.weekday, _that.startTime, _that.title,
            _that.location, _that.code);
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
    TResult? Function(int id, int weekday, String startTime, String? title,
            String? location, String? code)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseNotify() when $default != null:
        return $default(_that.id, _that.weekday, _that.startTime, _that.title,
            _that.location, _that.code);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseNotify extends CourseNotify {
  const _CourseNotify(
      {required this.id,
      required this.weekday,
      required this.startTime,
      this.title,
      this.location,
      this.code})
      : super._();
  factory _CourseNotify.fromJson(Map<String, dynamic> json) =>
      _$CourseNotifyFromJson(json);

  @override
  final int id;

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  @override
  final int weekday;
  @override
  final String startTime;
  @override
  final String? title;
  @override
  final String? location;
  @override
  final String? code;

  /// Create a copy of CourseNotify
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseNotifyCopyWith<_CourseNotify> get copyWith =>
      __$CourseNotifyCopyWithImpl<_CourseNotify>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseNotifyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseNotify &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, weekday, startTime, title, location, code);

  @override
  String toString() {
    return 'CourseNotify(id: $id, weekday: $weekday, startTime: $startTime, title: $title, location: $location, code: $code)';
  }
}

/// @nodoc
abstract mixin class _$CourseNotifyCopyWith<$Res>
    implements $CourseNotifyCopyWith<$Res> {
  factory _$CourseNotifyCopyWith(
          _CourseNotify value, $Res Function(_CourseNotify) _then) =
      __$CourseNotifyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int weekday,
      String startTime,
      String? title,
      String? location,
      String? code});
}

/// @nodoc
class __$CourseNotifyCopyWithImpl<$Res>
    implements _$CourseNotifyCopyWith<$Res> {
  __$CourseNotifyCopyWithImpl(this._self, this._then);

  final _CourseNotify _self;
  final $Res Function(_CourseNotify) _then;

  /// Create a copy of CourseNotify
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? startTime = null,
    Object? title = freezed,
    Object? location = freezed,
    Object? code = freezed,
  }) {
    return _then(_CourseNotify(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weekday: null == weekday
          ? _self.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
