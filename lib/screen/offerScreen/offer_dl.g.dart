// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferResponse _$OfferResponseFromJson(Map<String, dynamic> json) =>
    OfferResponse(
      status: (json['status'] as num?)?.toInt() ?? 0,
      messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
      offerMinBillAmount:
          (json['offer_min_bill_amount'] as num?)?.toDouble() ?? 0,
      offerDiscount: (json['offer_discount'] as num?)?.toDouble() ?? 0,
      offerDiscountType: (json['offer_discount_type'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? "",
    );

Map<String, dynamic> _$OfferResponseToJson(OfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message_code': instance.messageCode,
      'offer_min_bill_amount': instance.offerMinBillAmount,
      'offer_discount': instance.offerDiscount,
      'offer_discount_type': instance.offerDiscountType,
      'message': instance.message,
    };
