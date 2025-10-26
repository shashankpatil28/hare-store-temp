// Path: lib/screen/ordersHistoryScreen/order_history_screen.dart

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../commonView/no_record_found.dart';
import '../../network/api_response.dart';
import '../../utils/common_util.dart';
import '../../utils/custom_icons.dart';
import '../orderDetailScreen/order_detail_screen.dart';
import 'bottom_sheet_filter.dart';
import 'order_history_bloc.dart';
import 'order_history_dl.dart';
import 'order_history_shimmer.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => OrderHistoryScreenState();
}

class OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderHistoryBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = _bloc ?? OrderHistoryBloc(context, this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBackground,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          languages.navOrderHistory,
          style: toolbarStyle(),
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return OrderHistoryFilterBs(
                      defaultSelected: _bloc!.filterSelected,
                      onSelected: (filter) {
                        _bloc?.changeFilter(filter);
                      },
                      filterList: _bloc!.list,
                    );
                  },
                );
              },
              child: StreamBuilder<HistoryFilterModel>(
                stream: _bloc!.historyFilterModel,
                builder: (context, snapshot) {
                  HistoryFilterModel? selectedModel =
                      snapshot.data ?? _bloc!.filterSelected;
                  return Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            CustomIcons.filter,
                            size: deviceAverageSize * 0.038,
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: deviceWidth * 0.01),
                          child: Text(
                            "${selectedModel?.filterName}",
                            style: bodyText(
                                fontWeight: FontWeight.bold, fontSize: 0.02),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<ApiResponse<OrderHistoryResponse>>(
              stream: _bloc!.orderHistoryResponseStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  switch (snapshot.data!.status) {
                    case Status.loading:
                      return const OrderHistoryShimmer();
                    case Status.completed:
                      OrderHistoryResponse? data = snapshot.data!.data;
                      if (data != null) {
                        return _buildListWithHeader(context, data);
                      }
                      // If completed but no data, show empty state
                      return const OrderHistoryShimmer();
                    case Status.error:
                      return Center(
                        child: Text(
                            snapshot.data?.message ??
                                languages.apiErrorUnexpectedErrorMsg),
                      );
                  }
                }
                // initial / fallback loading
                return const OrderHistoryShimmer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListWithHeader(
      BuildContext context, OrderHistoryResponse headerData) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(headerData)),
        // NEW: Use PagingListener to connect controller -> sliver (v5.x API)
        // PagingListener gives us the current PagingState and a fetchNextPage callback
        PagingListener<int, OrderHistoryItem>(
          controller: _bloc!.pagingController,
          builder: (context, pagingState, fetchNextPage) {
            return PagedSliverList.separated(
              state: pagingState,
              fetchNextPage: fetchNextPage,
              separatorBuilder: (context, index) => Divider(
                height: deviceHeight * 0.005,
                thickness: 1,
                color: colorMainView,
              ),
              builderDelegate: PagedChildBuilderDelegate<OrderHistoryItem>(
                itemBuilder: (context, item, position) {
                  return _buildListItem(item);
                },
                firstPageErrorIndicatorBuilder: (context) => Center(
                    child: Text(_bloc!.pagingController.value.error.toString() ??
                        languages.apiErrorUnexpectedErrorMsg)),
                newPageErrorIndicatorBuilder: (context) => Center(
                    child: Text(_bloc!.pagingController.value.error.toString() ??
                        languages.apiErrorUnexpectedErrorMsg)),
                firstPageProgressIndicatorBuilder: (context) =>
                    const OrderHistoryShimmer(),
                newPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                noItemsFoundIndicatorBuilder: (context) => NoRecordFound(
                  rippleIconData: CustomIcons.orderHistoryEmpty,
                  message: languages.emptyData,
                  withRipple: true,
                  rippleImgSize: deviceHeight * 0.1,
                ),
                noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(OrderHistoryResponse data) {
    return Column(
      children: [
        Row(
          children: [
            // Pending Payment Card
            Expanded(
              child: Container(
                margin: EdgeInsets.all(deviceWidth * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.02),
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CustomIcons.pendingPayment,
                                size: deviceAverageSize * 0.03,
                                color: textColorWithOpacity,
                              ),
                              SizedBox(width: deviceWidth * 0.02),
                              Text(
                                languages.pendingPayment,
                                style: bodyText(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            getAmountWithCurrency(data.pendingPayments),
                            style: bodyText(fontWeight: FontWeight.w700, fontSize: textSizeBig),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Completed Orders Card
            Expanded(
              child: Container(
                margin: EdgeInsets.all(deviceWidth * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.02),
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CustomIcons.completedOrders,
                                size: deviceAverageSize * 0.03,
                                color: textColorWithOpacity,
                              ),
                              SizedBox(width: deviceWidth * 0.02),
                              Text(
                                languages.completedOrders,
                                style: bodyText(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                        child: Text(
                          "${data.completedOrder}",
                          style: bodyText(fontWeight: FontWeight.w700, fontSize: textSizeBig),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            // Pending Orders Card
            Expanded(
              child: Container(
                margin: EdgeInsets.all(deviceWidth * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.02),
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.02),
                      child: Row(
                        children: [
                          Icon(
                            CustomIcons.pendingOrders,
                            size: deviceAverageSize * 0.03,
                            color: textColorWithOpacity,
                          ),
                          SizedBox(width: deviceWidth * 0.02),
                          Text(
                            languages.pendingOrders,
                            style: bodyText(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                        child: Text(
                          "${data.pendingOrder}",
                          style: bodyText(fontWeight: FontWeight.w700, fontSize: textSizeBig),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Cancelled Orders Card
            Expanded(
              child: Container(
                margin: EdgeInsets.all(deviceWidth * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.02),
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.02),
                      child: Row(
                        children: [
                          Icon(
                            CustomIcons.cancelledOrders,
                            size: deviceAverageSize * 0.03,
                            color: textColorWithOpacity,
                          ),
                          SizedBox(width: deviceWidth * 0.02),
                          Text(
                            languages.cancelledOrders,
                            style: bodyText(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                        child: Text(
                          "${data.canceledOrder}",
                          style: bodyText(fontWeight: FontWeight.w700, fontSize: textSizeBig),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListItem(OrderHistoryItem orderItem) {
    return Container(
      color: colorWhite,
      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.005),
      child: InkWell(
        onTap: () {
          navigationPage(
            context,
            OrderDetailScreen(
              orderId: orderItem.orderId,
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.011),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: deviceWidth * 0.02, top: deviceHeight * 0.005),
                    child: Icon(
                      Icons.person,
                      size: deviceAverageSize * 0.035,
                      color: textColorWithOpacity,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItem.customerName,
                          style: bodyText(
                              fontWeight: FontWeight.w600, fontSize: textSizeMediumBig),
                        ),
                        SizedBox(height: deviceHeight * 0.005),
                        Text(
                          "${languages.orderId} : #${orderItem.orderNo}",
                          style: bodyText(
                              textColor: colorTextCommonLight, fontSize: textSizeSmall),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      checkOrderStatus(
                        orderItem.orderStatus,
                        isRight: true,
                        padding: EdgeInsetsDirectional.only(
                            start: deviceWidth * 0.02,
                            end: deviceWidth * 0.01,
                            top: deviceHeight * 0.006,
                            bottom: deviceHeight * 0.006),
                      ),
                      SizedBox(height: deviceHeight * 0.01),
                      Text(
                        getAmountWithCurrency(orderItem.totalAmount),
                        style: bodyText(
                            textColor: colorPrimary,
                            fontSize: textSizeBig,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  bottom: deviceHeight * 0.012, start: deviceWidth * 0.02, end: deviceWidth * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: deviceWidth * 0.02, top: deviceHeight * 0.002),
                    child: Icon(
                      CustomIcons.delivery,
                      size: deviceAverageSize * 0.03,
                      color: textColorWithOpacity,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      orderItem.orderProductList,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: bodyText(fontSize: textSizeSmall),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
