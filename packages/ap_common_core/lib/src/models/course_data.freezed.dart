// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseData {
  List<Course> get courses;
  List<TimeCode> get timeCodes;

  /// Create a copy of CourseData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseDataCopyWith<CourseData> get copyWith =>
      _$CourseDataCopyWithImpl<CourseData>(this as CourseData, _$identity);

  /// Serializes this CourseData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseData &&
            const DeepCollectionEquality().equals(other.courses, courses) &&
            const DeepCollectionEquality().equals(other.timeCodes, timeCodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(courses),
      const DeepCollectionEquality().hash(timeCodes));

  @override
  String toString() {
    return 'CourseData(courses: $courses, timeCodes: $timeCodes)';
  }
}

/// @nodoc
abstract mixin class $CourseDataCopyWith<$Res> {
  factory $CourseDataCopyWith(
          CourseData value, $Res Function(CourseData) _then) =
      _$CourseDataCopyWithImpl;
  @useResult
  $Res call({List<Course> courses, List<TimeCode> timeCodes});
}

/// @nodoc
class _$CourseDataCopyWithImpl<$Res> implements $CourseDataCopyWith<$Res> {
  _$CourseDataCopyWithImpl(this._self, this._then);

  final CourseData _self;
  final $Res Function(CourseData) _then;

  /// Create a copy of CourseData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courses = null,
    Object? timeCodes = null,
  }) {
    return _then(_self.copyWith(
      courses: null == courses
          ? _self.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<Course>,
      timeCodes: null == timeCodes
          ? _self.timeCodes
          : timeCodes // ignore: cast_nullable_to_non_nullable
              as List<TimeCode>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CourseData].
extension CourseDataPatterns on CourseData {
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
    TResult Function(_CourseData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseData() when $default != null:
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
    TResult Function(_CourseData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseData():
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
    TResult? Function(_CourseData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseData() when $default != null:
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
    TResult Function(List<Course> courses, List<TimeCode> timeCodes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseData() when $default != null:
        return $default(_that.courses, _that.timeCodes);
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
    TResult Function(List<Course> courses, List<TimeCode> timeCodes) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseData():
        return $default(_that.courses, _that.timeCodes);
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
    TResult? Function(List<Course> courses, List<TimeCode> timeCodes)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseData() when $default != null:
        return $default(_that.courses, _that.timeCodes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseData extends CourseData {
  const _CourseData(
      {required final List<Course> courses,
      required final List<TimeCode> timeCodes})
      : _courses = courses,
        _timeCodes = timeCodes,
        super._();
  factory _CourseData.fromJson(Map<String, dynamic> json) =>
      _$CourseDataFromJson(json);

  final List<Course> _courses;
  @override
  List<Course> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  final List<TimeCode> _timeCodes;
  @override
  List<TimeCode> get timeCodes {
    if (_timeCodes is EqualUnmodifiableListView) return _timeCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeCodes);
  }

  /// Create a copy of CourseData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseDataCopyWith<_CourseData> get copyWith =>
      __$CourseDataCopyWithImpl<_CourseData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseData &&
            const DeepCollectionEquality().equals(other._courses, _courses) &&
            const DeepCollectionEquality()
                .equals(other._timeCodes, _timeCodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_courses),
      const DeepCollectionEquality().hash(_timeCodes));

  @override
  String toString() {
    return 'CourseData(courses: $courses, timeCodes: $timeCodes)';
  }
}

/// @nodoc
abstract mixin class _$CourseDataCopyWith<$Res>
    implements $CourseDataCopyWith<$Res> {
  factory _$CourseDataCopyWith(
          _CourseData value, $Res Function(_CourseData) _then) =
      __$CourseDataCopyWithImpl;
  @override
  @useResult
  $Res call({List<Course> courses, List<TimeCode> timeCodes});
}

/// @nodoc
class __$CourseDataCopyWithImpl<$Res> implements _$CourseDataCopyWith<$Res> {
  __$CourseDataCopyWithImpl(this._self, this._then);

  final _CourseData _self;
  final $Res Function(_CourseData) _then;

  /// Create a copy of CourseData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? courses = null,
    Object? timeCodes = null,
  }) {
    return _then(_CourseData(
      courses: null == courses
          ? _self._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<Course>,
      timeCodes: null == timeCodes
          ? _self._timeCodes
          : timeCodes // ignore: cast_nullable_to_non_nullable
              as List<TimeCode>,
    ));
  }
}

/// @nodoc
mixin _$Course {
  String get code;
  String get title;
  String? get className;
  String? get group;
  String? get units;
  String? get hours;
  String? get required;
  String? get at;
  @JsonKey(name: 'sectionTimes')
  List<SectionTime> get times;
  Location? get location;
  List<String> get instructors;
  int? get colorIndex;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseCopyWith<Course> get copyWith =>
      _$CourseCopyWithImpl<Course>(this as Course, _$identity);

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Course &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.at, at) || other.at == at) &&
            const DeepCollectionEquality().equals(other.times, times) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other.instructors, instructors) &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      title,
      className,
      group,
      units,
      hours,
      required,
      at,
      const DeepCollectionEquality().hash(times),
      location,
      const DeepCollectionEquality().hash(instructors),
      colorIndex);

  @override
  String toString() {
    return 'Course(code: $code, title: $title, className: $className, group: $group, units: $units, hours: $hours, required: $required, at: $at, times: $times, location: $location, instructors: $instructors, colorIndex: $colorIndex)';
  }
}

/// @nodoc
abstract mixin class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) _then) =
      _$CourseCopyWithImpl;
  @useResult
  $Res call(
      {String code,
      String title,
      String? className,
      String? group,
      String? units,
      String? hours,
      String? required,
      String? at,
      @JsonKey(name: 'sectionTimes') List<SectionTime> times,
      Location? location,
      List<String> instructors,
      int? colorIndex});

  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$CourseCopyWithImpl<$Res> implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._self, this._then);

  final Course _self;
  final $Res Function(Course) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
    Object? className = freezed,
    Object? group = freezed,
    Object? units = freezed,
    Object? hours = freezed,
    Object? required = freezed,
    Object? at = freezed,
    Object? times = null,
    Object? location = freezed,
    Object? instructors = null,
    Object? colorIndex = freezed,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      className: freezed == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      units: freezed == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as String?,
      hours: freezed == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as String?,
      required: freezed == required
          ? _self.required
          : required // ignore: cast_nullable_to_non_nullable
              as String?,
      at: freezed == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as String?,
      times: null == times
          ? _self.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<SectionTime>,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
      instructors: null == instructors
          ? _self.instructors
          : instructors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      colorIndex: freezed == colorIndex
          ? _self.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_self.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_self.location!, (value) {
      return _then(_self.copyWith(location: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Course].
extension CoursePatterns on Course {
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
    TResult Function(_Course value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Course() when $default != null:
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
    TResult Function(_Course value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Course():
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
    TResult? Function(_Course value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Course() when $default != null:
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
            String code,
            String title,
            String? className,
            String? group,
            String? units,
            String? hours,
            String? required,
            String? at,
            @JsonKey(name: 'sectionTimes') List<SectionTime> times,
            Location? location,
            List<String> instructors,
            int? colorIndex)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Course() when $default != null:
        return $default(
            _that.code,
            _that.title,
            _that.className,
            _that.group,
            _that.units,
            _that.hours,
            _that.required,
            _that.at,
            _that.times,
            _that.location,
            _that.instructors,
            _that.colorIndex);
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
            String code,
            String title,
            String? className,
            String? group,
            String? units,
            String? hours,
            String? required,
            String? at,
            @JsonKey(name: 'sectionTimes') List<SectionTime> times,
            Location? location,
            List<String> instructors,
            int? colorIndex)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Course():
        return $default(
            _that.code,
            _that.title,
            _that.className,
            _that.group,
            _that.units,
            _that.hours,
            _that.required,
            _that.at,
            _that.times,
            _that.location,
            _that.instructors,
            _that.colorIndex);
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
            String code,
            String title,
            String? className,
            String? group,
            String? units,
            String? hours,
            String? required,
            String? at,
            @JsonKey(name: 'sectionTimes') List<SectionTime> times,
            Location? location,
            List<String> instructors,
            int? colorIndex)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Course() when $default != null:
        return $default(
            _that.code,
            _that.title,
            _that.className,
            _that.group,
            _that.units,
            _that.hours,
            _that.required,
            _that.at,
            _that.times,
            _that.location,
            _that.instructors,
            _that.colorIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Course extends Course {
  const _Course(
      {required this.code,
      required this.title,
      this.className,
      this.group,
      this.units,
      this.hours,
      this.required,
      this.at,
      @JsonKey(name: 'sectionTimes') required final List<SectionTime> times,
      this.location,
      required final List<String> instructors,
      this.colorIndex})
      : _times = times,
        _instructors = instructors,
        super._();
  factory _Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  @override
  final String code;
  @override
  final String title;
  @override
  final String? className;
  @override
  final String? group;
  @override
  final String? units;
  @override
  final String? hours;
  @override
  final String? required;
  @override
  final String? at;
  final List<SectionTime> _times;
  @override
  @JsonKey(name: 'sectionTimes')
  List<SectionTime> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

  @override
  final Location? location;
  final List<String> _instructors;
  @override
  List<String> get instructors {
    if (_instructors is EqualUnmodifiableListView) return _instructors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructors);
  }

  @override
  final int? colorIndex;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseCopyWith<_Course> get copyWith =>
      __$CourseCopyWithImpl<_Course>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Course &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.at, at) || other.at == at) &&
            const DeepCollectionEquality().equals(other._times, _times) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._instructors, _instructors) &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      title,
      className,
      group,
      units,
      hours,
      required,
      at,
      const DeepCollectionEquality().hash(_times),
      location,
      const DeepCollectionEquality().hash(_instructors),
      colorIndex);

  @override
  String toString() {
    return 'Course(code: $code, title: $title, className: $className, group: $group, units: $units, hours: $hours, required: $required, at: $at, times: $times, location: $location, instructors: $instructors, colorIndex: $colorIndex)';
  }
}

/// @nodoc
abstract mixin class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) _then) =
      __$CourseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String code,
      String title,
      String? className,
      String? group,
      String? units,
      String? hours,
      String? required,
      String? at,
      @JsonKey(name: 'sectionTimes') List<SectionTime> times,
      Location? location,
      List<String> instructors,
      int? colorIndex});

  @override
  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$CourseCopyWithImpl<$Res> implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(this._self, this._then);

  final _Course _self;
  final $Res Function(_Course) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? title = null,
    Object? className = freezed,
    Object? group = freezed,
    Object? units = freezed,
    Object? hours = freezed,
    Object? required = freezed,
    Object? at = freezed,
    Object? times = null,
    Object? location = freezed,
    Object? instructors = null,
    Object? colorIndex = freezed,
  }) {
    return _then(_Course(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      className: freezed == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      units: freezed == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as String?,
      hours: freezed == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as String?,
      required: freezed == required
          ? _self.required
          : required // ignore: cast_nullable_to_non_nullable
              as String?,
      at: freezed == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as String?,
      times: null == times
          ? _self._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<SectionTime>,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
      instructors: null == instructors
          ? _self._instructors
          : instructors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      colorIndex: freezed == colorIndex
          ? _self.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_self.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_self.location!, (value) {
      return _then(_self.copyWith(location: value));
    });
  }
}

/// @nodoc
mixin _$Location {
  String get room;
  String get building;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationCopyWith<Location> get copyWith =>
      _$LocationCopyWithImpl<Location>(this as Location, _$identity);

  /// Serializes this Location to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Location &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.building, building) ||
                other.building == building));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, room, building);
}

/// @nodoc
abstract mixin class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) _then) =
      _$LocationCopyWithImpl;
  @useResult
  $Res call({String room, String building});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res> implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._self, this._then);

  final Location _self;
  final $Res Function(Location) _then;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? room = null,
    Object? building = null,
  }) {
    return _then(_self.copyWith(
      room: null == room
          ? _self.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      building: null == building
          ? _self.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Location].
extension LocationPatterns on Location {
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
    TResult Function(_Location value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Location() when $default != null:
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
    TResult Function(_Location value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Location():
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
    TResult? Function(_Location value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Location() when $default != null:
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
    TResult Function(String room, String building)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Location() when $default != null:
        return $default(_that.room, _that.building);
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
    TResult Function(String room, String building) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Location():
        return $default(_that.room, _that.building);
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
    TResult? Function(String room, String building)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Location() when $default != null:
        return $default(_that.room, _that.building);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Location extends Location {
  const _Location({required this.room, required this.building}) : super._();
  factory _Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @override
  final String room;
  @override
  final String building;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationCopyWith<_Location> get copyWith =>
      __$LocationCopyWithImpl<_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Location &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.building, building) ||
                other.building == building));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, room, building);
}

/// @nodoc
abstract mixin class _$LocationCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$LocationCopyWith(_Location value, $Res Function(_Location) _then) =
      __$LocationCopyWithImpl;
  @override
  @useResult
  $Res call({String room, String building});
}

/// @nodoc
class __$LocationCopyWithImpl<$Res> implements _$LocationCopyWith<$Res> {
  __$LocationCopyWithImpl(this._self, this._then);

  final _Location _self;
  final $Res Function(_Location) _then;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? room = null,
    Object? building = null,
  }) {
    return _then(_Location(
      room: null == room
          ? _self.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      building: null == building
          ? _self.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SectionTime {
  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  int get weekday;

  /// index of [CourseData.timeCodes]
  int get index;

  /// Create a copy of SectionTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SectionTimeCopyWith<SectionTime> get copyWith =>
      _$SectionTimeCopyWithImpl<SectionTime>(this as SectionTime, _$identity);

  /// Serializes this SectionTime to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SectionTime &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weekday, index);

  @override
  String toString() {
    return 'SectionTime(weekday: $weekday, index: $index)';
  }
}

/// @nodoc
abstract mixin class $SectionTimeCopyWith<$Res> {
  factory $SectionTimeCopyWith(
          SectionTime value, $Res Function(SectionTime) _then) =
      _$SectionTimeCopyWithImpl;
  @useResult
  $Res call({int weekday, int index});
}

/// @nodoc
class _$SectionTimeCopyWithImpl<$Res> implements $SectionTimeCopyWith<$Res> {
  _$SectionTimeCopyWithImpl(this._self, this._then);

  final SectionTime _self;
  final $Res Function(SectionTime) _then;

  /// Create a copy of SectionTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekday = null,
    Object? index = null,
  }) {
    return _then(_self.copyWith(
      weekday: null == weekday
          ? _self.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SectionTime].
extension SectionTimePatterns on SectionTime {
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
    TResult Function(_SectionTime value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionTime() when $default != null:
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
    TResult Function(_SectionTime value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionTime():
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
    TResult? Function(_SectionTime value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionTime() when $default != null:
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
    TResult Function(int weekday, int index)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionTime() when $default != null:
        return $default(_that.weekday, _that.index);
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
    TResult Function(int weekday, int index) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionTime():
        return $default(_that.weekday, _that.index);
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
    TResult? Function(int weekday, int index)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionTime() when $default != null:
        return $default(_that.weekday, _that.index);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SectionTime extends SectionTime {
  const _SectionTime({required this.weekday, required this.index}) : super._();
  factory _SectionTime.fromJson(Map<String, dynamic> json) =>
      _$SectionTimeFromJson(json);

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  @override
  final int weekday;

  /// index of [CourseData.timeCodes]
  @override
  final int index;

  /// Create a copy of SectionTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SectionTimeCopyWith<_SectionTime> get copyWith =>
      __$SectionTimeCopyWithImpl<_SectionTime>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SectionTimeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SectionTime &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weekday, index);

  @override
  String toString() {
    return 'SectionTime(weekday: $weekday, index: $index)';
  }
}

/// @nodoc
abstract mixin class _$SectionTimeCopyWith<$Res>
    implements $SectionTimeCopyWith<$Res> {
  factory _$SectionTimeCopyWith(
          _SectionTime value, $Res Function(_SectionTime) _then) =
      __$SectionTimeCopyWithImpl;
  @override
  @useResult
  $Res call({int weekday, int index});
}

/// @nodoc
class __$SectionTimeCopyWithImpl<$Res> implements _$SectionTimeCopyWith<$Res> {
  __$SectionTimeCopyWithImpl(this._self, this._then);

  final _SectionTime _self;
  final $Res Function(_SectionTime) _then;

  /// Create a copy of SectionTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weekday = null,
    Object? index = null,
  }) {
    return _then(_SectionTime(
      weekday: null == weekday
          ? _self.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$TimeCode {
  String get title;
  String get startTime;
  String get endTime;

  /// Create a copy of TimeCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeCodeCopyWith<TimeCode> get copyWith =>
      _$TimeCodeCopyWithImpl<TimeCode>(this as TimeCode, _$identity);

  /// Serializes this TimeCode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimeCode &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, startTime, endTime);

  @override
  String toString() {
    return 'TimeCode(title: $title, startTime: $startTime, endTime: $endTime)';
  }
}

/// @nodoc
abstract mixin class $TimeCodeCopyWith<$Res> {
  factory $TimeCodeCopyWith(TimeCode value, $Res Function(TimeCode) _then) =
      _$TimeCodeCopyWithImpl;
  @useResult
  $Res call({String title, String startTime, String endTime});
}

/// @nodoc
class _$TimeCodeCopyWithImpl<$Res> implements $TimeCodeCopyWith<$Res> {
  _$TimeCodeCopyWithImpl(this._self, this._then);

  final TimeCode _self;
  final $Res Function(TimeCode) _then;

  /// Create a copy of TimeCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimeCode].
extension TimeCodePatterns on TimeCode {
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
    TResult Function(_TimeCode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeCode() when $default != null:
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
    TResult Function(_TimeCode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCode():
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
    TResult? Function(_TimeCode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCode() when $default != null:
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
    TResult Function(String title, String startTime, String endTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeCode() when $default != null:
        return $default(_that.title, _that.startTime, _that.endTime);
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
    TResult Function(String title, String startTime, String endTime) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCode():
        return $default(_that.title, _that.startTime, _that.endTime);
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
    TResult? Function(String title, String startTime, String endTime)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeCode() when $default != null:
        return $default(_that.title, _that.startTime, _that.endTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimeCode extends TimeCode {
  const _TimeCode(
      {required this.title, required this.startTime, required this.endTime})
      : super._();
  factory _TimeCode.fromJson(Map<String, dynamic> json) =>
      _$TimeCodeFromJson(json);

  @override
  final String title;
  @override
  final String startTime;
  @override
  final String endTime;

  /// Create a copy of TimeCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimeCodeCopyWith<_TimeCode> get copyWith =>
      __$TimeCodeCopyWithImpl<_TimeCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimeCodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimeCode &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, startTime, endTime);

  @override
  String toString() {
    return 'TimeCode(title: $title, startTime: $startTime, endTime: $endTime)';
  }
}

/// @nodoc
abstract mixin class _$TimeCodeCopyWith<$Res>
    implements $TimeCodeCopyWith<$Res> {
  factory _$TimeCodeCopyWith(_TimeCode value, $Res Function(_TimeCode) _then) =
      __$TimeCodeCopyWithImpl;
  @override
  @useResult
  $Res call({String title, String startTime, String endTime});
}

/// @nodoc
class __$TimeCodeCopyWithImpl<$Res> implements _$TimeCodeCopyWith<$Res> {
  __$TimeCodeCopyWithImpl(this._self, this._then);

  final _TimeCode _self;
  final $Res Function(_TimeCode) _then;

  /// Create a copy of TimeCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_TimeCode(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
