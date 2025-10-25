// Path: lib/screen/homeScreen/orders/dispatchOrder/dispatch_orders.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../commonView/no_record_found.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/order_status.dart';
import '../../../orderDetailScreen/order_detail_screen.dart';
import '../../home_dl.dart';
import '../orderItem/order_item.dart';
import '../orderItem/order_item_shimer.dart';
import 'dispatch_order_bloc.dart';

class DispatchOrders extends StatefulWidget {
  final DispatchOrderBloc blocDispatchOrder;

  const DispatchOrders(this.blocDispatchOrder, {super.key});

  @override
  DispatchOrdersState createState() => DispatchOrdersState();
}

class DispatchOrdersState extends State<DispatchOrders> with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  DispatchOrderBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _bloc = widget.blocDispatchOrder;
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
                    itemBuilder: (context, i) {
                      var data = orderList[i];
                      return StreamBuilder<TestLoad>(
                          stream: _bloc!.loadOrderItem.where((event) => event.orderId == data.orderId),
                          builder: (context, snapshotItem) {
                            bool isProgress = false;
                            if (snapshotItem.hasData && snapshotItem.data != null && snapshotItem.data!.orderId == data.orderId) {
                              isProgress = snapshotItem.data!.isLoad;
                            }
                            return OrdersItem(
                              orderStatus: OrderStatus.dispatch,
                              ordersItems: data,
                              setProgress: isProgress,
                              viewFun: () {
                                navigationPage(
                                    context,
                                    OrderDetailScreen(
                                      setAction: true,
                                      orderId: data.orderId,
                                      updateList: (list) {
                                        _bloc?.addHomeRes(list);
                                      },
                                    ));
                              },
                              acceptFun: data.userTakenType == 2
                                  ? () {
                                      _bloc?.setLoadOrderItem(TestLoad(data.orderId, true));
                                      if (_bloc?.setProcess != null) {
                                        _bloc?.setProcess!(data, orderStatusComplete);
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

  Future<void> _getData() async {
    _bloc?.onRefreshed(true);
  }

  @override
  bool get wantKeepAlive => true;
}
