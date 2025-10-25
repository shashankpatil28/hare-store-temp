// Path: lib/screen/homeScreen/orders/newOrder/new_orders.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../commonView/custom_switch.dart';
import '../../../../commonView/load_image_with_placeholder.dart';
import '../../../../commonView/my_widgets.dart';
import '../../../../commonView/no_record_found.dart';
import '../../../../dialog/rejectDialog/reject_order_dialog.dart';
import '../../../../network/api_response.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/order_status.dart';
import '../../../loginScreen/login_dl.dart';
import '../../../orderDetailScreen/order_detail_screen.dart';
import '../../home_dl.dart';
import '../orderItem/order_item.dart';
import '../orderItem/order_item_shimer.dart';
import 'package:just_audio/just_audio.dart';
import 'new_order_bloc.dart';

class NewOrders extends StatefulWidget {
  final NewOrderBloc blocNewOrder;

  const NewOrders(this.blocNewOrder, {super.key});

  @override
  NewOrdersState createState() => NewOrdersState();
}

class NewOrdersState extends State<NewOrders>
    with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  NewOrderBloc? _bloc;
  Timer? _ringTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void didChangeDependencies() {
    _startRingTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _ringTimer?.cancel();
    super.dispose();
  }

  void _startRingTimer() {
    _ringTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!prefGetBool(prefIsOrderEmpty)) {
        _playSound();
      }
    });
  }

  Future<void> _playSound() async {
    print('ringing...');
    await _audioPlayer.setAsset('assets/audio/sring.mp3');
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _bloc = widget.blocNewOrder;
    return Scaffold(
      backgroundColor: colorMainBackground,
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: _getData,
              child: StreamBuilder<List<OrdersItems>>(
                  stream: _bloc!.newOrderList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      List<OrdersItems> orderList = snapshot.data ?? [];
                      prefSetBool(prefIsOrderEmpty, orderList.isEmpty);

                      if (orderList.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: false,
                          itemCount: orderList.length,
                          itemBuilder: (context, i) => StreamBuilder<TestLoad>(
                              stream: _bloc!.loadOrderItem.where((event) =>
                                  event.orderId == orderList[i].orderId),
                              builder: (context, snapshotItem) {
                                bool isAcceptProgress = false;

                                if (snapshotItem.hasData &&
                                    snapshotItem.data!.orderId ==
                                        orderList[i].orderId) {
                                  isAcceptProgress = snapshotItem.data!.isLoad;
                                } else {
                                  isAcceptProgress = false;
                                }

                                return OrdersItem(
                                  orderStatus: OrderStatus.pendingOrder,
                                  ordersItems: orderList[i],
                                  setProgress: isAcceptProgress,
                                  rejectFun: () {
                                    showRejectDialog(_bloc!, orderList[i]);
                                  },
                                  acceptFun: () {
                                    _bloc?.setLoadOrderItem(
                                        TestLoad(orderList[i].orderId, true));
                                    if (_bloc?.setAcceptReject != null) {
                                      _bloc?.setAcceptReject!(
                                          ordersItems: orderList[i],
                                          isAccept: true);
                                    }
                                  },
                                  viewFun: () {
                                    navigationPage(
                                        context,
                                        OrderDetailScreen(
                                          setAction: true,
                                          orderId: orderList[i].orderId,
                                          updateList: (list) {
                                            _bloc?.addHomeRes(list);
                                          },
                                        ));
                                  },
                                );
                              }),
                        );
                      } else {
                        final keyContext = refreshKey.currentContext!;
                        final box = keyContext.findRenderObject() as RenderBox;
                        return ListView(
                          children: [
                            SizedBox(
                              height: box.size.height,
                              child:
                                  NoRecordFound(message: languages.emptyData),
                            )
                          ],
                        );
                      }
                    } else {
                      return const OrdersItemShimmer();
                    }
                  }),
            ),
          ),
          StreamBuilder<LoginPojo>(
              stream: _bloc!.authenticationStream,
              builder: (context, snapshot) {
                var data = snapshot.data ?? LoginPojo();
                return Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: deviceAverageSize * 0.015,
                      spreadRadius: deviceAverageSize * 0.008,
                    ),
                  ]),
                  padding: EdgeInsets.only(
                      left: deviceWidth * 0.03,
                      top: deviceHeight * 0.02,
                      bottom: deviceHeight * 0.02),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          LoadImageWithPlaceHolder(
                            width: deviceAverageSize * 0.12,
                            height: deviceAverageSize * 0.12,
                            image: snapshot.data?.storeBanner ?? "",
                            defaultAssetImage:
                                "assets/images/ic_login_logo.png",
                            borderRadius:
                                BorderRadius.circular(deviceAverageSize * 0.1),
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: deviceWidth * 0.04),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.005),
                                  width: double.infinity,
                                  child: Text(data.storeName,
                                      style: bodyText(
                                          fontSize: textSizeRegular,
                                          textColor: colorTextCommon,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: deviceHeight * 0.005),
                                        child: Text(
                                            data.serviceCategoryName
                                                .toUpperCase(),
                                            style: bodyText(
                                                textColor: colorTextCommonLight,
                                                fontSize: textSizeSmall)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                          StreamBuilder<ApiResponse>(
                              stream: _bloc!.updateStatus,
                              builder: (context, snapshot) {
                                var set =
                                    (snapshot.data?.status == Status.loading);
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Visibility(
                                        visible: set, child: const Loading()),
                                    Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: !set,
                                      child: Text(
                                        data.serviceCurrentStatus == 1
                                            ? languages.online
                                            : languages.offline,
                                        style: bodyText(
                                            textColor:
                                                data.serviceCurrentStatus == 1
                                                    ? colorAccept
                                                    : Colors.red),
                                      ),
                                    )
                                  ],
                                );
                              }),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: deviceWidth * 0.02,
                                end: deviceWidth * 0.02),
                            child: CustomSwitch(
                              width: deviceWidth * 0.1,
                              radius: deviceAverageSize * 0.03,
                              activeColor: colorAccept,
                              disableColor: offColor,
                              thumbColor: colorWhite,
                              innerPadding:
                                  EdgeInsets.all(deviceAverageSize * 0.005),
                              thumbSize: deviceAverageSize * 0.025,
                              value:
                                  data.serviceCurrentStatus == 1 ? true : false,
                              onChanged: (value) {
                                _bloc?.updateStatusCall(value);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  showRejectDialog(NewOrderBloc bloc, OrdersItems data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var rejectOrderDialog = RejectOrderDialog((s, subject) {
            if (bloc.setAcceptReject != null) {
              bloc.setAcceptReject!(
                  ordersItems: data,
                  isAccept: false,
                  reason: s,
                  subject: subject);
            }
          });
          return rejectOrderDialog;
        },
        barrierDismissible: true);
  }

  Future<void> _getData() async {
    _bloc?.onRefreshed(true);
  }

  @override
  bool get wantKeepAlive => true;
}
