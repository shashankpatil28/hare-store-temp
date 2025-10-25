// Path: lib/screen/productsScreen/product_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/common_util.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(deviceAverageSize * 0.007),
        child: Column(
          children: [listItem(context)],
        ),
      )),
    );
  }

  Widget listItem(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Container(
            margin: EdgeInsets.all(deviceAverageSize * 0.007),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: deviceAverageSize * 0.1,
                  height: deviceAverageSize * 0.1,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.015),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.0035),
                        width: double.infinity,
                        height: deviceHeight * 0.012,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.003),
                      ),
                      Container(
                        width: double.infinity,
                        height: deviceHeight * 0.012,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.003),
                      ),
                      Container(
                        width: deviceWidth * 0.1,
                        height: deviceHeight * 0.01,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsetsDirectional.only(start: 0, end: 0),
      itemCount: 10,
    );
  }
}
