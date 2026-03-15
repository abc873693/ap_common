import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_model.freezed.dart';

@freezed
abstract class PhoneModel with _$PhoneModel {
  const factory PhoneModel(
    String name,
    String number,
  ) = _PhoneModel;
}
