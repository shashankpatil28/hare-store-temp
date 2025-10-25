// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPojo _$LoginPojoFromJson(Map<String, dynamic> json) => LoginPojo(
  storeId: (json['store_id'] as num?)?.toInt() ?? 0,
  providerId: (json['provider_id'] as num?)?.toInt() ?? 0,
  status: (json['status'] as num?)?.toInt() ?? 0,
  storeServiceId: (json['store_service_id'] as num?)?.toInt() ?? 0,
  messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
  providerGender: (json['provider_gender'] as num?)?.toInt() ?? 0,
  serviceCurrentStatus: (json['service_current_status'] as num?)?.toInt() ?? 0,
  storeVerified: (json['store_verified'] as num?)?.toInt() ?? 0,
  serviceStatus: (json['service_status'] as num?)?.toInt() ?? 0,
  storeBanner: json['store_banner'] as String? ?? "",
  loginType: json['login_type'] as String? ?? "",
  serviceMessage: json['service_message'] as String? ?? "",
  message: json['message'] as String? ?? "",
  contactNumber: json['contact_number'] as String? ?? "",
  accessToken: json['access_token'] as String? ?? "",
  serviceCategoryName: json['service_category_name'] as String? ?? "",
  storeName: json['store_name'] as String? ?? "",
  providerProfileImage: json['provider_profile_image'] as String? ?? "",
  storeProviderName: json['store_provider_name'] as String? ?? "",
  email: json['email'] as String? ?? "",
  selectCountryCode: json['select_country_code'] as String? ?? "",
  selectCurrency: json['select_currency'] as String? ?? "",
  selectLanguage: json['select_language'] as String? ?? "",
  serverTimeZone: json['server_time_zone'] as String? ?? "",
);

Map<String, dynamic> _$LoginPojoToJson(LoginPojo instance) => <String, dynamic>{
  'store_id': instance.storeId,
  'provider_id': instance.providerId,
  'status': instance.status,
  'store_service_id': instance.storeServiceId,
  'message_code': instance.messageCode,
  'provider_gender': instance.providerGender,
  'service_current_status': instance.serviceCurrentStatus,
  'store_verified': instance.storeVerified,
  'service_status': instance.serviceStatus,
  'store_banner': instance.storeBanner,
  'login_type': instance.loginType,
  'service_message': instance.serviceMessage,
  'message': instance.message,
  'contact_number': instance.contactNumber,
  'access_token': instance.accessToken,
  'service_category_name': instance.serviceCategoryName,
  'store_name': instance.storeName,
  'provider_profile_image': instance.providerProfileImage,
  'store_provider_name': instance.storeProviderName,
  'email': instance.email,
  'select_country_code': instance.selectCountryCode,
  'select_currency': instance.selectCurrency,
  'select_language': instance.selectLanguage,
  'server_time_zone': instance.serverTimeZone,
};

ForgotRequestModel _$ForgotRequestModelFromJson(Map<String, dynamic> json) =>
    ForgotRequestModel(
      message: json['message'] as String? ?? "",
      status: (json['status'] as num?)?.toInt() ?? 0,
      messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
      storeId: (json['store_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ForgotRequestModelToJson(ForgotRequestModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'message_code': instance.messageCode,
      'store_id': instance.storeId,
    };
