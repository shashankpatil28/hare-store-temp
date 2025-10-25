// Path: lib/screen/offerScreen/offer_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../commonView/widget_util.dart';
import '../../utils/common_util.dart';

class OfferShimmer extends StatelessWidget {
  const OfferShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: highlightColor,
      child: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.015, horizontal: deviceWidth * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        height: deviceHeight * 0.07,
                        decoration: getBoxDecoration(color: Colors.black),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        height: deviceHeight * 0.07,
                        decoration: getBoxDecoration(color: Colors.black),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        height: deviceHeight * 0.07,
                        decoration: getBoxDecoration(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(deviceAverageSize * 0.025),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    height: deviceHeight * 0.055,
                    decoration: getBoxDecoration(color: Colors.black, radius: deviceAverageSize * 0.07),
                    margin: EdgeInsets.all(deviceAverageSize * 0.025),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: deviceHeight * 0.055,
                    decoration: getBoxDecoration(color: Colors.black, radius: deviceAverageSize * 0.07),
                    margin: EdgeInsets.all(deviceAverageSize * 0.025),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
