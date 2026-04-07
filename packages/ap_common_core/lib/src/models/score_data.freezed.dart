// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoreData {
  List<Score> get scores;
  Detail get detail;
  ScoreType get scoreType;
  double get passingScore;
  double get passingGradePoint;

  /// Create a copy of ScoreData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScoreDataCopyWith<ScoreData> get copyWith =>
      _$ScoreDataCopyWithImpl<ScoreData>(this as ScoreData, _$identity);

  /// Serializes this ScoreData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScoreData &&
            const DeepCollectionEquality().equals(other.scores, scores) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.scoreType, scoreType) ||
                other.scoreType == scoreType) &&
            (identical(other.passingScore, passingScore) ||
                other.passingScore == passingScore) &&
            (identical(other.passingGradePoint, passingGradePoint) ||
                other.passingGradePoint == passingGradePoint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(scores),
      detail,
      scoreType,
      passingScore,
      passingGradePoint);

  @override
  String toString() {
    return 'ScoreData(scores: $scores, detail: $detail, scoreType: $scoreType, passingScore: $passingScore, passingGradePoint: $passingGradePoint)';
  }
}

/// @nodoc
abstract mixin class $ScoreDataCopyWith<$Res> {
  factory $ScoreDataCopyWith(ScoreData value, $Res Function(ScoreData) _then) =
      _$ScoreDataCopyWithImpl;
  @useResult
  $Res call(
      {List<Score> scores,
      Detail detail,
      ScoreType scoreType,
      double passingScore,
      double passingGradePoint});

  $DetailCopyWith<$Res> get detail;
}

/// @nodoc
class _$ScoreDataCopyWithImpl<$Res> implements $ScoreDataCopyWith<$Res> {
  _$ScoreDataCopyWithImpl(this._self, this._then);

  final ScoreData _self;
  final $Res Function(ScoreData) _then;

  /// Create a copy of ScoreData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scores = null,
    Object? detail = null,
    Object? scoreType = null,
    Object? passingScore = null,
    Object? passingGradePoint = null,
  }) {
    return _then(_self.copyWith(
      scores: null == scores
          ? _self.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<Score>,
      detail: null == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as Detail,
      scoreType: null == scoreType
          ? _self.scoreType
          : scoreType // ignore: cast_nullable_to_non_nullable
              as ScoreType,
      passingScore: null == passingScore
          ? _self.passingScore
          : passingScore // ignore: cast_nullable_to_non_nullable
              as double,
      passingGradePoint: null == passingGradePoint
          ? _self.passingGradePoint
          : passingGradePoint // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of ScoreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DetailCopyWith<$Res> get detail {
    return $DetailCopyWith<$Res>(_self.detail, (value) {
      return _then(_self.copyWith(detail: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ScoreData].
extension ScoreDataPatterns on ScoreData {
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
    TResult Function(_ScoreData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScoreData() when $default != null:
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
    TResult Function(_ScoreData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreData():
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
    TResult? Function(_ScoreData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreData() when $default != null:
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
    TResult Function(List<Score> scores, Detail detail, ScoreType scoreType,
            double passingScore, double passingGradePoint)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScoreData() when $default != null:
        return $default(_that.scores, _that.detail, _that.scoreType,
            _that.passingScore, _that.passingGradePoint);
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
    TResult Function(List<Score> scores, Detail detail, ScoreType scoreType,
            double passingScore, double passingGradePoint)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreData():
        return $default(_that.scores, _that.detail, _that.scoreType,
            _that.passingScore, _that.passingGradePoint);
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
    TResult? Function(List<Score> scores, Detail detail, ScoreType scoreType,
            double passingScore, double passingGradePoint)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreData() when $default != null:
        return $default(_that.scores, _that.detail, _that.scoreType,
            _that.passingScore, _that.passingGradePoint);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScoreData extends ScoreData {
  const _ScoreData(
      {required final List<Score> scores,
      required this.detail,
      this.scoreType = ScoreType.numeric,
      this.passingScore = 60.0,
      this.passingGradePoint = 1.7})
      : _scores = scores,
        super._();
  factory _ScoreData.fromJson(Map<String, dynamic> json) =>
      _$ScoreDataFromJson(json);

  final List<Score> _scores;
  @override
  List<Score> get scores {
    if (_scores is EqualUnmodifiableListView) return _scores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scores);
  }

  @override
  final Detail detail;
  @override
  @JsonKey()
  final ScoreType scoreType;
  @override
  @JsonKey()
  final double passingScore;
  @override
  @JsonKey()
  final double passingGradePoint;

  /// Create a copy of ScoreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScoreDataCopyWith<_ScoreData> get copyWith =>
      __$ScoreDataCopyWithImpl<_ScoreData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScoreDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScoreData &&
            const DeepCollectionEquality().equals(other._scores, _scores) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.scoreType, scoreType) ||
                other.scoreType == scoreType) &&
            (identical(other.passingScore, passingScore) ||
                other.passingScore == passingScore) &&
            (identical(other.passingGradePoint, passingGradePoint) ||
                other.passingGradePoint == passingGradePoint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_scores),
      detail,
      scoreType,
      passingScore,
      passingGradePoint);

  @override
  String toString() {
    return 'ScoreData(scores: $scores, detail: $detail, scoreType: $scoreType, passingScore: $passingScore, passingGradePoint: $passingGradePoint)';
  }
}

/// @nodoc
abstract mixin class _$ScoreDataCopyWith<$Res>
    implements $ScoreDataCopyWith<$Res> {
  factory _$ScoreDataCopyWith(
          _ScoreData value, $Res Function(_ScoreData) _then) =
      __$ScoreDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Score> scores,
      Detail detail,
      ScoreType scoreType,
      double passingScore,
      double passingGradePoint});

  @override
  $DetailCopyWith<$Res> get detail;
}

/// @nodoc
class __$ScoreDataCopyWithImpl<$Res> implements _$ScoreDataCopyWith<$Res> {
  __$ScoreDataCopyWithImpl(this._self, this._then);

  final _ScoreData _self;
  final $Res Function(_ScoreData) _then;

  /// Create a copy of ScoreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? scores = null,
    Object? detail = null,
    Object? scoreType = null,
    Object? passingScore = null,
    Object? passingGradePoint = null,
  }) {
    return _then(_ScoreData(
      scores: null == scores
          ? _self._scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<Score>,
      detail: null == detail
          ? _self.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as Detail,
      scoreType: null == scoreType
          ? _self.scoreType
          : scoreType // ignore: cast_nullable_to_non_nullable
              as ScoreType,
      passingScore: null == passingScore
          ? _self.passingScore
          : passingScore // ignore: cast_nullable_to_non_nullable
              as double,
      passingGradePoint: null == passingGradePoint
          ? _self.passingGradePoint
          : passingGradePoint // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of ScoreData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DetailCopyWith<$Res> get detail {
    return $DetailCopyWith<$Res>(_self.detail, (value) {
      return _then(_self.copyWith(detail: value));
    });
  }
}

/// @nodoc
mixin _$Detail {
  double? get creditTaken;
  double? get creditEarned;
  double? get average;
  String? get classRank;
  String? get departmentRank;
  double? get classPercentage;
  double? get conduct;

  /// Create a copy of Detail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DetailCopyWith<Detail> get copyWith =>
      _$DetailCopyWithImpl<Detail>(this as Detail, _$identity);

  /// Serializes this Detail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Detail &&
            (identical(other.creditTaken, creditTaken) ||
                other.creditTaken == creditTaken) &&
            (identical(other.creditEarned, creditEarned) ||
                other.creditEarned == creditEarned) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.classRank, classRank) ||
                other.classRank == classRank) &&
            (identical(other.departmentRank, departmentRank) ||
                other.departmentRank == departmentRank) &&
            (identical(other.classPercentage, classPercentage) ||
                other.classPercentage == classPercentage) &&
            (identical(other.conduct, conduct) || other.conduct == conduct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, creditTaken, creditEarned,
      average, classRank, departmentRank, classPercentage, conduct);

  @override
  String toString() {
    return 'Detail(creditTaken: $creditTaken, creditEarned: $creditEarned, average: $average, classRank: $classRank, departmentRank: $departmentRank, classPercentage: $classPercentage, conduct: $conduct)';
  }
}

/// @nodoc
abstract mixin class $DetailCopyWith<$Res> {
  factory $DetailCopyWith(Detail value, $Res Function(Detail) _then) =
      _$DetailCopyWithImpl;
  @useResult
  $Res call(
      {double? creditTaken,
      double? creditEarned,
      double? average,
      String? classRank,
      String? departmentRank,
      double? classPercentage,
      double? conduct});
}

/// @nodoc
class _$DetailCopyWithImpl<$Res> implements $DetailCopyWith<$Res> {
  _$DetailCopyWithImpl(this._self, this._then);

  final Detail _self;
  final $Res Function(Detail) _then;

  /// Create a copy of Detail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditTaken = freezed,
    Object? creditEarned = freezed,
    Object? average = freezed,
    Object? classRank = freezed,
    Object? departmentRank = freezed,
    Object? classPercentage = freezed,
    Object? conduct = freezed,
  }) {
    return _then(_self.copyWith(
      creditTaken: freezed == creditTaken
          ? _self.creditTaken
          : creditTaken // ignore: cast_nullable_to_non_nullable
              as double?,
      creditEarned: freezed == creditEarned
          ? _self.creditEarned
          : creditEarned // ignore: cast_nullable_to_non_nullable
              as double?,
      average: freezed == average
          ? _self.average
          : average // ignore: cast_nullable_to_non_nullable
              as double?,
      classRank: freezed == classRank
          ? _self.classRank
          : classRank // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentRank: freezed == departmentRank
          ? _self.departmentRank
          : departmentRank // ignore: cast_nullable_to_non_nullable
              as String?,
      classPercentage: freezed == classPercentage
          ? _self.classPercentage
          : classPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      conduct: freezed == conduct
          ? _self.conduct
          : conduct // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Detail].
extension DetailPatterns on Detail {
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
    TResult Function(_Detail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Detail() when $default != null:
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
    TResult Function(_Detail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Detail():
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
    TResult? Function(_Detail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Detail() when $default != null:
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
            double? creditTaken,
            double? creditEarned,
            double? average,
            String? classRank,
            String? departmentRank,
            double? classPercentage,
            double? conduct)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Detail() when $default != null:
        return $default(
            _that.creditTaken,
            _that.creditEarned,
            _that.average,
            _that.classRank,
            _that.departmentRank,
            _that.classPercentage,
            _that.conduct);
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
            double? creditTaken,
            double? creditEarned,
            double? average,
            String? classRank,
            String? departmentRank,
            double? classPercentage,
            double? conduct)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Detail():
        return $default(
            _that.creditTaken,
            _that.creditEarned,
            _that.average,
            _that.classRank,
            _that.departmentRank,
            _that.classPercentage,
            _that.conduct);
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
            double? creditTaken,
            double? creditEarned,
            double? average,
            String? classRank,
            String? departmentRank,
            double? classPercentage,
            double? conduct)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Detail() when $default != null:
        return $default(
            _that.creditTaken,
            _that.creditEarned,
            _that.average,
            _that.classRank,
            _that.departmentRank,
            _that.classPercentage,
            _that.conduct);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Detail extends Detail {
  const _Detail(
      {this.creditTaken,
      this.creditEarned,
      this.average,
      this.classRank,
      this.departmentRank,
      this.classPercentage,
      this.conduct})
      : super._();
  factory _Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  @override
  final double? creditTaken;
  @override
  final double? creditEarned;
  @override
  final double? average;
  @override
  final String? classRank;
  @override
  final String? departmentRank;
  @override
  final double? classPercentage;
  @override
  final double? conduct;

  /// Create a copy of Detail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DetailCopyWith<_Detail> get copyWith =>
      __$DetailCopyWithImpl<_Detail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Detail &&
            (identical(other.creditTaken, creditTaken) ||
                other.creditTaken == creditTaken) &&
            (identical(other.creditEarned, creditEarned) ||
                other.creditEarned == creditEarned) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.classRank, classRank) ||
                other.classRank == classRank) &&
            (identical(other.departmentRank, departmentRank) ||
                other.departmentRank == departmentRank) &&
            (identical(other.classPercentage, classPercentage) ||
                other.classPercentage == classPercentage) &&
            (identical(other.conduct, conduct) || other.conduct == conduct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, creditTaken, creditEarned,
      average, classRank, departmentRank, classPercentage, conduct);

  @override
  String toString() {
    return 'Detail(creditTaken: $creditTaken, creditEarned: $creditEarned, average: $average, classRank: $classRank, departmentRank: $departmentRank, classPercentage: $classPercentage, conduct: $conduct)';
  }
}

/// @nodoc
abstract mixin class _$DetailCopyWith<$Res> implements $DetailCopyWith<$Res> {
  factory _$DetailCopyWith(_Detail value, $Res Function(_Detail) _then) =
      __$DetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double? creditTaken,
      double? creditEarned,
      double? average,
      String? classRank,
      String? departmentRank,
      double? classPercentage,
      double? conduct});
}

/// @nodoc
class __$DetailCopyWithImpl<$Res> implements _$DetailCopyWith<$Res> {
  __$DetailCopyWithImpl(this._self, this._then);

  final _Detail _self;
  final $Res Function(_Detail) _then;

  /// Create a copy of Detail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? creditTaken = freezed,
    Object? creditEarned = freezed,
    Object? average = freezed,
    Object? classRank = freezed,
    Object? departmentRank = freezed,
    Object? classPercentage = freezed,
    Object? conduct = freezed,
  }) {
    return _then(_Detail(
      creditTaken: freezed == creditTaken
          ? _self.creditTaken
          : creditTaken // ignore: cast_nullable_to_non_nullable
              as double?,
      creditEarned: freezed == creditEarned
          ? _self.creditEarned
          : creditEarned // ignore: cast_nullable_to_non_nullable
              as double?,
      average: freezed == average
          ? _self.average
          : average // ignore: cast_nullable_to_non_nullable
              as double?,
      classRank: freezed == classRank
          ? _self.classRank
          : classRank // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentRank: freezed == departmentRank
          ? _self.departmentRank
          : departmentRank // ignore: cast_nullable_to_non_nullable
              as String?,
      classPercentage: freezed == classPercentage
          ? _self.classPercentage
          : classPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      conduct: freezed == conduct
          ? _self.conduct
          : conduct // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
mixin _$Score {
  String? get courseNumber;
  bool get isPreScore;
  String get title;
  String get units;
  String? get hours;
  String? get required;
  String? get at;
  String? get middleScore;
  String? get generalScore;
  String? get finalScore;
  String? get semesterScore;
  String? get remark;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScoreCopyWith<Score> get copyWith =>
      _$ScoreCopyWithImpl<Score>(this as Score, _$identity);

  /// Serializes this Score to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Score &&
            (identical(other.courseNumber, courseNumber) ||
                other.courseNumber == courseNumber) &&
            (identical(other.isPreScore, isPreScore) ||
                other.isPreScore == isPreScore) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.middleScore, middleScore) ||
                other.middleScore == middleScore) &&
            (identical(other.generalScore, generalScore) ||
                other.generalScore == generalScore) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.semesterScore, semesterScore) ||
                other.semesterScore == semesterScore) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      courseNumber,
      isPreScore,
      title,
      units,
      hours,
      required,
      at,
      middleScore,
      generalScore,
      finalScore,
      semesterScore,
      remark);

  @override
  String toString() {
    return 'Score(courseNumber: $courseNumber, isPreScore: $isPreScore, title: $title, units: $units, hours: $hours, required: $required, at: $at, middleScore: $middleScore, generalScore: $generalScore, finalScore: $finalScore, semesterScore: $semesterScore, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class $ScoreCopyWith<$Res> {
  factory $ScoreCopyWith(Score value, $Res Function(Score) _then) =
      _$ScoreCopyWithImpl;
  @useResult
  $Res call(
      {String? courseNumber,
      bool isPreScore,
      String title,
      String units,
      String? hours,
      String? required,
      String? at,
      String? middleScore,
      String? generalScore,
      String? finalScore,
      String? semesterScore,
      String? remark});
}

/// @nodoc
class _$ScoreCopyWithImpl<$Res> implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._self, this._then);

  final Score _self;
  final $Res Function(Score) _then;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseNumber = freezed,
    Object? isPreScore = null,
    Object? title = null,
    Object? units = null,
    Object? hours = freezed,
    Object? required = freezed,
    Object? at = freezed,
    Object? middleScore = freezed,
    Object? generalScore = freezed,
    Object? finalScore = freezed,
    Object? semesterScore = freezed,
    Object? remark = freezed,
  }) {
    return _then(_self.copyWith(
      courseNumber: freezed == courseNumber
          ? _self.courseNumber
          : courseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isPreScore: null == isPreScore
          ? _self.isPreScore
          : isPreScore // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as String,
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
      middleScore: freezed == middleScore
          ? _self.middleScore
          : middleScore // ignore: cast_nullable_to_non_nullable
              as String?,
      generalScore: freezed == generalScore
          ? _self.generalScore
          : generalScore // ignore: cast_nullable_to_non_nullable
              as String?,
      finalScore: freezed == finalScore
          ? _self.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as String?,
      semesterScore: freezed == semesterScore
          ? _self.semesterScore
          : semesterScore // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: freezed == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Score].
extension ScorePatterns on Score {
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
    TResult Function(_Score value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Score() when $default != null:
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
    TResult Function(_Score value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Score():
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
    TResult? Function(_Score value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Score() when $default != null:
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
            String? courseNumber,
            bool isPreScore,
            String title,
            String units,
            String? hours,
            String? required,
            String? at,
            String? middleScore,
            String? generalScore,
            String? finalScore,
            String? semesterScore,
            String? remark)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Score() when $default != null:
        return $default(
            _that.courseNumber,
            _that.isPreScore,
            _that.title,
            _that.units,
            _that.hours,
            _that.required,
            _that.at,
            _that.middleScore,
            _that.generalScore,
            _that.finalScore,
            _that.semesterScore,
            _that.remark);
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
            String? courseNumber,
            bool isPreScore,
            String title,
            String units,
            String? hours,
            String? required,
            String? at,
            String? middleScore,
            String? generalScore,
            String? finalScore,
            String? semesterScore,
            String? remark)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Score():
        return $default(
            _that.courseNumber,
            _that.isPreScore,
            _that.title,
            _that.units,
            _that.hours,
            _that.required,
            _that.at,
            _that.middleScore,
            _that.generalScore,
            _that.finalScore,
            _that.semesterScore,
            _that.remark);
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
            String? courseNumber,
            bool isPreScore,
            String title,
            String units,
            String? hours,
            String? required,
            String? at,
            String? middleScore,
            String? generalScore,
            String? finalScore,
            String? semesterScore,
            String? remark)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Score() when $default != null:
        return $default(
            _that.courseNumber,
            _that.isPreScore,
            _that.title,
            _that.units,
            _that.hours,
            _that.required,
            _that.at,
            _that.middleScore,
            _that.generalScore,
            _that.finalScore,
            _that.semesterScore,
            _that.remark);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Score extends Score {
  const _Score(
      {required this.courseNumber,
      this.isPreScore = false,
      required this.title,
      required this.units,
      required this.hours,
      required this.required,
      required this.at,
      required this.middleScore,
      required this.generalScore,
      required this.finalScore,
      required this.semesterScore,
      required this.remark})
      : super._();
  factory _Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  @override
  final String? courseNumber;
  @override
  @JsonKey()
  final bool isPreScore;
  @override
  final String title;
  @override
  final String units;
  @override
  final String? hours;
  @override
  final String? required;
  @override
  final String? at;
  @override
  final String? middleScore;
  @override
  final String? generalScore;
  @override
  final String? finalScore;
  @override
  final String? semesterScore;
  @override
  final String? remark;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScoreCopyWith<_Score> get copyWith =>
      __$ScoreCopyWithImpl<_Score>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScoreToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Score &&
            (identical(other.courseNumber, courseNumber) ||
                other.courseNumber == courseNumber) &&
            (identical(other.isPreScore, isPreScore) ||
                other.isPreScore == isPreScore) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.middleScore, middleScore) ||
                other.middleScore == middleScore) &&
            (identical(other.generalScore, generalScore) ||
                other.generalScore == generalScore) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.semesterScore, semesterScore) ||
                other.semesterScore == semesterScore) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      courseNumber,
      isPreScore,
      title,
      units,
      hours,
      required,
      at,
      middleScore,
      generalScore,
      finalScore,
      semesterScore,
      remark);

  @override
  String toString() {
    return 'Score(courseNumber: $courseNumber, isPreScore: $isPreScore, title: $title, units: $units, hours: $hours, required: $required, at: $at, middleScore: $middleScore, generalScore: $generalScore, finalScore: $finalScore, semesterScore: $semesterScore, remark: $remark)';
  }
}

/// @nodoc
abstract mixin class _$ScoreCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$ScoreCopyWith(_Score value, $Res Function(_Score) _then) =
      __$ScoreCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? courseNumber,
      bool isPreScore,
      String title,
      String units,
      String? hours,
      String? required,
      String? at,
      String? middleScore,
      String? generalScore,
      String? finalScore,
      String? semesterScore,
      String? remark});
}

/// @nodoc
class __$ScoreCopyWithImpl<$Res> implements _$ScoreCopyWith<$Res> {
  __$ScoreCopyWithImpl(this._self, this._then);

  final _Score _self;
  final $Res Function(_Score) _then;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? courseNumber = freezed,
    Object? isPreScore = null,
    Object? title = null,
    Object? units = null,
    Object? hours = freezed,
    Object? required = freezed,
    Object? at = freezed,
    Object? middleScore = freezed,
    Object? generalScore = freezed,
    Object? finalScore = freezed,
    Object? semesterScore = freezed,
    Object? remark = freezed,
  }) {
    return _then(_Score(
      courseNumber: freezed == courseNumber
          ? _self.courseNumber
          : courseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isPreScore: null == isPreScore
          ? _self.isPreScore
          : isPreScore // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as String,
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
      middleScore: freezed == middleScore
          ? _self.middleScore
          : middleScore // ignore: cast_nullable_to_non_nullable
              as String?,
      generalScore: freezed == generalScore
          ? _self.generalScore
          : generalScore // ignore: cast_nullable_to_non_nullable
              as String?,
      finalScore: freezed == finalScore
          ? _self.finalScore
          : finalScore // ignore: cast_nullable_to_non_nullable
              as String?,
      semesterScore: freezed == semesterScore
          ? _self.semesterScore
          : semesterScore // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: freezed == remark
          ? _self.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
