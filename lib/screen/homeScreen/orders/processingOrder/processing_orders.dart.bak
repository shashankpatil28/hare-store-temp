// Path: lib/screen/homeScreen/orders/processingOrder/processing_orders.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../commonView/no_record_found.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/order_status.dart';
import '../../../orderDetailScreen/order_detail_screen.dart';
import '../../home_dl.dart';
import '../orderItem/order_item.dart';
import '../orderItem/order_item_shimer.dart';
import 'processing_order_bloc.dart';

class ProcessingOrders extends StatefulWidget {
  final ProcessingOrderBloc blocProcessingOrder;

  const ProcessingOrders(this.blocProcessingOrder, {super.key});

  @override
  ProcessingOrdersState createState() => ProcessingOrdersState();
}

class ProcessingOrdersState extends State<ProcessingOrders>
    with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ProcessingOrderBloc? block;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    block = widget.blocProcessingOrder;
    return Scaffold(
      backgroundColor: colorMainBackground,
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: _getData,
        child: StreamBuilder<List<OrdersItems>>(
            stream: block?.newOrderList,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                List<OrdersItems> orderList = snapshot.data ?? [];
                if (orderList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: false,
                    itemCount: orderList.length,
                    itemBuilder: (context, i) {
                      var data = orderList[i];
                      return StreamBuilder<TestLoad>(
                          stream: block!.loadOrderItem.where(
                              (event) => event.orderId == orderList[i].orderId),
                          builder: (context, snapshotItem) {
                            bool isProgress = false;
                            if (snapshotItem.hasData &&
                                snapshotItem.data!.orderId ==
                                    orderList[i].orderId) {
                              isProgress = snapshotItem.data!.isLoad;
                            }
                            return OrdersItem(
                              orderStatus: data.orderStatus == 5
                                  ? OrderStatus.processing
                                  : OrderStatus.ready,
                              ordersItems: data,
                              setProgress: isProgress,
                              viewFun: () {
                                navigationPage(
                                    context,
                                    OrderDetailScreen(
                                      setAction: true,
                                      orderId: data.orderId,
                                      updateList: (list) {
                                        block?.addHomeRes(list);
                                      },
                                    ));
                              },
                              doneFun: () {
                                block?.setLoadOrderItem(
                                    TestLoad(orderList[i].orderId, true));
                                if (block!.setProcess != null) {
                                  block!.setProcess!(
                                      orderList[i], changeOrderReady);
                                }
                              },
                              acceptFun: data.userTakenType == 2
                                  ? () {
                                      block?.setLoadOrderItem(
                                          TestLoad(orderList[i].orderId, true));
                                      if (block!.setProcess != null) {
                                        block!.setProcess!(
                                            orderList[i], changeOrderDispatch);
                                      }
                                    }
                                  : null,
                            );
                          });
                    },
                  );
                } else {
                  final keyContext = refreshKey.currentContext!;
                  final box = keyContext.findRenderObject() as RenderBox;
                  return ListView(
                    children: [
                      SizedBox(
                        height: box.size.height,
                        child: NoRecordFound(message: languages.emptyData),
                      )
                    ],
                  );
                }
              } else {
                return const OrdersItemShimmer();
              }
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _getData() async {
    block?.onRefreshed(true);
  }
}
