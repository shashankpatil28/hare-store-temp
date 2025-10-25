// Path: lib/screen/homeScreen/orders/acceptedOrder/accept_order_bloc.dart

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../../../../utils/bloc.dart';
import '../../home_dl.dart';

class AcceptOrderBloc implements Bloc {
  final _acceptOrderList = BehaviorSubject<List<OrdersItems>>();
  final _onRefresh = BehaviorSubject<bool>();

  // final _acceptOrder = BehaviorSubject<OrdersItems>();
  final _loadOrderItem = BehaviorSubject<TestLoad>();
  final _homeRes = BehaviorSubject<HomeResponse>();

  Stream<List<OrdersItems>> get newOrderList => _acceptOrderList.stream;

  Stream<HomeResponse> get homeRes => _homeRes.stream;

  // Stream<OrdersItems> get acceptOrder => _acceptOrder.stream;

  Stream<bool> get onRefresh => _onRefresh.stream;

  Stream<TestLoad> get loadOrderItem => _loadOrderItem.stream;

  Function(HomeResponse) get addHomeRes => _homeRes.add;

  Function(bool) get onRefreshed => _onRefresh.add;

  Function(List<OrdersItems>) get setOrderList => _acceptOrderList.add;

  // Function(OrdersItems) get setAcceptOrder => _acceptOrder.add;

  Function(TestLoad) get setLoadOrderItem => _loadOrderItem.add;

  Function(OrdersItems ordersItems)? setProcess;

  @override
  void dispose() {
    _onRefresh.close();
    _loadOrderItem.close();
    _homeRes.close();
    _acceptOrderList.close();
  }
}
