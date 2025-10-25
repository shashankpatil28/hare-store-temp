// Path: lib/screen/ordersHistoryScreen/order_history_dl.dart

import 'package:json_annotation/json_annotation.dart';

part 'order_history_dl.g.dart';

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class OrderHistoryResponse {
  int status;
  int messageCode;
  int currentPage;
  int lastPage;
  int total;
  int pendingOrder;
  int completedOrder;
  int canceledOrder;
  double pendingPayments;
  String message;
  List<OrderHistoryItem> orderHistory = [];

  OrderHistoryResponse({
    this.status = 0,
    this.messageCode = 0,
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.pendingOrder = 0,
    this.completedOrder = 0,
    this.canceledOrder = 0,
    this.pendingPayments = 0,
    this.message = "",
    List<OrderHistoryItem>? orderHistory,
  }) {
    this.orderHistory = orderHistory ?? [];
  }

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) => _$OrderHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryResponseToJson(this);
}

@JsonSerializable(createToJson: true, includeIfNull: false, fieldRename: FieldRename.snake, explicitToJson: true)
class OrderHistoryItem {
  String customerName;
  String orderDateTime;
  String orderProductList;
  String scheduleOrderDateTime;
  int orderNo;
  int orderId;
  double totalAmount;
  double storeTotalAmount;
  int orderStatus;
  int storePaySettleStatus;

  OrderHistoryItem({
    this.customerName = "",
    this.orderDateTime = "",
    this.orderProductList = "",
    this.scheduleOrderDateTime = "",
    this.orderNo = 0,
    this.orderId = 0,
    this.totalAmount = 0,
    this.storeTotalAmount = 0,
    this.orderStatus = 0,
    this.storePaySettleStatus = 0,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) => _$OrderHistoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryItemToJson(this);
}
