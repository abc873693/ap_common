import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_info.freezed.dart';

@freezed
abstract class VersionInfo with _$VersionInfo {
  const factory VersionInfo({
    required int code,
    required bool isForceUpdate,
    required String content,
  }) = _VersionInfo;
}
