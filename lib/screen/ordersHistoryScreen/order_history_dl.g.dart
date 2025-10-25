// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_dl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryResponse _$OrderHistoryResponseFromJson(
  Map<String, dynamic> json,
) => OrderHistoryResponse(
  status: (json['status'] as num?)?.toInt() ?? 0,
  messageCode: (json['message_code'] as num?)?.toInt() ?? 0,
  currentPage: (json['current_page'] as num?)?.toInt() ?? 0,
  lastPage: (json['last_page'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
  pendingOrder: (json['pending_order'] as num?)?.toInt() ?? 0,
  completedOrder: (json['completed_order'] as num?)?.toInt() ?? 0,
  canceledOrder: (json['canceled_order'] as num?)?.toInt() ?? 0,
  pendingPayments: (json['pending_payments'] as num?)?.toDouble() ?? 0,
  message: json['message'] as String? ?? "",
  orderHistory: (json['order_history'] as List<dynamic>?)
      ?.map((e) => OrderHistoryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderHistoryResponseToJson(
  OrderHistoryResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message_code': instance.messageCode,
  'current_page': instance.currentPage,
  'last_page': instance.lastPage,
  'total': instance.total,
  'pending_order': instance.pendingOrder,
  'completed_order': instance.completedOrder,
  'canceled_order': instance.canceledOrder,
  'pending_payments': instance.pendingPayments,
  'message': instance.message,
  'order_history': instance.orderHistory.map((e) => e.toJson()).toList(),
};

OrderHistoryItem _$OrderHistoryItemFromJson(Map<String, dynamic> json) =>
    OrderHistoryItem(
      customerName: json['customer_name'] as String? ?? "",
      orderDateTime: json['order_date_time'] as String? ?? "",
      orderProductList: json['order_product_list'] as String? ?? "",
      scheduleOrderDateTime: json['schedule_order_date_time'] as String? ?? "",
      orderNo: (json['order_no'] as num?)?.toInt() ?? 0,
      orderId: (json['order_id'] as num?)?.toInt() ?? 0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
      storeTotalAmount: (json['store_total_amount'] as num?)?.toDouble() ?? 0,
      orderStatus: (json['order_status'] as num?)?.toInt() ?? 0,
      storePaySettleStatus:
          (json['store_pay_settle_status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OrderHistoryItemToJson(OrderHistoryItem instance) =>
    <String, dynamic>{
      'customer_name': instance.customerName,
      'order_date_time': instance.orderDateTime,
      'order_product_list': instance.orderProductList,
      'schedule_order_date_time': instance.scheduleOrderDateTime,
      'order_no': instance.orderNo,
      'order_id': instance.orderId,
      'total_amount': instance.totalAmount,
      'store_total_amount': instance.storeTotalAmount,
      'order_status': instance.orderStatus,
      'store_pay_settle_status': instance.storePaySettleStatus,
    };
