// Path: lib/screen/settingScreen/setting_dl.dart

import 'package:json_annotation/json_annotation.dart';

part 'setting_dl.g.dart';

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class SettingModel {
  int status;
  String message;
  int messageCode;
  double etaDeliveryTime;
  double orderMinAmount;
  double packagingCharges;
  double serviceRadius;
  List<StoreTimings> storeTimings = [];

  SettingModel({
    this.status = 0,
    this.message = "",
    this.messageCode = 0,
    this.etaDeliveryTime = 0,
    this.orderMinAmount = 0,
    this.packagingCharges = 0,
    this.serviceRadius = 0,
    List<StoreTimings>? storeTimings,
  }) {
    this.storeTimings = storeTimings ?? [];
  }

  factory SettingModel.fromJson(Map<String, dynamic> json) => _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class StoreTimings {
  String day;
  String displayDay;
  String openTime;
  String closeTime;
  @JsonKey(name: "isCheck")
  bool isCheck = false;

  StoreTimings({this.day = "", this.openTime = "", this.closeTime = "", this.displayDay = "", this.isCheck = false});

  factory StoreTimings.fromJson(Map<String, dynamic> json) => _$StoreTimingsFromJson(json);

  Map<String, dynamic> toJson() => _$StoreTimingsToJson(this);
}
