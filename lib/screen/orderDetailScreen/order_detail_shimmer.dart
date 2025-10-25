// Path: lib/screen/orderDetailScreen/order_detail_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../commonView/widget_util.dart';
import '../../utils/common_util.dart';
import 'order_detail_dl.dart';

class OrderDetailShimmer extends StatelessWidget {
  const OrderDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget v1 = Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01, horizontal: deviceWidth * 0.03),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(deviceAverageSize * 0.08),
                child: Container(
                  color: Colors.black,
                  width: deviceAverageSize * 0.085,
                  height: deviceAverageSize * 0.085,
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.black,
                      height: deviceHeight * 0.015,
                      width: deviceWidth * 0.35,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                      color: Colors.black,
                      height: deviceHeight * 0.011,
                      width: deviceWidth * 0.22,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Shimmer.fromColors(
        baseColor: colorShimmerBg,
        highlightColor: highlightColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.005),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.008, horizontal: deviceWidth * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkOrderStatus(
                        0,
                        isRight: false,
                        padding: EdgeInsetsDirectional.only(
                            start: deviceWidth * 0.01, end: deviceWidth * 0.02, top: deviceHeight * 0.006, bottom: deviceHeight * 0.006),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.032),
                        child: Text(
                          languages.customer,
                          style: bodyText(fontSize: textSizeRegular),
                        ),
                      ),
                      v1,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01, horizontal: deviceWidth * 0.032),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                languages.deliveryAddress,
                                style: bodyText(fontSize: textSizeRegular),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black,
                              height: deviceAverageSize * 0.03,
                              margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.005),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black54,
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01, horizontal: deviceWidth * 0.032),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                languages.scheduleOrderTime,
                                style: bodyText(fontSize: textSizeRegular),
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        color: colorWhite,
                                        size: deviceAverageSize * 0.03,
                                      ),
                                      Container(
                                        color: Colors.black,
                                        height: deviceAverageSize * 0.025,
                                        width: deviceWidth * 0.4,
                                        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        color: colorWhite,
                                        size: deviceAverageSize * 0.03,
                                      ),
                                      Container(
                                        margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
                                        color: Colors.black,
                                        height: deviceHeight * 0.02,
                                        width: deviceWidth * 0.25,
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
                        margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.008, horizontal: deviceWidth * 0.03),
                        child: Text(
                          languages.orderTime,
                          style: bodyText(fontSize: textSizeRegular),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.008, horizontal: deviceWidth * 0.03),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: colorTextCommonLight,
                                  size: deviceAverageSize * 0.03,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016),
                                  color: Colors.black,
                                  height: deviceHeight * 0.02,
                                  width: deviceWidth * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * 0.01,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: colorTextCommonLight,
                                  size: deviceAverageSize * 0.03,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016),
                                  color: Colors.black,
                                  height: deviceHeight * 0.016,
                                  width: deviceWidth * 0.24,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.008, horizontal: deviceWidth * 0.035),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.035),
                        width: double.infinity,
                        child: Text(
                          languages.deliveryPerson,
                          style: bodyText(fontSize: textSizeRegular),
                        ),
                      ),
                      v1,
                    ],
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.008, horizontal: deviceWidth * 0.03),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01, horizontal: deviceWidth * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Text(
                              "${languages.bookingID} ###########",
                              style: bodyText(fontSize: textSizeRegular),
                            )),
                        Table(
                          defaultColumnWidth: const IntrinsicColumnWidth(),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                          },
                          children: getProductList(),
                        ),
                        Divider(
                          height: deviceHeight * 0.008,
                          color: colorMainView,
                          indent: 6,
                          thickness: 1,
                          endIndent: 6,
                        ),
                        Table(
                          defaultColumnWidth: const IntrinsicColumnWidth(),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                          },
                          children: getInvoice(),
                          // children: getInvoice(context),
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(deviceAverageSize * 0.007),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                        height: deviceHeight * 0.045,
                        decoration: getBoxDecoration(radius: deviceAverageSize * 0.01)),
                    Container(
                        height: deviceHeight * 0.045,
                        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                        decoration: getBoxDecoration(radius: deviceAverageSize * 0.01)),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  getProductList() {
    return List<ItemList>.generate(
      3,
      (index) => ItemList(),
    ) // Loops through dataColumnText, each iteration assigning the value to element
        .map(
          ((element) => TableRow(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: colorWhite,
                      height: 15,
                      width: 100,
                    ),
                    Container(
                      height: 5,
                    ),
                    Container(
                      color: colorWhite,
                      height: 10,
                      width: 150,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.02),
                          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016),
                          decoration: getBoxDecoration(
                              color: colorPrimary.withOpacity(0.2), radius: deviceAverageSize * 0.006, border: Border.all(color: colorPrimaryDark)),
                          child: Text(
                            "0",
                            textAlign: TextAlign.start,
                            style: bodyText(fontSize: textSizeSmall, textColor: colorTextCommonLight, fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(width: deviceWidth * 0.03),
                        const Text("X"),
                        SizedBox(width: deviceWidth * 0.03),
                        Text(getAmountWithCurrency(getDouble(0)))
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.012),
                  // padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016),
                  child: Text(
                    getAmountWithCurrency(getDouble(0)),
                    textAlign: TextAlign.start,
                    style: bodyText(fontSize: textSizeSmall, textColor: colorTextCommon, fontWeight: FontWeight.normal),
                  ),
                ),
              ])),
        )
        .toList();
  }

  getInvoice() {
    return List<String>.generate(5, (i) => "") // Loops through dataColumnText, each iteration assigning the value to element
        .map(
          ((element) => TableRow(children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.006),
                  width: deviceWidth * 0.012,
                  height: deviceHeight * 0.012,
                  color: Colors.black,
                ),
                Container(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.006),
                  color: Colors.black,
                  width: deviceWidth * 0.1,
                  height: deviceHeight * 0.007,
                )
              ])),
        )
        .toList();
  }
}
