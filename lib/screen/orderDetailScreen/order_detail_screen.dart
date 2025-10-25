// Path: lib/screen/orderDetailScreen/order_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../commonView/custom_person_detail.dart';
import '../../commonView/item_key_value.dart';
import '../../commonView/my_widgets.dart';
import '../../commonView/zoom_image_view.dart';
import '../../config/chat_constant.dart';
import '../../dialog/rejectDialog/reject_order_dialog.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/common_util.dart';
import '../../utils/order_status.dart';
import '../homeScreen/home_dl.dart';
import '../homeScreen/home_screen.dart';
import '../liveChatScreen/chating/chatting_screen.dart';
import 'item_deliveries_order_detail_product.dart';
import 'order_detail_bloc.dart';
import 'order_detail_dl.dart';
import 'order_detail_shimmer.dart';

class OrderDetailScreen extends StatefulWidget {
  final bool setAction, playRing, isFromNotification;
  final int orderId;
  final Function(HomeResponse)? updateList;

  const OrderDetailScreen(
      {super.key,
      this.setAction = false,
      required this.orderId,
      this.updateList,
      this.playRing = false,
      this.isFromNotification = false});

  @override
  State<StatefulWidget> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderDetailBloc? bloc;
  double elevation = deviceAverageSize * 0.0035;

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    bloc = OrderDetailBloc(context, this, widget.orderId,
        updateList: widget.updateList, playRing: widget.playRing);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: colorMainBackground,
        appBar: AppBar(
          leading: const BackButton(),
          automaticallyImplyLeading: true,
          title: Text(
            languages.orderDetail,
            style: toolbarStyle(),
          ),
          actions: [
            Container(
              margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.025),
              child: StreamBuilder<bool>(
                  stream: bloc?.printerAvailable,
                  builder: (context, snapPrint) {
                    bool isPrintAvailable =
                        (snapPrint.hasData) ? (snapPrint.data ?? false) : false;
                    return isPrintAvailable
                        ? StreamBuilder<bool>(
                            stream: bloc?.printingBusy,
                            builder: (context, snapBusy) {
                              bool isPrinterBusy = (snapBusy.hasData)
                                  ? (snapBusy.data ?? false)
                                  : false;
                              return isPrinterBusy
                                  ? Loading(
                                      color: colorPrimary,
                                      size: deviceAverageSize * 0.03,
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        bloc?.printInvoice();
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        padding: EdgeInsetsDirectional.all(
                                            deviceAverageSize * 0.01),
                                        child: Icon(
                                          Icons.print_sharp,
                                          color: colorPrimary,
                                          size: deviceAverageSize * 0.04,
                                        ),
                                      ));
                            })
                        : Container();
                  }),
            )
          ],
        ),
        body: StreamBuilder<ApiResponse<OrderDetailResponse>>(
            stream: bloc!.orderDetailSubject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data?.status ?? Status.error) {
                  case Status.loading:
                    return const OrderDetailShimmer();
                  case Status.completed:
                    OrderDetailResponse? data = snapshot.data!.data;
                    var headerStyle = bodyText(
                        fontWeight: FontWeight.w600,
                        fontSize: textSizeMediumBig);
                    if (data != null) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            vertical: deviceHeight * 0.006),
                        child: Column(
                          children: [
                            Container(
                                color: colorWhite,
                                margin: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.008),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        checkOrderStatus(
                                          data.orderStatus,
                                          isRight: false,
                                          padding: EdgeInsetsDirectional.only(
                                              start: deviceWidth * 0.01,
                                              end: deviceWidth * 0.02,
                                              top: deviceHeight * 0.006,
                                              bottom: deviceHeight * 0.006),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: deviceWidth * 0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (data.orderStatus == 3 ||
                                              data.orderStatus == 4)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          deviceWidth * 0.03),
                                                  child: Text(
                                                    languages.cancelReason,
                                                    style: bodyText(
                                                      fontSize: textSizeRegular,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      textColor:
                                                          colorTextCommon,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: deviceWidth * 0.03,
                                                    left: deviceWidth * 0.03,
                                                    bottom:
                                                        deviceHeight * 0.012,
                                                  ),
                                                  child: Text(
                                                    data.cancelReason ?? "--",
                                                    style: bodyText(
                                                      fontSize: textSizeRegular,
                                                      textColor:
                                                          colorTextCommonLight,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: deviceWidth * 0.03),
                                            child: Text(
                                              languages.customer,
                                              style: headerStyle,
                                            ),
                                          ),
                                          CustomPersonDetail(
                                            personImage: data.customerImage,
                                            personContact: data.customerContact,
                                            personName: data.customerName,
                                            imgErrorHolder: Image.asset(
                                              "assets/images/avatar_user.png",
                                              fit: BoxFit.cover,
                                              height: double.infinity,
                                              width: double.infinity,
                                            ),
                                            onPressedCall: (isUserChatVisible(
                                                    data.orderStatus,
                                                    data.userTakenType))
                                                ? () {
                                                    String contact =
                                                        data.customerContact;
                                                    if (contact.isNotEmpty) {
                                                      launchUrlString(
                                                          "tel:$contact");
                                                    }
                                                  }
                                                : null,
                                            onPressedChat: (isUserChatVisible(
                                                    data.orderStatus,
                                                    data.userTakenType))
                                                ? () {
                                                    navigationPage(
                                                      context,
                                                      ChattingScreen(
                                                        chatWithId: ChatConstant
                                                                .userIdCode +
                                                            data.userId
                                                                .toString(),
                                                        chatWithImage:
                                                            data.customerImage,
                                                        chatWithName:
                                                            data.customerName,
                                                        chatWithServicesName:
                                                            languages.customer,
                                                        chatWithUserType:
                                                            chatWithTypeUser,
                                                      ),
                                                    );
                                                  }
                                                : null,
                                          ),
                                          (data.userTakenType == 2)
                                              ? Container(
                                                  width: double.infinity,
                                                  color: colorPrimary,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          deviceHeight * 0.011),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          deviceHeight * 0.011,
                                                      horizontal:
                                                          deviceWidth * 0.03),
                                                  child: Text(
                                                      languages.takeaway,
                                                      style: bodyText(
                                                          textColor:
                                                              colorWhite)),
                                                )
                                              : Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          deviceHeight * 0.011,
                                                      horizontal:
                                                          deviceWidth * 0.03),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          languages
                                                              .deliveryAddress,
                                                          style: headerStyle,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        margin: EdgeInsetsDirectional
                                                            .only(
                                                                top:
                                                                    deviceHeight *
                                                                        0.005),
                                                        child: Text(
                                                          data.deliveryAddress,
                                                          style: bodyText(
                                                              textColor:
                                                                  colorTextCommonLight,
                                                              fontSize:
                                                                  textSizeSmall),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          if (data.additionalRemark.isNotEmpty)
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      deviceHeight * 0.012,
                                                  horizontal:
                                                      deviceWidth * 0.03),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      languages.instruction,
                                                      style: headerStyle,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsetsDirectional
                                                        .only(
                                                            top: deviceHeight *
                                                                0.005),
                                                    child: Text(
                                                        data.additionalRemark,
                                                        style: bodyText(
                                                            textColor:
                                                                colorTextCommonLight,
                                                            fontSize:
                                                                textSizeSmall)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          if (data.scheduleOrderDateTime
                                                  .isNotEmpty &&
                                              data.orderType == 1)
                                            Container(
                                              color: colorPrimary,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: deviceHeight * 0.01,
                                                  horizontal:
                                                      deviceWidth * 0.03),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      languages
                                                          .scheduleOrderTime,
                                                      style: bodyText(
                                                          fontSize:
                                                              textSizeRegular,
                                                          textColor:
                                                              Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsetsDirectional
                                                        .only(
                                                            top: deviceHeight *
                                                                0.01),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .calendar_today_outlined,
                                                              color: colorWhite,
                                                              size:
                                                                  deviceAverageSize *
                                                                      0.03,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          deviceWidth *
                                                                              0.016),
                                                              child: Text(
                                                                getTime(data
                                                                    .scheduleOrderDateTime),
                                                                style: bodyText(
                                                                    textColor:
                                                                        colorWhite,
                                                                    fontSize:
                                                                        textSizeSmall),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: deviceHeight *
                                                              0.01,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .access_time_outlined,
                                                              color: colorWhite,
                                                              size:
                                                                  deviceAverageSize *
                                                                      0.03,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          deviceWidth *
                                                                              0.016),
                                                              child: Text(
                                                                getTime(
                                                                    data
                                                                        .scheduleOrderDateTime,
                                                                    format:
                                                                        "hh:mm a"),
                                                                style: bodyText(
                                                                    textColor:
                                                                        colorWhite,
                                                                    fontSize:
                                                                        textSizeSmall),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                vertical: deviceHeight * 0.008,
                                                horizontal: deviceWidth * 0.03),
                                            child: Text(
                                              languages.orderTime,
                                              style: headerStyle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: deviceHeight * 0.008,
                                                horizontal: deviceWidth * 0.03),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      color:
                                                          colorTextCommonLight,
                                                      size: deviceAverageSize *
                                                          0.03,
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  deviceWidth *
                                                                      0.016),
                                                      child: Text(
                                                        getTime(
                                                            data.orderDateTime),
                                                        style: bodyText(
                                                            textColor:
                                                                colorTextCommonLight,
                                                            fontSize:
                                                                textSizeSmall),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: deviceHeight * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      color:
                                                          colorTextCommonLight,
                                                      size: deviceAverageSize *
                                                          0.03,
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  deviceWidth *
                                                                      0.016),
                                                      child: Text(
                                                        getTime(
                                                            data.orderDateTime,
                                                            format: "hh:mm a"),
                                                        style: bodyText(
                                                            textColor:
                                                                colorTextCommonLight,
                                                            fontSize:
                                                                textSizeSmall),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                (data.prescription != null &&
                                                        (data.prescription ??
                                                                "")
                                                            .trim()
                                                            .isNotEmpty)
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).push(PageRouteBuilder<
                                                                  void>(
                                                              opaque: false,
                                                              transitionDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          400),
                                                              reverseTransitionDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                              pageBuilder: (BuildContext
                                                                      context,
                                                                  Animation<
                                                                          double>
                                                                      animation,
                                                                  Animation<
                                                                          double>
                                                                      secondaryAnimation) {
                                                                return AnimatedBuilder(
                                                                    animation:
                                                                        animation,
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return Opacity(
                                                                        opacity: const Interval(0.0,
                                                                                1.0,
                                                                                curve: Curves.linear)
                                                                            .transform(animation.value),
                                                                        child:
                                                                            ZoomImageView(
                                                                          image:
                                                                              data.prescription ?? "",
                                                                        ),
                                                                      );
                                                                    });
                                                              }));
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          margin: EdgeInsetsDirectional
                                                              .only(
                                                                  top:
                                                                      deviceHeight *
                                                                          0.01),
                                                          child: Text(
                                                            languages
                                                                .prescription,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: bodyText(
                                                                    fontSize:
                                                                        textSizeRegular,
                                                                    textColor:
                                                                        colorPrimary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)
                                                                .copyWith(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            if (data.deliveryPersonName.isNotEmpty)
                              Container(
                                  color: colorWhite,
                                  margin: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.008),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.02),
                                  child: CustomPersonDetail(
                                    personContact: data.deliveryPersonContactNo,
                                    personImage: data.deliveryPersonImage,
                                    imgErrorHolder: Image.asset(
                                      "assets/images/avatar_driver.png",
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                    child1: RatingBarIndicator(
                                      rating:
                                          getDouble(data.deliveryPersonRating),
                                      itemBuilder: (context, index) =>
                                          const Icon(Icons.star,
                                              color: Colors.amber),
                                      unratedColor: Colors.black12,
                                      itemCount: 5,
                                      itemSize: deviceAverageSize * 0.03,
                                      direction: Axis.horizontal,
                                    ),
                                    personName: data.deliveryPersonName,
                                    onPressedCall: (data.orderDeliveryStatus <
                                                5 &&
                                            data.orderStatus !=
                                                orderStatusComplete &&
                                            data.orderStatus !=
                                                changeOrderReject &&
                                            data.orderStatus !=
                                                changeOrderCancel)
                                        ? () {
                                            String contact =
                                                data.deliveryPersonContactNo;
                                            if (contact.isNotEmpty) {
                                              launchUrlString("tel:$contact");
                                            }
                                          }
                                        : null,
                                    onPressedChat: (data.orderDeliveryStatus <
                                                5 &&
                                            data.orderStatus !=
                                                orderStatusComplete &&
                                            data.orderStatus !=
                                                changeOrderReject &&
                                            data.orderStatus !=
                                                changeOrderCancel)
                                        ? () {
                                            navigationPage(
                                                context,
                                                ChattingScreen(
                                                  chatWithId: ChatConstant
                                                          .providerIdCode +
                                                      data.driverId.toString(),
                                                  chatWithImage:
                                                      data.deliveryPersonImage,
                                                  chatWithName:
                                                      data.deliveryPersonName,
                                                  chatWithServicesName:
                                                      languages.driver,
                                                  chatWithUserType:
                                                      chatWithTypeDriver,
                                                ));
                                          }
                                        : null,
                                    child: Container(
                                      margin: EdgeInsetsDirectional.only(
                                          bottom: deviceHeight * 0.01),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            languages.deliveryPerson,
                                            style: headerStyle,
                                          )),
                                        ],
                                      ),
                                    ),
                                  )),
                            Container(
                                color: colorWhite,
                                margin: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.008),
                                padding: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.02),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.01,
                                      horizontal: deviceWidth * 0.03),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "${languages.bookingID} # ${data.orderNo}",
                                            style: bodyText(
                                                fontSize: textSizeRegular,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      if (data.itemList.isNotEmpty)
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsetsDirectional.only(
                                              top: deviceHeight * 0.005),
                                          itemCount: data.itemList.length,
                                          itemBuilder:
                                              (BuildContext context, position) {
                                            print(data
                                                .itemList[position].options);
                                            return ItemDeliveriesOrderDetailProduct(
                                              productListItem:
                                                  data.itemList[position],
                                            );
                                          },
                                        ),
                                      // Container(
                                      //   child: Table(
                                      //     defaultColumnWidth: IntrinsicColumnWidth(),
                                      //     columnWidths: {
                                      //       0: FlexColumnWidth(1),
                                      //     },
                                      //     children: getProductList(context, data.itemList),
                                      //   ),
                                      // ),
                                      Divider(
                                        height: deviceHeight * 0.007,
                                        color: colorMainView,
                                        indent: 6,
                                        thickness: 1,
                                        endIndent: 6,
                                      ),
                                      StreamBuilder<List<KeyValueModel>>(
                                          stream: bloc!.keyValueSubject,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.data != null) {
                                              return ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        top: deviceHeight *
                                                            0.01),
                                                itemCount:
                                                    snapshot.data?.length ?? 0,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        position) {
                                                  return ItemKeyValue(
                                                    keyValueModel: snapshot
                                                        .data![position],
                                                  );
                                                },
                                              );
                                            }
                                            return Container();
                                          }),
                                    ],
                                  ),
                                )),
                            if (widget.setAction &&
                                isButtonVisible(data,
                                    Order.getStatus(data.orderStatus).status))
                              Container(
                                margin:
                                    EdgeInsets.all(deviceAverageSize * 0.007),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (data.orderStatus == 1)
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.all(
                                              deviceAverageSize * 0.007),
                                          child: CustomRoundedButton(
                                            context,
                                            languages.reject,
                                            () {
                                              showRejectDialog(context, bloc!);
                                            },
                                            bgColor: Colors.red,
                                            minWidth: 0.2,
                                            minHeight: 0.05,
                                            fontWeight: FontWeight.w700,
                                            textSize: textSizeMediumBig,
                                          ),
                                        ),
                                      ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.all(
                                              deviceAverageSize * 0.007),
                                          child: StreamBuilder(
                                            stream: bloc!.statusSubject,
                                            builder: (context, snapshot) {
                                              return CustomRoundedButton(
                                                context,
                                                getButtonName(
                                                    context,
                                                    data,
                                                    Order.getStatus(
                                                            data.orderStatus)
                                                        .status),
                                                () {
                                                  progressOrder(
                                                      bloc!,
                                                      Order.getStatus(
                                                              data.orderStatus)
                                                          .status);
                                                },
                                                setProgress:
                                                    snapshot.data?.status ==
                                                        Status.loading,
                                                minWidth: 0.2,
                                                minHeight: 0.05,
                                                fontWeight: FontWeight.w700,
                                                textSize: textSizeMediumBig,
                                                bgColor: (Order.getStatus(data
                                                                .orderStatus)
                                                            .status ==
                                                        OrderStatus
                                                            .pendingOrder)
                                                    ? colorAccept
                                                    : colorPrimary,
                                              );
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              )
                          ],
                        ),
                      );
                    }
                    break;
                  case Status.error:
                    return Error(
                      errorMessage: snapshot.data!.message ?? "",
                      onRetryPressed: () {
                        bloc?.getOrderDetail(setSubject: true);
                      },
                    );
                }
              }
              return const OrderDetailShimmer();
            }),
      ),
      onWillPop: () async {
        if (widget.isFromNotification) {
          openScreenWithClearPrevious(context, const HomeScreen());
        } else {
          Navigator.pop(context);
        }
        return true;
      },
    );
  }

  String getButtonName(BuildContext context, OrderDetailResponse orderDetail,
      OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.pendingOrder) {
      return languages.acceptOrder;
    } else if (orderStatus == OrderStatus.accept) {
      return languages.startProcess;
    } else if (orderStatus == OrderStatus.processing) {
      return orderDetail.userTakenType == 2
          ? languages.orderReady
          : languages.orderInProcess;
    } else if (orderStatus == OrderStatus.dispatch) {
      return orderDetail.userTakenType == 2
          ? languages.orderPickedUp
          : languages.orderDispatched;
    }
    return "";
  }

  progressOrder(OrderDetailBloc bloc, OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.pendingOrder) {
      bloc.updateOrderStatus(widget.orderId, changeOrderAccept, "",
          subject: bloc.statusSubject);
    } else if (orderStatus == OrderStatus.accept) {
      bloc.updateOrderStatus(widget.orderId, changeOrderStartProcessing, "",
          subject: bloc.statusSubject);
    } else if (orderStatus == OrderStatus.processing) {
      var takeaway = (bloc.orderDetailSubject.value.data!.userTakenType == 2);
      if (takeaway) {
        bloc.updateOrderStatus(widget.orderId, changeOrderDispatch, "",
            subject: bloc.statusSubject);
      }
    } else if (orderStatus == OrderStatus.dispatch) {
      var takeaway = (bloc.orderDetailSubject.value.data!.userTakenType == 2);
      if (takeaway) {
        bloc.updateOrderStatus(widget.orderId, orderStatusComplete, "",
            subject: bloc.statusSubject);
      }
    }
  }

  bool isButtonVisible(
      OrderDetailResponse orderDetail, OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.pendingOrder ||
        orderStatus == OrderStatus.accept ||
        (orderDetail.userTakenType == 2 &&
            (orderStatus == OrderStatus.processing ||
                orderStatus == OrderStatus.dispatch))) {
      return true;
    }
    return false;
  }

  showRejectDialog(BuildContext context, OrderDetailBloc bloc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var rejectOrderDialog = RejectOrderDialog((reason, subject) {
            bloc.updateOrderStatus(widget.orderId, changeOrderReject, reason,
                subject: subject);
          });
          return rejectOrderDialog;
        },
        barrierDismissible: true);
  }

  bool isUserChatVisible(int orderStatus, int userTakenType) {
    if (userTakenType == 1) {
      if (orderStatus != orderStatusComplete &&
          orderStatus != changeOrderReject &&
          orderStatus != changeOrderDispatch &&
          orderStatus != changeOrderCancel) {
        return true;
      } else {
        return false;
      }
    } else {
      if (orderStatus != orderStatusComplete &&
          orderStatus != changeOrderReject &&
          orderStatus != changeOrderCancel) {
        return true;
      } else {
        return false;
      }
    }
  }
}
