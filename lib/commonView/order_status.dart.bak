// Path: lib/commonView/order_status.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/common_util.dart';
import '../utils/custom_icons.dart';

OrderStatusView pendingStatus(String title, {bool? isRight, EdgeInsetsDirectional? padding}) {
  return OrderStatusView(
    bgColor: colorYellow,
    statusTitle: title,
    isRight: isRight ?? false,
    padding: padding,
  );
}

OrderStatusView cancelStatus(String title, {bool? isRight, EdgeInsetsDirectional? padding}) {
  return OrderStatusView(
    bgColor: Colors.red,
    icon: CustomIcons.timesCircle,
    statusTitle: title,
    isRight: isRight ?? false,
    padding: padding,
  );
}

OrderStatusView completeStatus(String title, {bool? isRight, EdgeInsetsDirectional? padding}) {
  return OrderStatusView(
    bgColor: colorAccept,
    icon: CupertinoIcons.checkmark_seal_fill,
    statusTitle: title,
    isRight: isRight ?? false,
    padding: padding,
  );
}

OrderStatusView orderStatusView(String title, {Color? color, IconData? iconData, bool? isRight, EdgeInsetsDirectional? padding}) {
  return OrderStatusView(
    bgColor: color ?? colorAccept,
    icon: Icons.hourglass_bottom_sharp,
    statusTitle: title,
    isRight: isRight ?? false,
    padding: padding,
  );
}

class OrderStatusView extends StatelessWidget {
  final Color? bgColor;
  final String? statusTitle;
  final IconData? icon;
  final bool isRight;
  final EdgeInsetsDirectional? padding;

  const OrderStatusView({super.key, this.bgColor, this.statusTitle, this.icon, this.isRight = false, this.padding});

  // first you need to tia-up with the any brand that
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsetsDirectional.only(start: 10, end: 8, top: 4, bottom: 4),
      padding: padding,
      margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01, start: deviceWidth * 0.01),
      decoration: getStatusBorder(bgColor ?? colorPrimary, isLeft: isRight),
      child: Row(
        children: [
          Container(
            width: deviceAverageSize * 0.03,
            height: deviceAverageSize * 0.03,
            alignment: Alignment.center,
            child: Icon(
              icon ?? CustomIcons.productsDrawerIc,
              size: deviceAverageSize * 0.025,
              color: colorWhite,
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015),
            child: Text(
              statusTitle ?? "---",
              textAlign: TextAlign.start,
              style: bodyText(fontSize: textSizeSmall, textColor: colorWhite, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    // var radius = isRight ?? false
    //     ? BorderRadiusDirectional.only(
    //   bottomEnd: Radius.circular(deviceAverageSize * 0.025),
    //   topEnd: Radius.circular(deviceAverageSize * 0.025),
    // )
    //     : BorderRadiusDirectional.only(
    //   bottomStart: Radius.circular(deviceAverageSize * 0.025),
    //   topStart: Radius.circular(deviceAverageSize * 0.025),
    // );
    //
    // return Container(
    //     padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.025, vertical: deviceHeight * 0.005),
    //     decoration: BoxDecoration(color: bgColor ?? primary, borderRadius: radius),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Icon(
    //           icon ?? CustomIcons.products_drawer_ic,
    //           color: colorWhite,
    //           size: deviceAverageSize * 0.03,
    //         ),
    //         Container(
    //           margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.012),
    //           child: Text(
    //             statusTitle ?? "---",
    //             style: bodyText(textColor: colorWhite),
    //           ),
    //         ),
    //       ],
    //     ));
  }
}
