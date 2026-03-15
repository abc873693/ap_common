// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'imgur_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImgurUploadResponse {
  int? get status;
  bool? get success;
  ImgurUploadData? get data;

  /// Create a copy of ImgurUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImgurUploadResponseCopyWith<ImgurUploadResponse> get copyWith =>
      _$ImgurUploadResponseCopyWithImpl<ImgurUploadResponse>(
          this as ImgurUploadResponse, _$identity);

  /// Serializes this ImgurUploadResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImgurUploadResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, success, data);

  @override
  String toString() {
    return 'ImgurUploadResponse(status: $status, success: $success, data: $data)';
  }
}

/// @nodoc
abstract mixin class $ImgurUploadResponseCopyWith<$Res> {
  factory $ImgurUploadResponseCopyWith(
          ImgurUploadResponse value, $Res Function(ImgurUploadResponse) _then) =
      _$ImgurUploadResponseCopyWithImpl;
  @useResult
  $Res call({int? status, bool? success, ImgurUploadData? data});

  $ImgurUploadDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ImgurUploadResponseCopyWithImpl<$Res>
    implements $ImgurUploadResponseCopyWith<$Res> {
  _$ImgurUploadResponseCopyWithImpl(this._self, this._then);

  final ImgurUploadResponse _self;
  final $Res Function(ImgurUploadResponse) _then;

  /// Create a copy of ImgurUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? success = freezed,
    Object? data = freezed,
  }) {
    return _then(_self.copyWith(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      success: freezed == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as ImgurUploadData?,
    ));
  }

  /// Create a copy of ImgurUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImgurUploadDataCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $ImgurUploadDataCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ImgurUploadResponse].
extension ImgurUploadResponsePatterns on ImgurUploadResponse {
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
    TResult Function(_ImgurUploadResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadResponse() when $default != null:
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
    TResult Function(_ImgurUploadResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadResponse():
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
    TResult? Function(_ImgurUploadResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadResponse() when $default != null:
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
    TResult Function(int? status, bool? success, ImgurUploadData? data)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadResponse() when $default != null:
        return $default(_that.status, _that.success, _that.data);
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
    TResult Function(int? status, bool? success, ImgurUploadData? data)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadResponse():
        return $default(_that.status, _that.success, _that.data);
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
    TResult? Function(int? status, bool? success, ImgurUploadData? data)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadResponse() when $default != null:
        return $default(_that.status, _that.success, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ImgurUploadResponse extends ImgurUploadResponse {
  const _ImgurUploadResponse({this.status, this.success, this.data})
      : super._();
  factory _ImgurUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ImgurUploadResponseFromJson(json);

  @override
  final int? status;
  @override
  final bool? success;
  @override
  final ImgurUploadData? data;

  /// Create a copy of ImgurUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImgurUploadResponseCopyWith<_ImgurUploadResponse> get copyWith =>
      __$ImgurUploadResponseCopyWithImpl<_ImgurUploadResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImgurUploadResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImgurUploadResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, success, data);

  @override
  String toString() {
    return 'ImgurUploadResponse(status: $status, success: $success, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$ImgurUploadResponseCopyWith<$Res>
    implements $ImgurUploadResponseCopyWith<$Res> {
  factory _$ImgurUploadResponseCopyWith(_ImgurUploadResponse value,
          $Res Function(_ImgurUploadResponse) _then) =
      __$ImgurUploadResponseCopyWithImpl;
  @override
  @useResult
  $Res call({int? status, bool? success, ImgurUploadData? data});

  @override
  $ImgurUploadDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$ImgurUploadResponseCopyWithImpl<$Res>
    implements _$ImgurUploadResponseCopyWith<$Res> {
  __$ImgurUploadResponseCopyWithImpl(this._self, this._then);

  final _ImgurUploadResponse _self;
  final $Res Function(_ImgurUploadResponse) _then;

  /// Create a copy of ImgurUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = freezed,
    Object? success = freezed,
    Object? data = freezed,
  }) {
    return _then(_ImgurUploadResponse(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      success: freezed == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as ImgurUploadData?,
    ));
  }

  /// Create a copy of ImgurUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImgurUploadDataCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $ImgurUploadDataCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc
mixin _$ImgurUploadData {
  String? get id;
  String? get deletehash;
  dynamic get accountId;
  dynamic get accountUrl;
  dynamic get adType;
  dynamic get adUrl;
  dynamic get title;
  dynamic get description;
  String? get name;
  String? get type;
  int? get width;
  int? get height;
  int? get size;
  int? get views;
  dynamic get section;
  dynamic get vote;
  int? get bandwidth;
  bool? get animated;
  bool? get favorite;
  bool? get inGallery;
  bool? get inMostViral;
  bool? get hasSound;
  bool? get isAd;
  dynamic get nsfw;
  String? get link;
  List<dynamic>? get tags;
  int? get datetime;
  String? get mp4;
  String? get hls;

  /// Create a copy of ImgurUploadData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImgurUploadDataCopyWith<ImgurUploadData> get copyWith =>
      _$ImgurUploadDataCopyWithImpl<ImgurUploadData>(
          this as ImgurUploadData, _$identity);

  /// Serializes this ImgurUploadData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImgurUploadData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deletehash, deletehash) ||
                other.deletehash == deletehash) &&
            const DeepCollectionEquality().equals(other.accountId, accountId) &&
            const DeepCollectionEquality()
                .equals(other.accountUrl, accountUrl) &&
            const DeepCollectionEquality().equals(other.adType, adType) &&
            const DeepCollectionEquality().equals(other.adUrl, adUrl) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.views, views) || other.views == views) &&
            const DeepCollectionEquality().equals(other.section, section) &&
            const DeepCollectionEquality().equals(other.vote, vote) &&
            (identical(other.bandwidth, bandwidth) ||
                other.bandwidth == bandwidth) &&
            (identical(other.animated, animated) ||
                other.animated == animated) &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite) &&
            (identical(other.inGallery, inGallery) ||
                other.inGallery == inGallery) &&
            (identical(other.inMostViral, inMostViral) ||
                other.inMostViral == inMostViral) &&
            (identical(other.hasSound, hasSound) ||
                other.hasSound == hasSound) &&
            (identical(other.isAd, isAd) || other.isAd == isAd) &&
            const DeepCollectionEquality().equals(other.nsfw, nsfw) &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.mp4, mp4) || other.mp4 == mp4) &&
            (identical(other.hls, hls) || other.hls == hls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        deletehash,
        const DeepCollectionEquality().hash(accountId),
        const DeepCollectionEquality().hash(accountUrl),
        const DeepCollectionEquality().hash(adType),
        const DeepCollectionEquality().hash(adUrl),
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(description),
        name,
        type,
        width,
        height,
        size,
        views,
        const DeepCollectionEquality().hash(section),
        const DeepCollectionEquality().hash(vote),
        bandwidth,
        animated,
        favorite,
        inGallery,
        inMostViral,
        hasSound,
        isAd,
        const DeepCollectionEquality().hash(nsfw),
        link,
        const DeepCollectionEquality().hash(tags),
        datetime,
        mp4,
        hls
      ]);

  @override
  String toString() {
    return 'ImgurUploadData(id: $id, deletehash: $deletehash, accountId: $accountId, accountUrl: $accountUrl, adType: $adType, adUrl: $adUrl, title: $title, description: $description, name: $name, type: $type, width: $width, height: $height, size: $size, views: $views, section: $section, vote: $vote, bandwidth: $bandwidth, animated: $animated, favorite: $favorite, inGallery: $inGallery, inMostViral: $inMostViral, hasSound: $hasSound, isAd: $isAd, nsfw: $nsfw, link: $link, tags: $tags, datetime: $datetime, mp4: $mp4, hls: $hls)';
  }
}

/// @nodoc
abstract mixin class $ImgurUploadDataCopyWith<$Res> {
  factory $ImgurUploadDataCopyWith(
          ImgurUploadData value, $Res Function(ImgurUploadData) _then) =
      _$ImgurUploadDataCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String? deletehash,
      dynamic accountId,
      dynamic accountUrl,
      dynamic adType,
      dynamic adUrl,
      dynamic title,
      dynamic description,
      String? name,
      String? type,
      int? width,
      int? height,
      int? size,
      int? views,
      dynamic section,
      dynamic vote,
      int? bandwidth,
      bool? animated,
      bool? favorite,
      bool? inGallery,
      bool? inMostViral,
      bool? hasSound,
      bool? isAd,
      dynamic nsfw,
      String? link,
      List<dynamic>? tags,
      int? datetime,
      String? mp4,
      String? hls});
}

/// @nodoc
class _$ImgurUploadDataCopyWithImpl<$Res>
    implements $ImgurUploadDataCopyWith<$Res> {
  _$ImgurUploadDataCopyWithImpl(this._self, this._then);

  final ImgurUploadData _self;
  final $Res Function(ImgurUploadData) _then;

  /// Create a copy of ImgurUploadData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deletehash = freezed,
    Object? accountId = freezed,
    Object? accountUrl = freezed,
    Object? adType = freezed,
    Object? adUrl = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? size = freezed,
    Object? views = freezed,
    Object? section = freezed,
    Object? vote = freezed,
    Object? bandwidth = freezed,
    Object? animated = freezed,
    Object? favorite = freezed,
    Object? inGallery = freezed,
    Object? inMostViral = freezed,
    Object? hasSound = freezed,
    Object? isAd = freezed,
    Object? nsfw = freezed,
    Object? link = freezed,
    Object? tags = freezed,
    Object? datetime = freezed,
    Object? mp4 = freezed,
    Object? hls = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      deletehash: freezed == deletehash
          ? _self.deletehash
          : deletehash // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      accountUrl: freezed == accountUrl
          ? _self.accountUrl
          : accountUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      adType: freezed == adType
          ? _self.adType
          : adType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      adUrl: freezed == adUrl
          ? _self.adUrl
          : adUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      views: freezed == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as int?,
      section: freezed == section
          ? _self.section
          : section // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vote: freezed == vote
          ? _self.vote
          : vote // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bandwidth: freezed == bandwidth
          ? _self.bandwidth
          : bandwidth // ignore: cast_nullable_to_non_nullable
              as int?,
      animated: freezed == animated
          ? _self.animated
          : animated // ignore: cast_nullable_to_non_nullable
              as bool?,
      favorite: freezed == favorite
          ? _self.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      inGallery: freezed == inGallery
          ? _self.inGallery
          : inGallery // ignore: cast_nullable_to_non_nullable
              as bool?,
      inMostViral: freezed == inMostViral
          ? _self.inMostViral
          : inMostViral // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasSound: freezed == hasSound
          ? _self.hasSound
          : hasSound // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAd: freezed == isAd
          ? _self.isAd
          : isAd // ignore: cast_nullable_to_non_nullable
              as bool?,
      nsfw: freezed == nsfw
          ? _self.nsfw
          : nsfw // ignore: cast_nullable_to_non_nullable
              as dynamic,
      link: freezed == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      datetime: freezed == datetime
          ? _self.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as int?,
      mp4: freezed == mp4
          ? _self.mp4
          : mp4 // ignore: cast_nullable_to_non_nullable
              as String?,
      hls: freezed == hls
          ? _self.hls
          : hls // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImgurUploadData].
extension ImgurUploadDataPatterns on ImgurUploadData {
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
    TResult Function(_ImgurUploadData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadData() when $default != null:
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
    TResult Function(_ImgurUploadData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadData():
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
    TResult? Function(_ImgurUploadData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadData() when $default != null:
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
            String? id,
            String? deletehash,
            dynamic accountId,
            dynamic accountUrl,
            dynamic adType,
            dynamic adUrl,
            dynamic title,
            dynamic description,
            String? name,
            String? type,
            int? width,
            int? height,
            int? size,
            int? views,
            dynamic section,
            dynamic vote,
            int? bandwidth,
            bool? animated,
            bool? favorite,
            bool? inGallery,
            bool? inMostViral,
            bool? hasSound,
            bool? isAd,
            dynamic nsfw,
            String? link,
            List<dynamic>? tags,
            int? datetime,
            String? mp4,
            String? hls)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadData() when $default != null:
        return $default(
            _that.id,
            _that.deletehash,
            _that.accountId,
            _that.accountUrl,
            _that.adType,
            _that.adUrl,
            _that.title,
            _that.description,
            _that.name,
            _that.type,
            _that.width,
            _that.height,
            _that.size,
            _that.views,
            _that.section,
            _that.vote,
            _that.bandwidth,
            _that.animated,
            _that.favorite,
            _that.inGallery,
            _that.inMostViral,
            _that.hasSound,
            _that.isAd,
            _that.nsfw,
            _that.link,
            _that.tags,
            _that.datetime,
            _that.mp4,
            _that.hls);
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
            String? id,
            String? deletehash,
            dynamic accountId,
            dynamic accountUrl,
            dynamic adType,
            dynamic adUrl,
            dynamic title,
            dynamic description,
            String? name,
            String? type,
            int? width,
            int? height,
            int? size,
            int? views,
            dynamic section,
            dynamic vote,
            int? bandwidth,
            bool? animated,
            bool? favorite,
            bool? inGallery,
            bool? inMostViral,
            bool? hasSound,
            bool? isAd,
            dynamic nsfw,
            String? link,
            List<dynamic>? tags,
            int? datetime,
            String? mp4,
            String? hls)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadData():
        return $default(
            _that.id,
            _that.deletehash,
            _that.accountId,
            _that.accountUrl,
            _that.adType,
            _that.adUrl,
            _that.title,
            _that.description,
            _that.name,
            _that.type,
            _that.width,
            _that.height,
            _that.size,
            _that.views,
            _that.section,
            _that.vote,
            _that.bandwidth,
            _that.animated,
            _that.favorite,
            _that.inGallery,
            _that.inMostViral,
            _that.hasSound,
            _that.isAd,
            _that.nsfw,
            _that.link,
            _that.tags,
            _that.datetime,
            _that.mp4,
            _that.hls);
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
            String? id,
            String? deletehash,
            dynamic accountId,
            dynamic accountUrl,
            dynamic adType,
            dynamic adUrl,
            dynamic title,
            dynamic description,
            String? name,
            String? type,
            int? width,
            int? height,
            int? size,
            int? views,
            dynamic section,
            dynamic vote,
            int? bandwidth,
            bool? animated,
            bool? favorite,
            bool? inGallery,
            bool? inMostViral,
            bool? hasSound,
            bool? isAd,
            dynamic nsfw,
            String? link,
            List<dynamic>? tags,
            int? datetime,
            String? mp4,
            String? hls)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImgurUploadData() when $default != null:
        return $default(
            _that.id,
            _that.deletehash,
            _that.accountId,
            _that.accountUrl,
            _that.adType,
            _that.adUrl,
            _that.title,
            _that.description,
            _that.name,
            _that.type,
            _that.width,
            _that.height,
            _that.size,
            _that.views,
            _that.section,
            _that.vote,
            _that.bandwidth,
            _that.animated,
            _that.favorite,
            _that.inGallery,
            _that.inMostViral,
            _that.hasSound,
            _that.isAd,
            _that.nsfw,
            _that.link,
            _that.tags,
            _that.datetime,
            _that.mp4,
            _that.hls);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ImgurUploadData extends ImgurUploadData {
  const _ImgurUploadData(
      {this.id,
      this.deletehash,
      this.accountId,
      this.accountUrl,
      this.adType,
      this.adUrl,
      this.title,
      this.description,
      this.name,
      this.type,
      this.width,
      this.height,
      this.size,
      this.views,
      this.section,
      this.vote,
      this.bandwidth,
      this.animated,
      this.favorite,
      this.inGallery,
      this.inMostViral,
      this.hasSound,
      this.isAd,
      this.nsfw,
      this.link,
      final List<dynamic>? tags,
      this.datetime,
      this.mp4,
      this.hls})
      : _tags = tags,
        super._();
  factory _ImgurUploadData.fromJson(Map<String, dynamic> json) =>
      _$ImgurUploadDataFromJson(json);

  @override
  final String? id;
  @override
  final String? deletehash;
  @override
  final dynamic accountId;
  @override
  final dynamic accountUrl;
  @override
  final dynamic adType;
  @override
  final dynamic adUrl;
  @override
  final dynamic title;
  @override
  final dynamic description;
  @override
  final String? name;
  @override
  final String? type;
  @override
  final int? width;
  @override
  final int? height;
  @override
  final int? size;
  @override
  final int? views;
  @override
  final dynamic section;
  @override
  final dynamic vote;
  @override
  final int? bandwidth;
  @override
  final bool? animated;
  @override
  final bool? favorite;
  @override
  final bool? inGallery;
  @override
  final bool? inMostViral;
  @override
  final bool? hasSound;
  @override
  final bool? isAd;
  @override
  final dynamic nsfw;
  @override
  final String? link;
  final List<dynamic>? _tags;
  @override
  List<dynamic>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? datetime;
  @override
  final String? mp4;
  @override
  final String? hls;

  /// Create a copy of ImgurUploadData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImgurUploadDataCopyWith<_ImgurUploadData> get copyWith =>
      __$ImgurUploadDataCopyWithImpl<_ImgurUploadData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImgurUploadDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImgurUploadData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deletehash, deletehash) ||
                other.deletehash == deletehash) &&
            const DeepCollectionEquality().equals(other.accountId, accountId) &&
            const DeepCollectionEquality()
                .equals(other.accountUrl, accountUrl) &&
            const DeepCollectionEquality().equals(other.adType, adType) &&
            const DeepCollectionEquality().equals(other.adUrl, adUrl) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.views, views) || other.views == views) &&
            const DeepCollectionEquality().equals(other.section, section) &&
            const DeepCollectionEquality().equals(other.vote, vote) &&
            (identical(other.bandwidth, bandwidth) ||
                other.bandwidth == bandwidth) &&
            (identical(other.animated, animated) ||
                other.animated == animated) &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite) &&
            (identical(other.inGallery, inGallery) ||
                other.inGallery == inGallery) &&
            (identical(other.inMostViral, inMostViral) ||
                other.inMostViral == inMostViral) &&
            (identical(other.hasSound, hasSound) ||
                other.hasSound == hasSound) &&
            (identical(other.isAd, isAd) || other.isAd == isAd) &&
            const DeepCollectionEquality().equals(other.nsfw, nsfw) &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.mp4, mp4) || other.mp4 == mp4) &&
            (identical(other.hls, hls) || other.hls == hls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        deletehash,
        const DeepCollectionEquality().hash(accountId),
        const DeepCollectionEquality().hash(accountUrl),
        const DeepCollectionEquality().hash(adType),
        const DeepCollectionEquality().hash(adUrl),
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(description),
        name,
        type,
        width,
        height,
        size,
        views,
        const DeepCollectionEquality().hash(section),
        const DeepCollectionEquality().hash(vote),
        bandwidth,
        animated,
        favorite,
        inGallery,
        inMostViral,
        hasSound,
        isAd,
        const DeepCollectionEquality().hash(nsfw),
        link,
        const DeepCollectionEquality().hash(_tags),
        datetime,
        mp4,
        hls
      ]);

  @override
  String toString() {
    return 'ImgurUploadData(id: $id, deletehash: $deletehash, accountId: $accountId, accountUrl: $accountUrl, adType: $adType, adUrl: $adUrl, title: $title, description: $description, name: $name, type: $type, width: $width, height: $height, size: $size, views: $views, section: $section, vote: $vote, bandwidth: $bandwidth, animated: $animated, favorite: $favorite, inGallery: $inGallery, inMostViral: $inMostViral, hasSound: $hasSound, isAd: $isAd, nsfw: $nsfw, link: $link, tags: $tags, datetime: $datetime, mp4: $mp4, hls: $hls)';
  }
}

/// @nodoc
abstract mixin class _$ImgurUploadDataCopyWith<$Res>
    implements $ImgurUploadDataCopyWith<$Res> {
  factory _$ImgurUploadDataCopyWith(
          _ImgurUploadData value, $Res Function(_ImgurUploadData) _then) =
      __$ImgurUploadDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? deletehash,
      dynamic accountId,
      dynamic accountUrl,
      dynamic adType,
      dynamic adUrl,
      dynamic title,
      dynamic description,
      String? name,
      String? type,
      int? width,
      int? height,
      int? size,
      int? views,
      dynamic section,
      dynamic vote,
      int? bandwidth,
      bool? animated,
      bool? favorite,
      bool? inGallery,
      bool? inMostViral,
      bool? hasSound,
      bool? isAd,
      dynamic nsfw,
      String? link,
      List<dynamic>? tags,
      int? datetime,
      String? mp4,
      String? hls});
}

/// @nodoc
class __$ImgurUploadDataCopyWithImpl<$Res>
    implements _$ImgurUploadDataCopyWith<$Res> {
  __$ImgurUploadDataCopyWithImpl(this._self, this._then);

  final _ImgurUploadData _self;
  final $Res Function(_ImgurUploadData) _then;

  /// Create a copy of ImgurUploadData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? deletehash = freezed,
    Object? accountId = freezed,
    Object? accountUrl = freezed,
    Object? adType = freezed,
    Object? adUrl = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? size = freezed,
    Object? views = freezed,
    Object? section = freezed,
    Object? vote = freezed,
    Object? bandwidth = freezed,
    Object? animated = freezed,
    Object? favorite = freezed,
    Object? inGallery = freezed,
    Object? inMostViral = freezed,
    Object? hasSound = freezed,
    Object? isAd = freezed,
    Object? nsfw = freezed,
    Object? link = freezed,
    Object? tags = freezed,
    Object? datetime = freezed,
    Object? mp4 = freezed,
    Object? hls = freezed,
  }) {
    return _then(_ImgurUploadData(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      deletehash: freezed == deletehash
          ? _self.deletehash
          : deletehash // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      accountUrl: freezed == accountUrl
          ? _self.accountUrl
          : accountUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      adType: freezed == adType
          ? _self.adType
          : adType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      adUrl: freezed == adUrl
          ? _self.adUrl
          : adUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      views: freezed == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as int?,
      section: freezed == section
          ? _self.section
          : section // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vote: freezed == vote
          ? _self.vote
          : vote // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bandwidth: freezed == bandwidth
          ? _self.bandwidth
          : bandwidth // ignore: cast_nullable_to_non_nullable
              as int?,
      animated: freezed == animated
          ? _self.animated
          : animated // ignore: cast_nullable_to_non_nullable
              as bool?,
      favorite: freezed == favorite
          ? _self.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      inGallery: freezed == inGallery
          ? _self.inGallery
          : inGallery // ignore: cast_nullable_to_non_nullable
              as bool?,
      inMostViral: freezed == inMostViral
          ? _self.inMostViral
          : inMostViral // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasSound: freezed == hasSound
          ? _self.hasSound
          : hasSound // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAd: freezed == isAd
          ? _self.isAd
          : isAd // ignore: cast_nullable_to_non_nullable
              as bool?,
      nsfw: freezed == nsfw
          ? _self.nsfw
          : nsfw // ignore: cast_nullable_to_non_nullable
              as dynamic,
      link: freezed == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      datetime: freezed == datetime
          ? _self.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as int?,
      mp4: freezed == mp4
          ? _self.mp4
          : mp4 // ignore: cast_nullable_to_non_nullable
              as String?,
      hls: freezed == hls
          ? _self.hls
          : hls // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
