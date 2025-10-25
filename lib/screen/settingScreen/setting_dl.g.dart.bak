// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) => SettingModel(
  status: (json['status'] as num?)?.toInt() ?? 0,
  message: json['message'] as String? ?? "",
  messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
  etaDeliveryTime: (json['eta_delivery_time'] as num?)?.toDouble() ?? 0,
  orderMinAmount: (json['order_min_amount'] as num?)?.toDouble() ?? 0,
  packagingCharges: (json['packaging_charges'] as num?)?.toDouble() ?? 0,
  serviceRadius: (json['service_radius'] as num?)?.toDouble() ?? 0,
  storeTimings: (json['store_timings'] as List<dynamic>?)
      ?.map((e) => StoreTimings.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'message_code': instance.messageCode,
      'eta_delivery_time': instance.etaDeliveryTime,
      'order_min_amount': instance.orderMinAmount,
      'packaging_charges': instance.packagingCharges,
      'service_radius': instance.serviceRadius,
      'store_timings': instance.storeTimings.map((e) => e.toJson()).toList(),
    };

StoreTimings _$StoreTimingsFromJson(Map<String, dynamic> json) => StoreTimings(
  day: json['day'] as String? ?? "",
  openTime: json['open_time'] as String? ?? "",
  closeTime: json['close_time'] as String? ?? "",
  displayDay: json['display_day'] as String? ?? "",
  isCheck: json['isCheck'] as bool? ?? false,
);

Map<String, dynamic> _$StoreTimingsToJson(StoreTimings instance) =>
    <String, dynamic>{
      'day': instance.day,
      'display_day': instance.displayDay,
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'isCheck': instance.isCheck,
    };
