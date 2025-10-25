// Path: lib/screen/loginScreen/login_dl.dart

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_dl.g.dart';

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class LoginPojo {
  int storeId;
  int providerId;
  int status;
  int storeServiceId;
  int messageCode;
  int providerGender;
  int serviceCurrentStatus;
  int storeVerified;
  int serviceStatus;
  String storeBanner;
  String loginType;
  String serviceMessage;
  String message;
  String contactNumber;
  String accessToken;
  String serviceCategoryName;
  String storeName;
  String providerProfileImage;
  String storeProviderName;
  String email;
  String selectCountryCode;
  String selectCurrency;
  String selectLanguage;
  String serverTimeZone;

  LoginPojo({
    this.storeId = 0,
    this.providerId = 0,
    this.status = 0,
    this.storeServiceId = 0,
    this.messageCode = 0,
    this.providerGender = 0,
    this.serviceCurrentStatus = 0,
    this.storeVerified = 0,
    this.serviceStatus = 0,
    this.storeBanner = "",
    this.loginType = "",
    this.serviceMessage = "",
    this.message = "",
    this.contactNumber = "",
    this.accessToken = "",
    this.serviceCategoryName = "",
    this.storeName = "",
    this.providerProfileImage = "",
    this.storeProviderName = "",
    this.email = "",
    this.selectCountryCode = "",
    this.selectCurrency = "",
    this.selectLanguage = "",
    this.serverTimeZone = "",
  });

  factory LoginPojo.fromJson(Map<String, dynamic> json) =>
      _$LoginPojoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPojoToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class ForgotRequestModel {
  String message;
  int status;
  int messageCode;
  int storeId;

  ForgotRequestModel(
      {this.message = "",
      this.status = 0,
      this.messageCode = 0,
      this.storeId = 0});

  factory ForgotRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotRequestModelToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

//Command: flutter pub run build_runner build --delete-conflicting-outputs