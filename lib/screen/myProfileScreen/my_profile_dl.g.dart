// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      status: (json['status'] as num?)?.toInt() ?? 0,
      providerGender: (json['provider_gender'] as num?)?.toInt() ?? 0,
      messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? "",
      providerProfileImage: json['provider_profile_image'] as String? ?? "",
      email: json['email'] as String? ?? "",
      selectCountryCode: json['select_country_code'] as String? ?? "",
      storeProviderName: json['store_provider_name'] as String? ?? "",
      contactNumber: json['contact_number'] as String? ?? "",
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'provider_gender': instance.providerGender,
      'message_code': instance.messageCode,
      'message': instance.message,
      'provider_profile_image': instance.providerProfileImage,
      'email': instance.email,
      'select_country_code': instance.selectCountryCode,
      'store_provider_name': instance.storeProviderName,
      'contact_number': instance.contactNumber,
    };
