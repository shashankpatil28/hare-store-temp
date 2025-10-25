// Path: lib/screen/homeScreen/orders/newOrder/new_order_bloc.dart
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:flutter/material.dart'; // Changed from cupertino.dart for BuildContext

import '../../../../network/api_response.dart';
import '../../../../network/base_dl.dart';
import '../../../../utils/bloc.dart';
import '../../../../utils/common_util.dart';
import '../../../loginScreen/login_dl.dart';
import '../../home_dl.dart';
import '../../home_repo.dart';

class NewOrderBloc implements Bloc { // Changed from 'with Bloc'
  String tag = "NewOrderBloc>>>";
  final _onRefresh = BehaviorSubject<bool>();
  final _homeRes = BehaviorSubject<HomeResponse>();
  BuildContext context;
  final HomeRepo _repo = HomeRepo();

  final State state;

  NewOrderBloc(this.context, this.state);

  Stream<bool> get onRefresh => _onRefresh.stream;

  Stream<HomeResponse> get homeRes => _homeRes.stream;
  final _newOrderList = BehaviorSubject<List<OrdersItems>>();
  final _loadOrderItem = BehaviorSubject<TestLoad>();
  final updateStatus = BehaviorSubject<ApiResponse>();
  final _isStatusController = StreamController<bool>();
  final subjectStoreBanner = BehaviorSubject<String>();
  final authenticationStream = BehaviorSubject<LoginPojo>();

// 2
  Function(bool) get onRefreshed => _onRefresh.add;

  Function(HomeResponse) get addHomeRes => _homeRes.add;

  Stream<bool> get isStatusStream => _isStatusController.stream;

  Stream<List<OrdersItems>> get newOrderList => _newOrderList.stream;

  Stream<TestLoad> get loadOrderItem => _loadOrderItem.stream;

  // set isStatus(bool value) {
  //   _isStatusController.sink.add(value);
  // }
  Function(bool) get isStatus => _isStatusController.add;

  Function(List<OrdersItems>) get setOrderList => _newOrderList.add;

  Function({OrdersItems? ordersItems, bool isAccept, String reason, BehaviorSubject<ApiResponse<HomeResponse>>? subject})? setAcceptReject;

  Function(TestLoad) get setLoadOrderItem => _loadOrderItem.add;

  updateStoreData() {
    LoginPojo authentication = LoginPojo(
      storeBanner: prefGetString(prefStoreBanner),
      serviceCategoryName: prefGetString(prefServiceCategoryName),
      storeName: prefGetString(prefStoreName),
      serviceCurrentStatus: prefGetInt(prefStoreCurrentStatus),
    );
    authenticationStream.sink.add(authentication);
  }

  updateStatusCall(bool isOn) async {
    updateStatus.add(ApiResponse.loading());
    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      try {
        BaseModel response = BaseModel.fromJson(await _repo.updateStatus(isOn));

        if (!state.mounted) return;
        var apiMsg = getApiMsg(context, response.message, response.messageCode);
        if (isApiStatus(context, response.status, apiMsg)) {
          updateStatus.add(ApiResponse.completed(apiMsg));
        } else {
          if (response.status != 3) openSimpleSnackbar(apiMsg);
          updateStatus.add(ApiResponse.error(apiMsg));
        }
        prefSetInt(prefStoreCurrentStatus, isOn ? 1 : 0);
        updateStoreData();
      } catch (e) {
        updateStatus.add(ApiResponse.error(e.toString()));
        openSimpleSnackbar(e.toString());
        logd(tag, e.toString());
      }
    } else {
      openSimpleSnackbar(languages.noInternet);
    }
  }

  @override
  void dispose() {
    _onRefresh.close();
    _homeRes.close();
    updateStatus.close();
    _loadOrderItem.close();
    _isStatusController.close();
    _newOrderList.close();
  }

  myLog(String message) {
    logd(tag, "$runtimeType ==> $message");
  }
}
