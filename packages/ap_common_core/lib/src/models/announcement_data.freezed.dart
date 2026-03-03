// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementData {
  List<Announcement> get data;

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnnouncementDataCopyWith<AnnouncementData> get copyWith =>
      _$AnnouncementDataCopyWithImpl<AnnouncementData>(
          this as AnnouncementData, _$identity);

  /// Serializes this AnnouncementData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnnouncementData &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'AnnouncementData(data: $data)';
  }
}

/// @nodoc
abstract mixin class $AnnouncementDataCopyWith<$Res> {
  factory $AnnouncementDataCopyWith(
          AnnouncementData value, $Res Function(AnnouncementData) _then) =
      _$AnnouncementDataCopyWithImpl;
  @useResult
  $Res call({List<Announcement> data});
}

/// @nodoc
class _$AnnouncementDataCopyWithImpl<$Res>
    implements $AnnouncementDataCopyWith<$Res> {
  _$AnnouncementDataCopyWithImpl(this._self, this._then);

  final AnnouncementData _self;
  final $Res Function(AnnouncementData) _then;

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Announcement>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AnnouncementData].
extension AnnouncementDataPatterns on AnnouncementData {
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
    TResult Function(_AnnouncementData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnnouncementData() when $default != null:
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
    TResult Function(_AnnouncementData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementData():
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
    TResult? Function(_AnnouncementData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementData() when $default != null:
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
    TResult Function(List<Announcement> data)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnnouncementData() when $default != null:
        return $default(_that.data);
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
    TResult Function(List<Announcement> data) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementData():
        return $default(_that.data);
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
    TResult? Function(List<Announcement> data)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnnouncementData() when $default != null:
        return $default(_that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AnnouncementData extends AnnouncementData {
  const _AnnouncementData({required final List<Announcement> data})
      : _data = data,
        super._();
  factory _AnnouncementData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDataFromJson(json);

  final List<Announcement> _data;
  @override
  List<Announcement> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnnouncementDataCopyWith<_AnnouncementData> get copyWith =>
      __$AnnouncementDataCopyWithImpl<_AnnouncementData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnnouncementDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnnouncementData &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'AnnouncementData(data: $data)';
  }
}

/// @nodoc
abstract mixin class _$AnnouncementDataCopyWith<$Res>
    implements $AnnouncementDataCopyWith<$Res> {
  factory _$AnnouncementDataCopyWith(
          _AnnouncementData value, $Res Function(_AnnouncementData) _then) =
      __$AnnouncementDataCopyWithImpl;
  @override
  @useResult
  $Res call({List<Announcement> data});
}

/// @nodoc
class __$AnnouncementDataCopyWithImpl<$Res>
    implements _$AnnouncementDataCopyWith<$Res> {
  __$AnnouncementDataCopyWithImpl(this._self, this._then);

  final _AnnouncementData _self;
  final $Res Function(_AnnouncementData) _then;

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(_AnnouncementData(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Announcement>,
    ));
  }
}

/// @nodoc
mixin _$Announcement {
  String get title;
  int? get id;
  int? get nextId;
  int? get lastId;
  int get weight;
  String get imgUrl;
  String? get url;
  String get description;
  String? get publishedTime;
  String? get expireTime;
  String? get applicant;
  @JsonKey(name: 'application_id')
  String? get applicationId;
  bool? get reviewStatus;
  String? get reviewDescription;
  @JsonKey(name: 'tag')
  List<String>? get tags;
  @JsonKey(includeToJson: false, includeFromJson: false)
  int get randomWeight;

  /// Create a copy of Announcement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnnouncementCopyWith<Announcement> get copyWith =>
      _$AnnouncementCopyWithImpl<Announcement>(
          this as Announcement, _$identity);

  /// Serializes this Announcement to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Announcement &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nextId, nextId) || other.nextId == nextId) &&
            (identical(other.lastId, lastId) || other.lastId == lastId) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publishedTime, publishedTime) ||
                other.publishedTime == publishedTime) &&
            (identical(other.expireTime, expireTime) ||
                other.expireTime == expireTime) &&
            (identical(other.applicant, applicant) ||
                other.applicant == applicant) &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.reviewStatus, reviewStatus) ||
                other.reviewStatus == reviewStatus) &&
            (identical(other.reviewDescription, reviewDescription) ||
                other.reviewDescription == reviewDescription) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.randomWeight, randomWeight) ||
                other.randomWeight == randomWeight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      id,
      nextId,
      lastId,
      weight,
      imgUrl,
      url,
      description,
      publishedTime,
      expireTime,
      applicant,
      applicationId,
      reviewStatus,
      reviewDescription,
      const DeepCollectionEquality().hash(tags),
      randomWeight);

  @override
  String toString() {
    return 'Announcement(title: $title, id: $id, nextId: $nextId, lastId: $lastId, weight: $weight, imgUrl: $imgUrl, url: $url, description: $description, publishedTime: $publishedTime, expireTime: $expireTime, applicant: $applicant, applicationId: $applicationId, reviewStatus: $reviewStatus, reviewDescription: $reviewDescription, tags: $tags, randomWeight: $randomWeight)';
  }
}

/// @nodoc
abstract mixin class $AnnouncementCopyWith<$Res> {
  factory $AnnouncementCopyWith(
          Announcement value, $Res Function(Announcement) _then) =
      _$AnnouncementCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      int? id,
      int? nextId,
      int? lastId,
      int weight,
      String imgUrl,
      String? url,
      String description,
      String? publishedTime,
      String? expireTime,
      String? applicant,
      @JsonKey(name: 'application_id') String? applicationId,
      bool? reviewStatus,
      String? reviewDescription,
      @JsonKey(name: 'tag') List<String>? tags,
      @JsonKey(includeToJson: false, includeFromJson: false) int randomWeight});
}

/// @nodoc
class _$AnnouncementCopyWithImpl<$Res> implements $AnnouncementCopyWith<$Res> {
  _$AnnouncementCopyWithImpl(this._self, this._then);

  final Announcement _self;
  final $Res Function(Announcement) _then;

  /// Create a copy of Announcement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = freezed,
    Object? nextId = freezed,
    Object? lastId = freezed,
    Object? weight = null,
    Object? imgUrl = null,
    Object? url = freezed,
    Object? description = null,
    Object? publishedTime = freezed,
    Object? expireTime = freezed,
    Object? applicant = freezed,
    Object? applicationId = freezed,
    Object? reviewStatus = freezed,
    Object? reviewDescription = freezed,
    Object? tags = freezed,
    Object? randomWeight = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nextId: freezed == nextId
          ? _self.nextId
          : nextId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastId: freezed == lastId
          ? _self.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as int?,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      imgUrl: null == imgUrl
          ? _self.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      publishedTime: freezed == publishedTime
          ? _self.publishedTime
          : publishedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      expireTime: freezed == expireTime
          ? _self.expireTime
          : expireTime // ignore: cast_nullable_to_non_nullable
              as String?,
      applicant: freezed == applicant
          ? _self.applicant
          : applicant // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationId: freezed == applicationId
          ? _self.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewStatus: freezed == reviewStatus
          ? _self.reviewStatus
          : reviewStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      reviewDescription: freezed == reviewDescription
          ? _self.reviewDescription
          : reviewDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      randomWeight: null == randomWeight
          ? _self.randomWeight
          : randomWeight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Announcement].
extension AnnouncementPatterns on Announcement {
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
    TResult Function(_Announcement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Announcement() when $default != null:
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
    TResult Function(_Announcement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Announcement():
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
    TResult? Function(_Announcement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Announcement() when $default != null:
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
            String title,
            int? id,
            int? nextId,
            int? lastId,
            int weight,
            String imgUrl,
            String? url,
            String description,
            String? publishedTime,
            String? expireTime,
            String? applicant,
            @JsonKey(name: 'application_id') String? applicationId,
            bool? reviewStatus,
            String? reviewDescription,
            @JsonKey(name: 'tag') List<String>? tags,
            @JsonKey(includeToJson: false, includeFromJson: false)
            int randomWeight)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Announcement() when $default != null:
        return $default(
            _that.title,
            _that.id,
            _that.nextId,
            _that.lastId,
            _that.weight,
            _that.imgUrl,
            _that.url,
            _that.description,
            _that.publishedTime,
            _that.expireTime,
            _that.applicant,
            _that.applicationId,
            _that.reviewStatus,
            _that.reviewDescription,
            _that.tags,
            _that.randomWeight);
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
            String title,
            int? id,
            int? nextId,
            int? lastId,
            int weight,
            String imgUrl,
            String? url,
            String description,
            String? publishedTime,
            String? expireTime,
            String? applicant,
            @JsonKey(name: 'application_id') String? applicationId,
            bool? reviewStatus,
            String? reviewDescription,
            @JsonKey(name: 'tag') List<String>? tags,
            @JsonKey(includeToJson: false, includeFromJson: false)
            int randomWeight)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Announcement():
        return $default(
            _that.title,
            _that.id,
            _that.nextId,
            _that.lastId,
            _that.weight,
            _that.imgUrl,
            _that.url,
            _that.description,
            _that.publishedTime,
            _that.expireTime,
            _that.applicant,
            _that.applicationId,
            _that.reviewStatus,
            _that.reviewDescription,
            _that.tags,
            _that.randomWeight);
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
            String title,
            int? id,
            int? nextId,
            int? lastId,
            int weight,
            String imgUrl,
            String? url,
            String description,
            String? publishedTime,
            String? expireTime,
            String? applicant,
            @JsonKey(name: 'application_id') String? applicationId,
            bool? reviewStatus,
            String? reviewDescription,
            @JsonKey(name: 'tag') List<String>? tags,
            @JsonKey(includeToJson: false, includeFromJson: false)
            int randomWeight)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Announcement() when $default != null:
        return $default(
            _that.title,
            _that.id,
            _that.nextId,
            _that.lastId,
            _that.weight,
            _that.imgUrl,
            _that.url,
            _that.description,
            _that.publishedTime,
            _that.expireTime,
            _that.applicant,
            _that.applicationId,
            _that.reviewStatus,
            _that.reviewDescription,
            _that.tags,
            _that.randomWeight);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Announcement extends Announcement {
  const _Announcement(
      {required this.title,
      this.id,
      this.nextId,
      this.lastId,
      required this.weight,
      required this.imgUrl,
      this.url,
      required this.description,
      this.publishedTime,
      this.expireTime,
      this.applicant,
      @JsonKey(name: 'application_id') this.applicationId,
      this.reviewStatus,
      this.reviewDescription,
      @JsonKey(name: 'tag') final List<String>? tags,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.randomWeight = 0})
      : _tags = tags,
        super._();
  factory _Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  @override
  final String title;
  @override
  final int? id;
  @override
  final int? nextId;
  @override
  final int? lastId;
  @override
  final int weight;
  @override
  final String imgUrl;
  @override
  final String? url;
  @override
  final String description;
  @override
  final String? publishedTime;
  @override
  final String? expireTime;
  @override
  final String? applicant;
  @override
  @JsonKey(name: 'application_id')
  final String? applicationId;
  @override
  final bool? reviewStatus;
  @override
  final String? reviewDescription;
  final List<String>? _tags;
  @override
  @JsonKey(name: 'tag')
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final int randomWeight;

  /// Create a copy of Announcement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnnouncementCopyWith<_Announcement> get copyWith =>
      __$AnnouncementCopyWithImpl<_Announcement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnnouncementToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Announcement &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nextId, nextId) || other.nextId == nextId) &&
            (identical(other.lastId, lastId) || other.lastId == lastId) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publishedTime, publishedTime) ||
                other.publishedTime == publishedTime) &&
            (identical(other.expireTime, expireTime) ||
                other.expireTime == expireTime) &&
            (identical(other.applicant, applicant) ||
                other.applicant == applicant) &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.reviewStatus, reviewStatus) ||
                other.reviewStatus == reviewStatus) &&
            (identical(other.reviewDescription, reviewDescription) ||
                other.reviewDescription == reviewDescription) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.randomWeight, randomWeight) ||
                other.randomWeight == randomWeight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      id,
      nextId,
      lastId,
      weight,
      imgUrl,
      url,
      description,
      publishedTime,
      expireTime,
      applicant,
      applicationId,
      reviewStatus,
      reviewDescription,
      const DeepCollectionEquality().hash(_tags),
      randomWeight);

  @override
  String toString() {
    return 'Announcement(title: $title, id: $id, nextId: $nextId, lastId: $lastId, weight: $weight, imgUrl: $imgUrl, url: $url, description: $description, publishedTime: $publishedTime, expireTime: $expireTime, applicant: $applicant, applicationId: $applicationId, reviewStatus: $reviewStatus, reviewDescription: $reviewDescription, tags: $tags, randomWeight: $randomWeight)';
  }
}

/// @nodoc
abstract mixin class _$AnnouncementCopyWith<$Res>
    implements $AnnouncementCopyWith<$Res> {
  factory _$AnnouncementCopyWith(
          _Announcement value, $Res Function(_Announcement) _then) =
      __$AnnouncementCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      int? id,
      int? nextId,
      int? lastId,
      int weight,
      String imgUrl,
      String? url,
      String description,
      String? publishedTime,
      String? expireTime,
      String? applicant,
      @JsonKey(name: 'application_id') String? applicationId,
      bool? reviewStatus,
      String? reviewDescription,
      @JsonKey(name: 'tag') List<String>? tags,
      @JsonKey(includeToJson: false, includeFromJson: false) int randomWeight});
}

/// @nodoc
class __$AnnouncementCopyWithImpl<$Res>
    implements _$AnnouncementCopyWith<$Res> {
  __$AnnouncementCopyWithImpl(this._self, this._then);

  final _Announcement _self;
  final $Res Function(_Announcement) _then;

  /// Create a copy of Announcement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? id = freezed,
    Object? nextId = freezed,
    Object? lastId = freezed,
    Object? weight = null,
    Object? imgUrl = null,
    Object? url = freezed,
    Object? description = null,
    Object? publishedTime = freezed,
    Object? expireTime = freezed,
    Object? applicant = freezed,
    Object? applicationId = freezed,
    Object? reviewStatus = freezed,
    Object? reviewDescription = freezed,
    Object? tags = freezed,
    Object? randomWeight = null,
  }) {
    return _then(_Announcement(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nextId: freezed == nextId
          ? _self.nextId
          : nextId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastId: freezed == lastId
          ? _self.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as int?,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      imgUrl: null == imgUrl
          ? _self.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      publishedTime: freezed == publishedTime
          ? _self.publishedTime
          : publishedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      expireTime: freezed == expireTime
          ? _self.expireTime
          : expireTime // ignore: cast_nullable_to_non_nullable
              as String?,
      applicant: freezed == applicant
          ? _self.applicant
          : applicant // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationId: freezed == applicationId
          ? _self.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewStatus: freezed == reviewStatus
          ? _self.reviewStatus
          : reviewStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      reviewDescription: freezed == reviewDescription
          ? _self.reviewDescription
          : reviewDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      randomWeight: null == randomWeight
          ? _self.randomWeight
          : randomWeight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
