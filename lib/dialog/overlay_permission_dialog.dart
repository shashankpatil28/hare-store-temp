// Path: lib/dialog/overlay_permission_dialog.dart

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../commonView/custom_switch.dart';
import '../commonView/my_widgets.dart';
import '../utils/common_util.dart';

class OverlayPermissionDialog extends StatefulWidget {
  const OverlayPermissionDialog({super.key});

  @override
  OverlayPermissionDialogState createState() => OverlayPermissionDialogState();
}

class OverlayPermissionDialogState extends State<OverlayPermissionDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MODIFIED: Added appName variable
    final String appName = 'Hare Store';

    return Dialog(
      insetPadding: EdgeInsets.all(dialogPadding),
      backgroundColor: colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(deviceAverageSize * 0.02),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.015),
              child: Column(
                children: [
                  Text(
                    // MODIFIED: Used string interpolation
                    'Allow $appName to display over Other apps',
                    textAlign: TextAlign.center,
                    style: bodyText(
                      textColor: colorBlack,
                      fontSize: textSizeRegular,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.02),
                    child: Text(
                      // MODIFIED: Used string interpolation
                      'Allow $appName to display over Other apps in Order to receive orders when you\'re online.',
                      textAlign: TextAlign.start,
                      style: bodyText(
                        textColor: colorTextCommon,
                        fontSize: textSizeSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.005),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceAverageSize * 0.015,
                          height: deviceAverageSize * 0.015,
                          margin: EdgeInsets.only(right: deviceWidth * 0.02),
                          decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(deviceAverageSize * 0.025)),
                        ),
                        Flexible(
                          child: Text(
                            'Tap Allow and slide the toggle on the Settings screen on to on',
                            textAlign: TextAlign.start,
                            style: bodyText(
                              textColor: colorTextCommon,
                              fontSize: textSizeSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.005),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceAverageSize * 0.015,
                          height: deviceAverageSize * 0.015,
                          margin: EdgeInsets.only(right: deviceWidth * 0.02),
                          decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(deviceAverageSize * 0.025)),
                        ),
                        Flexible(
                          child: Text(
                            'Set the Quick access icon to on to see this icon over other apps',
                            textAlign: TextAlign.start,
                            style: bodyText(
                              textColor: colorTextCommon,
                              fontSize: textSizeSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.015),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceAverageSize * 0.05,
                          height: deviceAverageSize * 0.05,
                          margin: EdgeInsets.only(right: deviceWidth * 0.02),
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            languages.quickAccessIcon,
                            textAlign: TextAlign.start,
                            style: bodyText(
                              textColor: colorTextCommon,
                              fontSize: textSizeSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        CustomSwitch(
                          width: deviceWidth * 0.1,
                          radius: deviceAverageSize * 0.05,
                          activeColor: colorGreen,
                          disableColor: colorMainLightGray,
                          thumbColor: colorWhite,
                          innerPadding: EdgeInsets.all(deviceAverageSize * 0.006),
                          thumbSize: deviceAverageSize * 0.03,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  CustomRoundedButton(
                    context,
                    languages.settingsPermission,
                    () {
                      _requestPermissions().then((value) {
                        Navigator.pop(context);
                      });
                    },
                    minWidth: commonBtnWidthLargest,
                    minHeight: commonBtnHeightSmall,
                    setBorder: false,
                    bgColor: colorPrimary,
                    textColor: colorWhite,
                    textSize: textSizeRegular,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    margin: EdgeInsetsDirectional.only(
                        start: deviceWidth * 0.01, top: deviceHeight * 0.01, bottom: deviceHeight * 0.01, end: deviceWidth * 0.01),
                    padding: EdgeInsetsDirectional.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestPermissions() async {
    await Permission.systemAlertWindow.request();
  }
}