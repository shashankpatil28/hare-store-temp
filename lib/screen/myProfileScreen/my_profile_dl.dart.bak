// Path: lib/screen/myProfileScreen/my_profile_dl.dart

import 'package:json_annotation/json_annotation.dart';

part 'my_profile_dl.g.dart';

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class ProfileResponse {
  int status;
  int providerGender;
  int messageCode;
  String message;
  String providerProfileImage;
  String email;
  String selectCountryCode;
  String storeProviderName;
  String contactNumber;

  ProfileResponse({
    this.status = 0,
    this.providerGender = 0,
    this.messageCode = 0,
    this.message = "",
    this.providerProfileImage = "",
    this.email = "",
    this.selectCountryCode = "",
    this.storeProviderName = "",
    this.contactNumber = "",
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

//Command: flutter pub run build_runner build --delete-conflicting-outputs
