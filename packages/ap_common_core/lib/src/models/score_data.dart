import 'dart:convert';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_data.freezed.dart';
part 'score_data.g.dart';

@freezed
abstract class ScoreData with _$ScoreData {
  const ScoreData._();

  const factory ScoreData({
    required List<Score> scores,
    required Detail detail,
  }) = _ScoreData;

  factory ScoreData.empty() => ScoreData(
        scores: <Score>[],
        detail: Detail.empty(),
      );

  factory ScoreData.fromJson(Map<String, dynamic> json) =>
      _$ScoreDataFromJson(json);

  factory ScoreData.fromRawJson(String str) => ScoreData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static ScoreData? load(String tag) {
    final String rawString = PreferenceUtil.instance.getString(
      '${ApConstants.packageName}'
          '.score_data_$tag',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return ScoreData.fromRawJson(rawString);
    }
  }

  String toRawJson() => jsonEncode(toJson());

  void save(String tag) {
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      '.score_data_$tag',
      toRawJson(),
    );
  }
}

@freezed
abstract class Detail with _$Detail {
  const Detail._();

  const factory Detail({
    double? creditTaken,
    double? creditEarned,
    double? average,
    String? classRank,
    String? departmentRank,
    double? classPercentage,
    double? conduct,
  }) = _Detail;

  factory Detail.empty() => const Detail(
        creditTaken: 0.0,
        creditEarned: 0.0,
        average: 0.0,
        classRank: '',
        departmentRank: '',
      );

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  factory Detail.fromRawJson(String str) => Detail.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@freezed
abstract class Score with _$Score {
  const Score._();

  const factory Score({
    required String? courseNumber,
    @Default(false) bool isPreScore,
    required String title,
    required String units,
    required String? hours,
    required String? required,
    required String? at,
    required String? middleScore,
    required String? generalScore,
    required String? finalScore,
    required String? semesterScore,
    required String? remark,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  factory Score.fromRawJson(String str) => Score.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}
