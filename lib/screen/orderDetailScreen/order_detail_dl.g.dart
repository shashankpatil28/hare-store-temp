// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailResponse _$OrderDetailResponseFromJson(
  Map<String, dynamic> json,
) => OrderDetailResponse(
  deliveryAddress: json['delivery_address'] as String? ?? "----",
  instruction: json['instruction'] as String? ?? "",
  orderDateTime: json['order_date_time'] as String? ?? "",
  orderDate: json['order_date'] as String? ?? "",
  orderTime: json['order_time'] as String? ?? "",
  message: json['message'] as String? ?? "",
  customerName: json['customer_name'] as String? ?? "",
  customerContact: json['customer_contact'] as String? ?? "",
  customerImage: json['customer_image'] as String? ?? "",
  scheduleOrderDateTime: json['schedule_order_date_time'] as String? ?? "",
  scheduleOrderDate: json['schedule_order_date'] as String? ?? "",
  scheduleOrderTime: json['schedule_order_time'] as String? ?? "",
  additionalRemark: json['additional_remark'] as String? ?? "",
  deliveryPersonName: json['delivery_person_name'] as String? ?? "",
  deliveryPersonImage: json['delivery_person_image'] as String? ?? "",
  deliveryPersonContactNo: json['delivery_person_contact_no'] as String? ?? "",
  driverSelectedServiceString:
      json['driver_selected_service_string'] as String? ?? "",
  cancelBy: json['cancel_by'] as String? ?? "",
  cancelReason: json['cancel_reason'] as String?,
  promocodeName: json['promocode_name'] as String? ?? "",
  customerFcmToken: json['customer_fcm_token'] as String? ?? "",
  prescription: json['prescription'] as String?,
  orderType: (json['order_type'] as num?)?.toInt() ?? 0,
  userTakenType: (json['user_taken_type'] as num?)?.toInt() ?? 0,
  orderStatus: (json['order_status'] as num?)?.toInt() ?? 0,
  orderDeliveryStatus: (json['order_delivery_status'] as num?)?.toInt() ?? 0,
  orderItemTotal: (json['order_item_total'] as num?)?.toDouble() ?? 0,
  orderDiscountCost: (json['order_discount_cost'] as num?)?.toDouble() ?? 0,
  orderDeliveryCost: (json['order_delivery_cost'] as num?)?.toDouble() ?? 0,
  orderPackagingCost: (json['order_packaging_cost'] as num?)?.toDouble() ?? 0,
  orderTax: (json['order_tax'] as num?)?.toDouble() ?? 0,
  orderTotalPay: (json['order_total_pay'] as num?)?.toDouble() ?? 0,
  paymentType: (json['payment_type'] as num?)?.toInt() ?? 0,
  driverId: (json['driver_id'] as num?)?.toInt() ?? 0,
  deliveryPersonRating:
      (json['delivery_person_rating'] as num?)?.toDouble() ?? 0,
  storePaySettleStatus: (json['store_pay_settle_status'] as num?)?.toInt() ?? 0,
  promocodeDiscount: (json['promocode_discount'] as num?)?.toDouble() ?? 0,
  status: (json['status'] as num?)?.toInt() ?? 0,
  messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
  orderId: (json['order_id'] as num?)?.toInt() ?? 0,
  orderNo: (json['order_no'] as num?)?.toInt() ?? 0,
  userId: (json['user_id'] as num?)?.toInt() ?? 0,
  referDiscount: (json['refer_discount'] as num?)?.toDouble() ?? 0,
  flatNo: json['flat_no'] as String? ?? "",
  landmark: json['landmark'] as String? ?? "",
  itemList: (json['item_list'] as List<dynamic>?)
      ?.map((e) => ItemList.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderDetailResponseToJson(
  OrderDetailResponse instance,
) => <String, dynamic>{
  'delivery_address': instance.deliveryAddress,
  'instruction': instance.instruction,
  'order_date_time': instance.orderDateTime,
  'order_date': instance.orderDate,
  'order_time': instance.orderTime,
  'message': instance.message,
  'customer_name': instance.customerName,
  'customer_contact': instance.customerContact,
  'customer_image': instance.customerImage,
  'schedule_order_date_time': instance.scheduleOrderDateTime,
  'schedule_order_date': instance.scheduleOrderDate,
  'schedule_order_time': instance.scheduleOrderTime,
  'additional_remark': instance.additionalRemark,
  'delivery_person_name': instance.deliveryPersonName,
  'delivery_person_image': instance.deliveryPersonImage,
  'delivery_person_contact_no': instance.deliveryPersonContactNo,
  'driver_selected_service_string': instance.driverSelectedServiceString,
  'cancel_by': instance.cancelBy,
  'cancel_reason': ?instance.cancelReason,
  'promocode_name': instance.promocodeName,
  'customer_fcm_token': instance.customerFcmToken,
  'prescription': ?instance.prescription,
  'order_type': instance.orderType,
  'user_taken_type': instance.userTakenType,
  'order_status': instance.orderStatus,
  'order_delivery_status': instance.orderDeliveryStatus,
  'order_item_total': instance.orderItemTotal,
  'order_discount_cost': instance.orderDiscountCost,
  'order_delivery_cost': instance.orderDeliveryCost,
  'order_packaging_cost': instance.orderPackagingCost,
  'order_tax': instance.orderTax,
  'order_total_pay': instance.orderTotalPay,
  'refer_discount': instance.referDiscount,
  'promocode_discount': instance.promocodeDiscount,
  'payment_type': instance.paymentType,
  'driver_id': instance.driverId,
  'delivery_person_rating': instance.deliveryPersonRating,
  'store_pay_settle_status': instance.storePaySettleStatus,
  'status': instance.status,
  'message_code': instance.messageCode,
  'order_id': instance.orderId,
  'order_no': instance.orderNo,
  'user_id': instance.userId,
  'flat_no': instance.flatNo,
  'landmark': instance.landmark,
  'item_list': instance.itemList.map((e) => e.toJson()).toList(),
};

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
  productId: (json['product_id'] as num?)?.toInt() ?? 0,
  foodType: (json['food_type'] as num?)?.toInt() ?? 0,
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  priceForOne: (json['price_for_one'] as num?)?.toDouble() ?? 0,
  productPrice: (json['product_price'] as num?)?.toDouble() ?? 0,
  size: (json['size'] as num?)?.toInt() ?? 0,
  color: (json['color'] as num?)?.toInt() ?? 0,
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => OptionList.fromJson(e as Map<String, dynamic>))
      .toList(),
  productName: json['product_name'] as String? ?? "",
  EAN: json['e_a_n'] as String? ?? "",
);

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
  'product_id': instance.productId,
  'food_type': instance.foodType,
  'quantity': instance.quantity,
  'price_for_one': instance.priceForOne,
  'product_price': instance.productPrice,
  'size': instance.size,
  'color': instance.color,
  'options': instance.options.map((e) => e.toJson()).toList(),
  'product_name': instance.productName,
  'e_a_n': instance.EAN,
};

OptionList _$OptionListFromJson(Map<String, dynamic> json) => OptionList(
  optionId: (json['option_id'] as num?)?.toInt() ?? 0,
  optionName: json['option_name'] as String? ?? "",
  optionAmount: (json['option_amount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$OptionListToJson(OptionList instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'option_name': instance.optionName,
      'option_amount': instance.optionAmount,
    };

NotificationPojo _$NotificationPojoFromJson(Map<String, dynamic> json) =>
    NotificationPojo(
      clickAction: json['click_action'] as String? ?? "",
      title: json['title'] as String? ?? "",
      body: json['body'] as String? ?? "",
      sound: json['sound'] as String? ?? "",
      message: json['message'] as String? ?? "",
      titleCode: (json['title_code'] as num?)?.toInt() ?? 0,
      orderStatus: (json['order_status'] as num?)?.toInt() ?? 0,
      messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
      orderId: (json['order_id'] as num?)?.toInt() ?? 0,
      notificationType: (json['notification_type'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$NotificationPojoToJson(NotificationPojo instance) =>
    <String, dynamic>{
      'click_action': instance.clickAction,
      'title': instance.title,
      'body': instance.body,
      'sound': instance.sound,
      'message': instance.message,
      'title_code': instance.titleCode,
      'order_status': instance.orderStatus,
      'message_code': instance.messageCode,
      'order_id': instance.orderId,
      'notification_type': instance.notificationType,
    };
