// Path: lib/commonView/custom_shimmer_layout.dart

import 'package:flutter/material.dart';
import '../utils/common_util.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerLayout extends StatefulWidget {
  final bool enabled;

  const CustomShimmerLayout({super.key, this.enabled = true});

  @override
  CustomShimmerLayoutState createState() => CustomShimmerLayoutState();
}

class CustomShimmerLayoutState extends State<CustomShimmerLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.005),
      child: Shimmer.fromColors(
        baseColor: colorShimmerBg,
        highlightColor: Colors.grey.shade100,
        enabled: widget.enabled,
        period: const Duration(milliseconds: 800),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(bottom: deviceHeight * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: deviceAverageSize * 0.11,
                  height: deviceAverageSize * 0.11,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.01),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.05),
                        height: deviceHeight * 0.016,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.004),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.25),
                        height: deviceHeight * 0.014,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.004),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.65),
                        height: deviceHeight * 0.014,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 8,
        ),
      ),
    );
  }
}
