// Path: lib/screen/homeScreen/home_dl.dart

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_dl.g.dart';

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class HomeResponse {
  int status;
  int messageCode;
  String message;
  List<OrdersItems> pendingOrders = [];
  List<OrdersItems> acceptedOrders = [];
  List<OrdersItems> processingOrder = [];
  List<OrdersItems> dispatchedOrder = [];

  HomeResponse({
    this.status = 0,
    this.messageCode = 0,
    this.message = "",
    List<OrdersItems>? pendingOrders,
    List<OrdersItems>? acceptedOrders,
    List<OrdersItems>? processingOrder,
    List<OrdersItems>? dispatchedOrder,
  }) {
    this.pendingOrders = pendingOrders ?? [];
    this.acceptedOrders = acceptedOrders ?? [];
    this.processingOrder = processingOrder ?? [];
    this.dispatchedOrder = dispatchedOrder ?? [];
  }

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class ProviderStoreResponse {
  int status;
  int messageCode;
  String message;
  List<StoreItems> providerStoreList = [];

  ProviderStoreResponse({
    this.status = 0,
    this.messageCode = 0,
    this.message = "",
    List<StoreItems>? providerStoreList,
  }) {
    this.providerStoreList = providerStoreList ?? [];
  }

  factory ProviderStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderStoreResponseToJson(this);
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class StoreItems {
  int providerServiceiId;
  int storeStatus;
  String storeName;
  String storeAddress;
  String storeImage;
  String serviceCategoryName;

  StoreItems({
    this.providerServiceiId = 0,
    this.storeStatus = 0,
    this.storeName = "",
    this.storeImage = "",
    this.storeAddress = "",
    this.serviceCategoryName = "",
  });

  factory StoreItems.fromJson(Map<String, dynamic> json) =>
      _$StoreItemsFromJson(json);

  Map<String, dynamic> toJson() => _$StoreItemsToJson(this);
}

@JsonSerializable(
    createToJson: true,
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    explicitToJson: true)
class OrdersItems {
  int orderId;
  double totalAmount;
  int orderStatus;
  int orderType;
  int userTakenType;
  int paymentType;
  int orderNo;
  String scheduleOrderDateTime;
  String scheduleOrderDate;
  String scheduleOrderTime;
  String orderProductList;
  String customerName;
  String deliveryAddress;

  OrdersItems({
    this.orderId = 0,
    this.totalAmount = 0,
    this.orderStatus = 0,
    this.orderType = 0,
    this.userTakenType = 0,
    this.paymentType = 0,
    this.orderNo = 0,
    this.scheduleOrderDateTime = "",
    this.scheduleOrderDate = "",
    this.scheduleOrderTime = "",
    this.orderProductList = "",
    this.customerName = "",
    this.deliveryAddress = "",
  });

  factory OrdersItems.fromJson(Map<String, dynamic> json) =>
      _$OrdersItemsFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersItemsToJson(this);
}

class TestLoad {
  int orderId;
  bool isLoad;

  TestLoad(this.orderId, this.isLoad);
}

class DrawerModel {
  final Widget name;
  final Widget icon;
  final DrawerEnum drawerEnum;

  DrawerModel(this.name, this.icon, this.drawerEnum);
}

class DrawerItem {
  Widget icon;
  String name;
  DrawerEnum drawerEnum;

  DrawerItem(this.drawerEnum, this.icon, this.name);
}

enum DrawerEnum {
  myProfile,
  changePassword,
  orderHistory,
  bankDetail,
  product,
  wallet,
  manageCard,
  preference,
  support,
  chatWithAdmin,
  selectStore,
  offer,
  setting,
  liveChat,
  logout,
}
