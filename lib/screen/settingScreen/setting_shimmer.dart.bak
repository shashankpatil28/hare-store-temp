// Path: lib/screen/settingScreen/setting_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../commonView/widget_util.dart';
import '../../utils/common_util.dart';

class SettingShimmer extends StatelessWidget {
  const SettingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                height: deviceHeight * 0.07,
                margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, end: deviceWidth * 0.02),
                decoration: getBoxDecoration(color: Colors.white),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                height: deviceHeight * 0.07,
                margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, end: deviceWidth * 0.02),
                decoration: getBoxDecoration(color: Colors.white),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                height: deviceHeight * 0.07,
                margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, end: deviceWidth * 0.02),
                decoration: getBoxDecoration(color: Colors.white),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                height: deviceHeight * 0.07,
                margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, end: deviceWidth * 0.02),
                decoration: getBoxDecoration(color: Colors.white),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.012, horizontal: deviceWidth * 0.035),
                  child: Text(
                    languages.storeTiming,
                    style: bodyText(fontWeight: FontWeight.w600),
                  )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(deviceAverageSize * 0.007),
                ),
                margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.007, horizontal: deviceWidth * 0.035),
                padding: EdgeInsets.all(deviceAverageSize * 0.01),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder(
                          bottom: BorderSide(width: 1, color: textColorWithOpacity, style: BorderStyle.solid),
                          verticalInside: BorderSide(width: 1, color: textColorWithOpacity, style: BorderStyle.solid)),
                      children: [
                        TableRow(children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.015),
                            child: Text(
                              languages.day,
                              style: bodyText(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.015),
                            child: Text(
                              languages.openingTime,
                              style: bodyText(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.015),
                            child: Text(
                              languages.closingTime,
                              textAlign: TextAlign.right,
                              style: bodyText(),
                            ),
                          )
                        ])
                      ],
                    ),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder(verticalInside: BorderSide(width: 1, color: textColorWithOpacity, style: BorderStyle.solid)),
                      children: getProductList(context),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(deviceAverageSize * 0.02),
                  height: deviceHeight * 0.06,
                  width: buttonMinWidth,
                  decoration: getBoxDecoration(color: colorPrimary, radius: deviceAverageSize * 0.035),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getProductList(BuildContext context) {
    return List.generate(7, (index) => null) // Loops through dataColumnText, each iteration assigning the value to element
        .map(
      ((element) {
        return TableRow(children: [
          GestureDetector(
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Expanded(child: Text(languages.day, style: bodyText(fontWeight: FontWeight.w500)))
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              color: colorPrimary,
              child: Text(languages.openingTime, style: bodyText()),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              color: colorPrimary,
              child: Text(languages.closingTime, style: bodyText()),
            ),
          )
        ]);
      }),
    ).toList();
  }
}
