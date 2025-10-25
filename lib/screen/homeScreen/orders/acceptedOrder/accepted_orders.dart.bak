// Path: lib/screen/homeScreen/orders/acceptedOrder/accepted_orders.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../commonView/no_record_found.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/order_status.dart';
import '../../../orderDetailScreen/order_detail_screen.dart';
import '../../home_dl.dart';
import '../orderItem/order_item.dart';
import '../orderItem/order_item_shimer.dart';
import 'accept_order_bloc.dart';

class AcceptedOrders extends StatefulWidget {
  final AcceptOrderBloc blocAcceptOrder;

  const AcceptedOrders(this.blocAcceptOrder, {super.key});

  @override
  AcceptedOrdersState createState() => AcceptedOrdersState();
}

class AcceptedOrdersState extends State<AcceptedOrders> with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  AcceptOrderBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _bloc = widget.blocAcceptOrder;
    return Scaffold(
      backgroundColor: colorMainBackground,
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: _getData,
        child: StreamBuilder<List<OrdersItems>>(
            stream: _bloc!.newOrderList,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                List<OrdersItems> orderList = snapshot.data ?? [];
                if (orderList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: false,
                    itemCount: orderList.length,
                    itemBuilder: (context, i) => StreamBuilder<TestLoad>(
                        stream: _bloc!.loadOrderItem.where((event) => event.orderId == orderList[i].orderId),
                        builder: (context, snapshotItem) {
                          bool isAcceptProgress = false;
                          if (snapshotItem.hasData && snapshotItem.data!.orderId == orderList[i].orderId) {
                            isAcceptProgress = snapshotItem.data!.isLoad;
                          }
                          return OrdersItem(
                            orderStatus: OrderStatus.accept,
                            ordersItems: orderList[i],
                            setProgress: isAcceptProgress,
                            acceptFun: () {
                              if (_bloc!.setProcess != null) {
                                _bloc?.setProcess!( orderList[i]);
                              }
                              _bloc?.setLoadOrderItem(TestLoad(orderList[i].orderId, true));
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
                        child: NoRecordFound(message: languages.emptyData),
                      )
                    ],
                  );
                  // return EmptyData();
                }
              } else {
                return const OrdersItemShimmer();
              }
            }),
      ),
    );
  }

  Future<void> _getData() async {
    _bloc?.onRefreshed(true);
  }

  @override
  bool get wantKeepAlive => true;
}
