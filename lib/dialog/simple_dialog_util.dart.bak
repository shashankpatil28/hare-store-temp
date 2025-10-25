// Path: lib/dialog/simple_dialog_util.dart

import 'package:flutter/material.dart';

import '../commonView/my_widgets.dart';
import '../utils/common_util.dart';

class SimpleDialogUtil extends StatelessWidget {
  final String title, message, positiveButtonTxt, negativeButtonTxt;
  final Function() onPositivePress;
  final Function()? onNegativePress;
  final bool isLoading;

  const SimpleDialogUtil({
    super.key,
    required this.title,
    required this.positiveButtonTxt,
    required this.onPositivePress,
    this.message = "",
    this.negativeButtonTxt = "",
    this.onNegativePress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) => Dialog(
          insetPadding: dialogPending,
          shape: RoundedRectangleBorder(borderRadius: dialogBorderRadius),
          child: Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(
                top: deviceHeight * 0.018, start: deviceWidth * 0.03, end: deviceWidth * 0.03, bottom: deviceHeight * 0.005),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: textSizeMediumBig, textColor: colorTextCommon, fontWeight: FontWeight.w600),
                ),
                message.trim().isNotEmpty
                    ? Container(
                        margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008),
                        child: Text(
                          message,
                          textAlign: TextAlign.start,
                          style: bodyText(),
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    negativeButtonTxt.trim().isNotEmpty
                        ? CustomRoundedButton(
                            context,
                            negativeButtonTxt,
                            () {
                              if (onNegativePress != null) {
                                onNegativePress!();
                              }
                            },
                            fontWeight: FontWeight.w600,
                            textSize: textSizeSmall,
                            minWidth: 0.2,
                            minHeight: 0.04,
                            setBorder: true,
                            margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.04, bottom: deviceHeight * 0.01),
                            roundedRectangleBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                  topStart: topLeftRadius, topEnd: topRightRadius, bottomStart: bottomLeftRadius, bottomEnd: bottomRightRadius),
                              side: BorderSide(color: colorPrimary, width: deviceHeight * 0.002, style: BorderStyle.solid),
                            ),
                          )
                        : Container(),
                    CustomRoundedButton(
                      context,
                      positiveButtonTxt,
                      () {
                        onPositivePress();
                      },
                      setProgress: isLoading,
                      fontWeight: FontWeight.w600,
                      textSize: textSizeSmall,
                      minWidth: 0.2,
                      minHeight: 0.04,
                      progressSize: cpiSizeSmallest,
                      bgColor: colorPrimary,
                      textColor: colorWhite,
                      margin: EdgeInsetsDirectional.only(
                          start: deviceWidth * 0.02, top: deviceHeight * 0.04, end: deviceWidth * 0.01, bottom: deviceHeight * 0.01),
                      padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.005, end: deviceWidth * 0.005),
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
