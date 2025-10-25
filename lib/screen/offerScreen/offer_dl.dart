// Path: lib/screen/offerScreen/offer_dl.dart

import 'package:json_annotation/json_annotation.dart';

part 'offer_dl.g.dart';

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class OfferResponse {
  int status;
  int messageCode;
  double offerMinBillAmount;
  double offerDiscount;
  int offerDiscountType;
  String message;

  OfferResponse({
    this.status = 0,
    this.messageCode = 0,
    this.offerMinBillAmount = 0,
    this.offerDiscount = 0,
    this.offerDiscountType = 0,
    this.message = "",
  });

  factory OfferResponse.fromJson(Map<String, dynamic> json) => _$OfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferResponseToJson(this);
}
