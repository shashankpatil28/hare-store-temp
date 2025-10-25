// Path: lib/screen/ordersHistoryScreen/order_history_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/common_util.dart';

class OrderHistoryShimmer extends StatelessWidget {
  const OrderHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(deviceAverageSize * 0.007),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(deviceAverageSize * 0.007),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(deviceAverageSize * 0.012),
                            ),
                            color: Colors.blue),
                      )),
                ),
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(deviceAverageSize * 0.007),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(deviceAverageSize * 0.012),
                            ),
                            color: Colors.green.shade300),
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(deviceAverageSize * 0.007),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(deviceAverageSize * 0.012),
                            ),
                            color: Colors.blue),
                      )),
                ),
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(deviceAverageSize * 0.007),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(deviceAverageSize * 0.012),
                            ),
                            color: Colors.green.shade300),
                      )),
                ),
              ],
            ),
            listItem(context)
          ],
        ),
      )),
    );
  }

  Widget listItem(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Container(
            margin: EdgeInsets.all(deviceAverageSize * 0.007),
            color: Colors.black26,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.016, vertical: deviceHeight * 0.01),
                  height: deviceAverageSize * 0.035,
                  width: deviceAverageSize * 0.035,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.black,
                      height: deviceHeight * 0.03,
                      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                      child: const Text(
                        "                                                                                                                                                                                    ",
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.045),
                      height: deviceHeight * 0.015,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    Container(
                      height: deviceHeight * 0.012,
                      width: double.infinity,
                      margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.012, top: deviceHeight * 0.012, end: deviceWidth * 0.12),
                      color: Colors.black,
                    ),
                  ],
                )),
              ],
            ));
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsetsDirectional.only(start: 0, end: 0),
      itemCount: 7,
    );
  }
}
