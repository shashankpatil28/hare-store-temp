// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
  status: (json['status'] as num?)?.toInt() ?? 0,
  messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
  message: json['message'] as String? ?? "",
  pendingOrders: (json['pending_orders'] as List<dynamic>?)
      ?.map((e) => OrdersItems.fromJson(e as Map<String, dynamic>))
      .toList(),
  acceptedOrders: (json['accepted_orders'] as List<dynamic>?)
      ?.map((e) => OrdersItems.fromJson(e as Map<String, dynamic>))
      .toList(),
  processingOrder: (json['processing_order'] as List<dynamic>?)
      ?.map((e) => OrdersItems.fromJson(e as Map<String, dynamic>))
      .toList(),
  dispatchedOrder: (json['dispatched_order'] as List<dynamic>?)
      ?.map((e) => OrdersItems.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HomeResponseToJson(
  HomeResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message_code': instance.messageCode,
  'message': instance.message,
  'pending_orders': instance.pendingOrders.map((e) => e.toJson()).toList(),
  'accepted_orders': instance.acceptedOrders.map((e) => e.toJson()).toList(),
  'processing_order': instance.processingOrder.map((e) => e.toJson()).toList(),
  'dispatched_order': instance.dispatchedOrder.map((e) => e.toJson()).toList(),
};

ProviderStoreResponse _$ProviderStoreResponseFromJson(
  Map<String, dynamic> json,
) => ProviderStoreResponse(
  status: (json['status'] as num?)?.toInt() ?? 0,
  messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
  message: json['message'] as String? ?? "",
  providerStoreList: (json['provider_store_list'] as List<dynamic>?)
      ?.map((e) => StoreItems.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProviderStoreResponseToJson(
  ProviderStoreResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message_code': instance.messageCode,
  'message': instance.message,
  'provider_store_list': instance.providerStoreList
      .map((e) => e.toJson())
      .toList(),
};

StoreItems _$StoreItemsFromJson(Map<String, dynamic> json) => StoreItems(
  providerServiceiId: (json['provider_servicei_id'] as num?)?.toInt() ?? 0,
  storeStatus: (json['store_status'] as num?)?.toInt() ?? 0,
  storeName: json['store_name'] as String? ?? "",
  storeImage: json['store_image'] as String? ?? "",
  storeAddress: json['store_address'] as String? ?? "",
  serviceCategoryName: json['service_category_name'] as String? ?? "",
);

Map<String, dynamic> _$StoreItemsToJson(StoreItems instance) =>
    <String, dynamic>{
      'provider_servicei_id': instance.providerServiceiId,
      'store_status': instance.storeStatus,
      'store_name': instance.storeName,
      'store_address': instance.storeAddress,
      'store_image': instance.storeImage,
      'service_category_name': instance.serviceCategoryName,
    };

OrdersItems _$OrdersItemsFromJson(Map<String, dynamic> json) => OrdersItems(
  orderId: (json['order_id'] as num?)?.toInt() ?? 0,
  totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
  orderStatus: (json['order_status'] as num?)?.toInt() ?? 0,
  orderType: (json['order_type'] as num?)?.toInt() ?? 0,
  userTakenType: (json['user_taken_type'] as num?)?.toInt() ?? 0,
  paymentType: (json['payment_type'] as num?)?.toInt() ?? 0,
  orderNo: (json['order_no'] as num?)?.toInt() ?? 0,
  scheduleOrderDateTime: json['schedule_order_date_time'] as String? ?? "",
  scheduleOrderDate: json['schedule_order_date'] as String? ?? "",
  scheduleOrderTime: json['schedule_order_time'] as String? ?? "",
  orderProductList: json['order_product_list'] as String? ?? "",
  customerName: json['customer_name'] as String? ?? "",
  deliveryAddress: json['delivery_address'] as String? ?? "",
);

Map<String, dynamic> _$OrdersItemsToJson(OrdersItems instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'total_amount': instance.totalAmount,
      'order_status': instance.orderStatus,
      'order_type': instance.orderType,
      'user_taken_type': instance.userTakenType,
      'payment_type': instance.paymentType,
      'order_no': instance.orderNo,
      'schedule_order_date_time': instance.scheduleOrderDateTime,
      'schedule_order_date': instance.scheduleOrderDate,
      'schedule_order_time': instance.scheduleOrderTime,
      'order_product_list': instance.orderProductList,
      'customer_name': instance.customerName,
      'delivery_address': instance.deliveryAddress,
    };
