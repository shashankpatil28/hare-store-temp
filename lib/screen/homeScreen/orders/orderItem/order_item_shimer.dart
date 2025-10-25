// Path: lib/screen/homeScreen/orders/orderItem/order_item_shimer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../commonView/my_widgets.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/custom_icons.dart';

class OrdersItemShimmer extends StatelessWidget {
  const OrdersItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: highlightColor,
      child: ListView(
        children: List<String>.generate(5, (i) => "")
            .map((e) => Container(
                  color: Colors.black45,
                  width: double.infinity,
                  margin: EdgeInsets.all(deviceAverageSize * 0.012),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.all(deviceAverageSize * 0.015),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              size: deviceAverageSize * 0.03,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.012),
                                        color: Colors.black,
                                        width: deviceWidth * 0.45,
                                        height: deviceHeight * 0.03,
                                      ),
                                      Container(
                                          margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.02),
                                          child: Text(getAmountWithCurrency(00.00),
                                              style: bodyText(fontSize: textSizeBig, textColor: colorTextCommon, fontWeight: FontWeight.w600))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text("${languages.orderId} ############", style: bodyText()),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(deviceAverageSize * 0.007),
                                          child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "${languages.paymentType} :",
                                                  style: bodyText(textColor: colorTextCommon),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "  -",
                                                      style: bodyText(textColor: Colors.black, fontSize: textSizeBig),
                                                    )
                                                  ]),
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.012),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.024),
                              child: Icon(CustomIcons.productsDrawerIc, size: deviceAverageSize * 0.03),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.024),
                                color: Colors.black,
                                height: deviceHeight * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(deviceAverageSize * 0.015),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                constraints: BoxConstraints(maxWidth: deviceWidth * 0.22),
                                margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.007),
                                child: CustomRoundedButton(context, "", () {}),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.007),
                                child: CustomRoundedButton(context, "", () {}),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.007),
                                child: CustomRoundedButton(context, "", () {}),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
