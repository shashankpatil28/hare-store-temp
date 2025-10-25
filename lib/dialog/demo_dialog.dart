// Path: lib/dialog/demo_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../commonView/my_widgets.dart';
import '../utils/common_util.dart';

class DemoDialog extends StatelessWidget {
  const DemoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding: EdgeInsets.only(left: deviceWidth * 0.035, right: deviceWidth * 0.035),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(deviceAverageSize * 0.01)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(
                bottom: deviceHeight * 0.025, top: deviceHeight * 0.025, start: deviceWidth * 0.05, end: deviceWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "This is product Version",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: bodyText(fontSize: 0.036, textColor: colorPrimary, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: deviceHeight * 0.03),
                SvgPicture.asset(
                  "assets/svgs/demo_dialog.svg",
                  width: deviceAverageSize * 0.25,
                  height: deviceAverageSize * 0.25,
                ),
                SizedBox(height: deviceHeight * 0.03),
                Text(
                  "This is a Hare Store Store App of Hare Store product. Explore the services and features of app",
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: textSizeBig, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: deviceHeight * 0.015),
                Text(
                  "The purpose of this version app is that people can understand what they getting from this app, how our app works, what are features we provide, and many more.",
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: textSizeSmallest, textColor: colorTextCommonLight),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomRoundedButton(
                        context,
                        "Contact Sales Support",
                        () {},
                        fontWeight: FontWeight.bold,
                        textSize: textSizeLarge,
                        minWidth: deviceWidth,
                        maxLine: 2,
                        textAlign: TextAlign.center,
                        setBorder: true,
                        textColor: colorPrimary,
                        bgColor: colorWhite,
                        minHeight: commonBtnHeight,
                        margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.015, top: deviceHeight * 0.03),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomRoundedButton(
                        context,
                        "Proceed",
                        () {
                          Navigator.pop(context, true);
                        },
                        fontWeight: FontWeight.bold,
                        textSize: textSizeLarge,
                        minWidth: deviceWidth,
                        minHeight: commonBtnHeight,
                        margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015, top: deviceHeight * 0.03),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
