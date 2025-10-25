// Path: lib/screen/bankDetailScreen/bank_detail_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/common_util.dart';

class BankDetailShimmer extends StatelessWidget {
  const BankDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBg,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.1),
        child: Form(
          child: Container(
            margin: EdgeInsets.all(deviceAverageSize * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: deviceHeight * 0.06, color: Colors.black),
                SizedBox(height: deviceHeight * 0.02),
                Container(height: deviceHeight * 0.06, color: Colors.black),
                SizedBox(height: deviceHeight * 0.02),
                Container(height: deviceHeight * 0.06, color: Colors.black),
                SizedBox(height: deviceHeight * 0.02),
                Container(height: deviceHeight * 0.06, color: Colors.black),
                SizedBox(height: deviceHeight * 0.02),
                Container(height: deviceHeight * 0.06, color: Colors.black),
                SizedBox(height: deviceHeight * 0.02),
                Container(height: deviceHeight * 0.06, color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
