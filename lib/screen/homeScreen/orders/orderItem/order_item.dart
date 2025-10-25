// Path: lib/screen/homeScreen/orders/orderItem/order_item.dart

import 'package:flutter/material.dart';

import '../../../../utils/common_util.dart';
import '../../../../utils/custom_icons.dart';
import '../../../../utils/order_status.dart';
import '../../home_dl.dart';

class OrdersItem extends StatefulWidget {
  const OrdersItem({
    Key? key,
    required this.orderStatus,
    required this.ordersItems,
    this.rejectFun,
    this.viewFun,
    this.setProgress,
    this.acceptFun,
    this.doneFun,
  }) : super(key: key);

  final OrderStatus orderStatus;
  final OrdersItems ordersItems;
  final bool? setProgress;
  final Function()? rejectFun;
  final Function()? acceptFun;
  final Function()? viewFun;
  final Function()? doneFun;

  @override
  OrdersItemState createState() => OrdersItemState();
}

class OrdersItemState extends State<OrdersItem> {
  @override
  Widget build(BuildContext context) {
    double height = deviceHeight * 0.04;
    var borderRadius =
        BorderRadius.all(Radius.circular(deviceAverageSize * 0.0075));

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: deviceAverageSize * 0.012),
      color: Colors.white,
      child: Column(
        children: [
          if (widget.ordersItems.orderType == 1)
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.all(deviceAverageSize * 0.012),
              width: double.infinity,
              child: Text(
                "${languages.schedule} : ${getTime(widget.ordersItems.scheduleOrderDateTime, format: "dd-MM-yyyy hh:mm a")}",
                style:
                    bodyText(textColor: Colors.white, fontSize: textSizeSmall),
              ),
            ),
          if (widget.ordersItems.userTakenType == 2)
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.all(deviceAverageSize * 0.012),
              width: double.infinity,
              child: Text(
                languages.takeaway,
                style:
                    bodyText(textColor: Colors.white, fontSize: textSizeSmall),
              ),
            ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: deviceAverageSize * 0.015),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.012),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.person,
                          size: deviceAverageSize * 0.035,
                          color: colorTextLight,
                        ),
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: deviceWidth * 0.01),
                              child: Text(
                                widget.ordersItems.customerName,
                                style: bodyText(
                                    fontSize: textSizeSmall,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ))),
                      Container(
                          margin: EdgeInsetsDirectional.only(
                              end: deviceWidth * 0.02),
                          child: Text(
                              getAmountWithCurrency(
                                  widget.ordersItems.totalAmount),
                              style: bodyText(
                                  textColor: colorPrimary,
                                  fontSize: textSizeBig,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(deviceAverageSize * 0.007),
                    child: RichText(
                      text: TextSpan(
                          text: "${languages.orderId} :",
                          style: bodyText(textColor: colorTextCommonLight),
                          children: <TextSpan>[
                            TextSpan(
                              text: " #${widget.ordersItems.orderNo}",
                              style: bodyText(textColor: Colors.black),
                            )
                          ]),
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(deviceAverageSize * 0.007),
                    child: RichText(
                      text: TextSpan(
                          text: "${languages.paymentType} :",
                          style: bodyText(textColor: colorTextCommonLight),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  " ${getPaymentType(widget.ordersItems.paymentType)}",
                              style: bodyText(textColor: Colors.black),
                            )
                          ]),
                    )),
                Container(
                  margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.012),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          CustomIcons.delivery,
                          size: deviceAverageSize * 0.03,
                          color: colorTextLight,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.01),
                          child: Text(
                            widget.ordersItems.orderProductList,
                            style: bodyText(textColor: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: deviceWidth * 0.22),
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.007),
                        child: MaterialButton(
                          height: height,
                          shape: RoundedRectangleBorder(
                              borderRadius: borderRadius,
                              side: const BorderSide(color: colorPrimary)),
                          onPressed: widget.viewFun,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth * 0.005),
                              child: Text(languages.view,
                                  textAlign: TextAlign.center,
                                  style: bodyText(
                                      textColor: colorPrimary,
                                      fontSize: textSizeSmall,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),
                    if (widget.orderStatus == OrderStatus.pendingOrder)
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.007),
                          child: MaterialButton(
                            height: height,
                            shape: RoundedRectangleBorder(
                                borderRadius: borderRadius,
                                side: const BorderSide(color: Colors.red)),
                            onPressed: widget.rejectFun,
                            color: Colors.red,
                            child: Text(languages.reject,
                                textAlign: TextAlign.center,
                                style: bodyText(
                                    textColor: colorWhite,
                                    fontSize: textSizeSmall,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.007),
                        child: MaterialButton(
                          height: height,
                          shape: RoundedRectangleBorder(
                              borderRadius: borderRadius,
                              side: BorderSide(
                                  color: isButtonVisible()
                                      ? widget.orderStatus ==
                                                  OrderStatus.pendingOrder ||
                                              widget.orderStatus ==
                                                  OrderStatus.processing
                                          ? colorAccept
                                          : colorPrimary
                                      : colorWhite)),
                          onPressed: isButtonVisible()
                              ? widget.orderStatus == OrderStatus.pendingOrder
                                  ? widget.acceptFun
                                  : widget.orderStatus == OrderStatus.processing
                                      ? widget.doneFun
                                      : null
                              : null,
                          color: widget.orderStatus == OrderStatus.pendingOrder
                              ? colorAccept
                              : colorPrimary,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth * 0.005),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.setProgress ?? false)
                                    Container(
                                      margin: EdgeInsetsDirectional.only(
                                          end: deviceWidth * 0.02),
                                      child: SizedBox(
                                        width: deviceAverageSize * 0.025,
                                        height: deviceAverageSize * 0.025,
                                        child: CircularProgressIndicator(
                                          strokeWidth:
                                              deviceAverageSize * 0.003,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(colorWhite),
                                        ),
                                      ),
                                    ),
                                  Text(getButtonName(widget.orderStatus),
                                      textAlign: TextAlign.center,
                                      style: bodyText(
                                          textColor: isButtonVisible()
                                              ? colorWhite
                                              : colorPrimary,
                                          fontSize: textSizeSmall,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getButtonName(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.pendingOrder) {
      return languages.acceptOrder;
    } else if (orderStatus == OrderStatus.accept) {
      // return languages.startProcess;
      return languages.startProcess;
    } else if (orderStatus == OrderStatus.processing ||
        orderStatus == OrderStatus.ready) {
      return languages.orderReady;
    } else if (orderStatus == OrderStatus.dispatch) {
      return widget.ordersItems.userTakenType == 2
          ? languages.orderPickedUp
          : languages.orderDispatched;
    }

    return "";
  }

  bool isButtonVisible() {
    if (widget.orderStatus == OrderStatus.pendingOrder ||
        widget.orderStatus == OrderStatus.processing) {
      return true;
    }
    return false;
  }
}
