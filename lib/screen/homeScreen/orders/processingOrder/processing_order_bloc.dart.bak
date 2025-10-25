// Path: lib/screen/homeScreen/orders/processingOrder/processing_order_bloc.dart
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import 'dart:async';

import '../../../../utils/bloc.dart';
import '../../home_dl.dart';

class ProcessingOrderBloc implements Bloc {
  String tag = "ProcessingBloc>>>";
  final _onRefresh = BehaviorSubject<bool>();
  final _processingOrderList = BehaviorSubject<List<OrdersItems>>();
  final _loadOrderItem = BehaviorSubject<TestLoad>();

  final _homeRes = BehaviorSubject<HomeResponse>();

  Stream<HomeResponse> get homeRes => _homeRes.stream;

  Stream<List<OrdersItems>> get newOrderList => _processingOrderList.stream;

  Function(List<OrdersItems>) get setOrderList => _processingOrderList.add;

  Stream<bool> get onRefresh => _onRefresh.stream;

  Function(bool) get onRefreshed => _onRefresh.add;

  Stream<TestLoad> get loadOrderItem => _loadOrderItem.stream;

  Function(TestLoad) get setLoadOrderItem => _loadOrderItem.add;

  Function(OrdersItems ordersItems, int orderStatus)? setProcess;

  Function(HomeResponse) get addHomeRes => _homeRes.add;

  @override
  void dispose() {
    _homeRes.close();
    _loadOrderItem.close();
    _onRefresh.close();
    _processingOrderList.close();
  }
}
