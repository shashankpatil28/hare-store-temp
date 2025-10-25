// Path: lib/screen/orderDetailScreen/order_detail_dl.dart

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail_dl.g.dart';

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class OrderDetailResponse {
  String deliveryAddress;
  String instruction;
  String orderDateTime;
  String orderDate;
  String orderTime;
  String message;
  String customerName;
  String customerContact;
  String customerImage;
  String scheduleOrderDateTime;
  String scheduleOrderDate;
  String scheduleOrderTime;
  String additionalRemark;
  String deliveryPersonName;
  String deliveryPersonImage;
  String deliveryPersonContactNo;
  String driverSelectedServiceString;
  String cancelBy;
  String? cancelReason;
  String promocodeName;
  String customerFcmToken;
  String? prescription;
  int orderType;
  int userTakenType;
  int orderStatus;
  int orderDeliveryStatus;
  double orderItemTotal;
  double orderDiscountCost;
  double orderDeliveryCost;
  double orderPackagingCost;
  double orderTax;
  double orderTotalPay;
  double referDiscount;
  double promocodeDiscount;
  int paymentType;
  int driverId;
  double deliveryPersonRating;
  int storePaySettleStatus;
  int status;
  int messageCode;
  int orderId;
  int orderNo;
  int userId;
  String flatNo;
  String landmark;
  List<ItemList> itemList;

  OrderDetailResponse({
    this.deliveryAddress = "----",
    this.instruction = "",
    this.orderDateTime = "",
    this.orderDate = "",
    this.orderTime = "",
    this.message = "",
    this.customerName = "",
    this.customerContact = "",
    this.customerImage = "",
    this.scheduleOrderDateTime = "",
    this.scheduleOrderDate = "",
    this.scheduleOrderTime = "",
    this.additionalRemark = "",
    this.deliveryPersonName = "",
    this.deliveryPersonImage = "",
    this.deliveryPersonContactNo = "",
    this.driverSelectedServiceString = "",
    this.cancelBy = "",
    this.cancelReason,
    this.promocodeName = "",
    this.customerFcmToken = "",
    this.prescription,
    this.orderType = 0,
    this.userTakenType = 0,
    this.orderStatus = 0,
    this.orderDeliveryStatus = 0,
    this.orderItemTotal = 0,
    this.orderDiscountCost = 0,
    this.orderDeliveryCost = 0,
    this.orderPackagingCost = 0,
    this.orderTax = 0,
    this.orderTotalPay = 0,
    this.paymentType = 0,
    this.driverId = 0,
    this.deliveryPersonRating = 0,
    this.storePaySettleStatus = 0,
    this.promocodeDiscount = 0,
    this.status = 0,
    this.messageCode = 0,
    this.orderId = 0,
    this.orderNo = 0,
    this.userId = 0,
    this.referDiscount = 0,
    this.flatNo = "",
    this.landmark = "",
    List<ItemList>? itemList,
  }) : itemList = itemList ?? [];

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class ItemList {
  int productId;
  int foodType;
  int quantity;
  double priceForOne;
  double productPrice;
  int size;
  int color;
  List<OptionList> options;
  String productName;
  String EAN;

  ItemList({
    this.productId = 0,
    this.foodType = 0,
    this.quantity = 0,
    this.priceForOne = 0,
    this.productPrice = 0,
    this.size = 0,
    this.color = 0,
    List<OptionList>? options,
    this.productName = "",
    this.EAN = "",
  }) : options = options ?? [];

  factory ItemList.fromJson(Map<String, dynamic> json) => _$ItemListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class OptionList {
  int optionId;
  String optionName;
  int optionAmount;

  OptionList({
    this.optionId = 0,
    this.optionName = "",
    this.optionAmount = 0,
  });

  factory OptionList.fromJson(Map<String, dynamic> json) => _$OptionListFromJson(json);
  Map<String, dynamic> toJson() => _$OptionListToJson(this);
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class NotificationPojo {
  String clickAction;
  String title;
  String body;
  String sound;
  String message;
  int titleCode;
  int orderStatus;
  int messageCode;
  int orderId;
  int notificationType;

  NotificationPojo({
    this.clickAction = "",
    this.title = "",
    this.body = "",
    this.sound = "",
    this.message = "",
    this.titleCode = 0,
    this.orderStatus = 0,
    this.messageCode = 0,
    this.orderId = 0,
    this.notificationType = 0,
  });

  factory NotificationPojo.fromJson(Map<String, dynamic> json) => _$NotificationPojoFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationPojoToJson(this);
  String toJsonString() => jsonEncode(toJson());
}
