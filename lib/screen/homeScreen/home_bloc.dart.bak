// Path: lib/screen/homeScreen/home_bloc.dart

// import 'dart:convert';
import 'dart:io';

import "package:async/async.dart" show StreamGroup;
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as p_handler;
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../../dialog/demo_dialog.dart';
import '../../dialog/overlay_permission_dialog.dart';
import '../../dialog/warning_dialog.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../loginScreen/login_dl.dart';
import '../loginScreen/login_repo.dart';
import 'home_dl.dart';
import 'home_repo.dart';
import 'home_screen.dart';
import 'orders/acceptedOrder/accept_order_bloc.dart';
import 'orders/dispatchOrder/dispatch_order_bloc.dart';
import 'orders/newOrder/new_order_bloc.dart';
import 'orders/processingOrder/processing_order_bloc.dart';

class HomeBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "HomeBloc>>>";
  final int changeOrderAccept = 2;
  final int changeOrderReject = 3;
  final int changeOrderStartProcessing = 5;
  final int changeOrderComplete = 9;

  BuildContext context;
  final HomeRepo _repo = HomeRepo();

  NewOrderBloc? _blocNewOrder;
  final DispatchOrderBloc _blocDispatchOrder = DispatchOrderBloc();
  final ProcessingOrderBloc _blocProcessingOrder = ProcessingOrderBloc();
  final AcceptOrderBloc _blocAcceptOrder = AcceptOrderBloc();

  final _homeSubject = BehaviorSubject<ApiResponse<bool>>();
  final logoutSubject = BehaviorSubject<ApiResponse<BaseModel>>();
  final selectStoreSubject = BehaviorSubject<ApiResponse<BaseModel>>();
  final storeList = BehaviorSubject<List<StoreItems>>();

  Stream<List<StoreItems>> get streamStoreList => storeList.stream;

  final authSubject = BehaviorSubject<LoginPojo>();

  State<HomeScreen> state;

  HomeBloc(this.context, this.state) {
    _blocNewOrder = NewOrderBloc(context, state);
    setHomeDetails();
    getHomeData();
    setToken();
    setFCMToken();
    StreamGroup.merge([
      _blocNewOrder!.onRefresh,
      _blocDispatchOrder.onRefresh,
      _blocProcessingOrder.onRefresh,
      _blocAcceptOrder.onRefresh
    ]).listen((event) {
      getHomeData();
    });

    StreamGroup.merge([
      _blocNewOrder!.homeRes,
      _blocAcceptOrder.homeRes,
      _blocProcessingOrder.homeRes,
      _blocDispatchOrder.homeRes,
    ]).listen((event) {
      setOrderList(event);
    });

    _blocAcceptOrder.setProcess = (ordersItems) {
      updateOrderStatus(ordersItems, changeOrderStartProcessing, "");
    };
    _blocProcessingOrder.setProcess = (ordersItems, orderStatus) {
      updateOrderStatus(ordersItems, orderStatus, "");
    };
    _blocDispatchOrder.setProcess = (ordersItems, orderStatus) {
      updateOrderStatus(ordersItems, orderStatus, "");
    };

    _blocNewOrder?.setAcceptReject =
        ({ordersItems, isAccept = false, reason = "", subject}) {
      updateOrderStatus(ordersItems!,
          isAccept ? changeOrderStartProcessing : changeOrderReject, reason,
          subject: subject);
    };
    Future.delayed(const Duration(seconds: 1), () {
      openAllDialog();
    });
  }

  openDemoDialog() {
    int isAppOpen = sharedPrefs.getInt(SharedPreferencesUtil.isAppOpen) ?? 0;
    if (isAppOpen == 0) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const WarningDialog();
          }).then((value) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              sharedPrefs.setInt(SharedPreferencesUtil.isAppOpen, 1);
              return const DemoDialog();
            }).then((value) {});
      });
    }
  }

  openAllDialog() async {
    if (Platform.isAndroid &&
        await p_handler.Permission.systemAlertWindow.status.isDenied) {
      openPermissionDialog().then((value) {
        openAllDialog();
      });
    } else {
      if (isDemoApp) openDemoDialog();
    }
  }

  setHomeDetails() {
    blocNewOrder?.updateStoreData();
  }

  NewOrderBloc? get blocNewOrder => _blocNewOrder;

  ProcessingOrderBloc get blocProcessingOrder => _blocProcessingOrder;

  AcceptOrderBloc get blocAcceptOrder => _blocAcceptOrder;

  DispatchOrderBloc get blocDispatchOrder => _blocDispatchOrder;

  Future<void> setToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    firebaseAuth().then((value) {
      setFireToken(token ?? "");
    });
  }

  getHomeData() async {
    _homeSubject.add(ApiResponse.loading());
    var connectivityResult = await cp.Connectivity().checkConnectivity();
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      try {
        HomeResponse response =
            HomeResponse.fromJson(await _repo.getHomeData());
        if (!state.mounted) return;
        var apiMsg = getApiMsg(context, response.message, response.messageCode);

        if (isApiStatus(context, response.status, apiMsg)) {
          setOrderList(response);
        } else {
          if (response.status != 3) openSimpleSnackbar(apiMsg);
          _homeSubject.add(ApiResponse.error());
        }
      } catch (e) {
        if (!state.mounted) return;
        _homeSubject.sink.add(ApiResponse.error(e.toString()));
        openSimpleSnackbar(e.toString());
        logd(tag, e.toString());
      }
    } else {
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
    }
  }

  updateOrderStatus(OrdersItems ordersItems, int orderStatus, String reason,
      {BehaviorSubject<ApiResponse<HomeResponse>>? subject}) async {
    var connectivityResult = await cp.Connectivity().checkConnectivity();
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      _homeSubject.add(ApiResponse.loading());
      subject?.add(ApiResponse.loading());

      try {
        HomeResponse response = HomeResponse.fromJson(
          await _repo.updateOrderStatus(
              orderId: ordersItems.orderId,
              updateStatus: orderStatus,
              rejectedReason: reason),
        );
        if (!state.mounted) return;
        var apiMsg = getApiMsg(context, response.message, response.messageCode);

        if (isApiStatus(context, response.status, apiMsg)) {
          subject?.add(ApiResponse.completed(response));
          // printReceipt(ordersItems.orderId);
          setOrderList(response);
        } else {
          if (response.status != 3) openSimpleSnackbar(apiMsg);
          blocProcessingOrder
              .setLoadOrderItem(TestLoad(ordersItems.orderId, false));
          blocAcceptOrder
              .setLoadOrderItem(TestLoad(ordersItems.orderId, false));
          blocNewOrder?.setLoadOrderItem(TestLoad(ordersItems.orderId, false));
          _homeSubject.add(ApiResponse.error());
          subject?.add(ApiResponse.error());
        }
      } catch (e) {
        if (!state.mounted) return;
        blocProcessingOrder
            .setLoadOrderItem(TestLoad(ordersItems.orderId, false));
        blocAcceptOrder.setLoadOrderItem(TestLoad(ordersItems.orderId, false));
        blocNewOrder?.setLoadOrderItem(TestLoad(ordersItems.orderId, false));

        _homeSubject.add(ApiResponse.error(e.toString()));
        subject?.add(ApiResponse.error(e.toString()));
        openSimpleSnackbar(e.toString());
        logd(tag, e.toString());
      }
    } else {
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
    }
  }

  setOrderList(HomeResponse response) {
    _homeSubject.add(ApiResponse.completed(true));

    blocNewOrder?.setOrderList(response.pendingOrders);
    blocAcceptOrder.setOrderList(response.acceptedOrders);
    blocProcessingOrder.setOrderList(response.processingOrder);
    blocDispatchOrder.setOrderList(response.dispatchedOrder);
  }

  setProviderStoreList(List<StoreItems> storeItemsList) {
    storeList.sink.add(storeItemsList);
    // print('RESPONSE: ${storeItemsList}');
  }

  logoutCall(BuildContext context) async {
    logoutSubject.add(ApiResponse.loading());

    var connectivityResult = await cp.Connectivity().checkConnectivity();
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      try {
        BaseModel response =
            BaseModel.fromJson(await LoginRepo().callLogoutApi());
        if (!state.mounted) return;
        var apiMsg = getApiMsg(context, response.message, response.messageCode);
        if (isApiStatus(context, response.status, apiMsg)) {
          logoutSubject.add(ApiResponse.completed());
          logout(context);
        } else {
          if (response.status != 3) openSimpleSnackbar(apiMsg);
          logoutSubject.add(ApiResponse.error());
        }
      } catch (e) {
        if (!state.mounted) return;
        logoutSubject.add(ApiResponse.error(e.toString()));
        Navigator.pop(context, false);
        openSimpleSnackbar(e.toString());
      }
    } else {
      if (!state.mounted) return;
      Navigator.pop(context, false);
      openSimpleSnackbar(languages.noInternet);
    }
  }

  openLogoutDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StreamBuilder<ApiResponse<BaseModel>>(
              stream: logoutSubject,
              builder: (context, snapLoading) {
                var isLoading = snapLoading.hasData &&
                    snapLoading.data?.status == Status.loading;
                return SimpleDialogUtil(
                  isLoading: isLoading,
                  title: languages.logout,
                  message: languages.logoutMsg,
                  positiveButtonTxt: languages.logout,
                  negativeButtonTxt: languages.cancel,
                  onPositivePress: () {
                    logoutCall(context);
                  },
                  onNegativePress: () {
                    Navigator.pop(context, true);
                  },
                );
              });
        });
  }

  getProviderStoreList() async {
    selectStoreSubject.add(ApiResponse.loading());
    var connectivityResult = await cp.Connectivity().checkConnectivity();
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      try {
        ProviderStoreResponse response =
            ProviderStoreResponse.fromJson(await _repo.getProviderStores());
        if (!state.mounted) return;
        var apiMsg = getApiMsg(context, response.message, response.messageCode);

        if (isApiStatus(context, response.status, apiMsg)) {
          selectStoreSubject.add(ApiResponse.completed());
          setProviderStoreList(response.providerStoreList);
        } else {
          // if (response.status != 3) openSimpleSnackbar(apiMsg);
          // selectStoreSubject.add(ApiResponse.error());
        }
      } catch (e) {
        // if (!state.mounted) return;
        // selectStoreSubject.sink.add(ApiResponse.error(e.toString()));
        // openSimpleSnackbar(e.toString());
        // logd(tag, e.toString());
      }
    } else {
      // if (!state.mounted) return;
      // openSimpleSnackbar(languages.noInternet);
    }
  }

  openSelectStoreDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(const Duration(milliseconds: 100), () {
            // This code runs after the dialog is displayed
            getProviderStoreList();
            // Implement your effect here, e.g., starting an animation or updating state
          });
          return StatefulBuilder(builder: (context, setState) {
            return StreamBuilder<List<StoreItems>>(
                stream: streamStoreList,
                builder: (context, snapStoreList) {
                  if (snapStoreList.hasData) {
                    final storeListData = snapStoreList.data;
                    return StreamBuilder<ApiResponse<BaseModel>>(
                        stream: selectStoreSubject,
                        builder: (context, snapLoading) {
                          return Container(
                              height: 500,
                              decoration: const BoxDecoration(
                                  color: colorMainBackground),
                              child: Column(children: [
                                const SizedBox(height: 10),
                                const Card(
                                  elevation: 0,
                                  color: colorMainBackground,
                                  child: Text("Your Stores",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: colorGreen)),
                                ),
                                Flexible(
                                  child: ListView(
                                    children: List.generate(
                                      storeListData!.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          prefSetInt(
                                              prefStoreServiceId,
                                              storeListData[index]
                                                  .providerServiceiId);
                                          prefSetString(prefStoreBanner,
                                              storeListData[index].storeImage);
                                          prefSetString(
                                              prefServiceCategoryName,
                                              storeListData[index]
                                                  .serviceCategoryName);
                                          prefSetString(prefStoreName,
                                              storeListData[index].storeName);
                                          prefSetInt(prefStoreCurrentStatus,
                                              storeListData[index].storeStatus);
                                          _blocNewOrder!.updateStoreData();
                                          openScreenWithClearPrevious(
                                              context, const HomeScreen());
                                        },
                                        child: Card(
                                          color: colorWhite,
                                          elevation: 1,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    storeListData[index]
                                                        .storeName,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        color: colorBlack,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    storeListData[index]
                                                        .storeAddress,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: colorMainGray),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]));
                        });
                  } else {
                    return Container();
                  }
                });
          });
        });
  }

  Future openPermissionDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const OverlayPermissionDialog();
        });
  }

  // printReceipt(int orderId) async {
  //   await SunmiPrinter.initPrinter();
  //   await SunmiPrinter.startTransactionPrint(true);

  //   SunmiPrinter.printText('Receipt Example');
  //   SunmiPrinter.printQRCode('https://example.com');
  //   SunmiPrinter.lineWrap(3);

  //   await SunmiPrinter.exitTransactionPrint(true);
  // }

  @override
  void dispose() {
    authSubject.close();
    _homeSubject.close();
    logoutSubject.close();
  }
}
