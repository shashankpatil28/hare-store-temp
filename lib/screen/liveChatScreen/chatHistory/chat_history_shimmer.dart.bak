// Path: lib/screen/liveChatScreen/chatHistory/chat_history_shimmer.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/common_util.dart';

class ChatHistoryShimmer extends StatelessWidget {
  final bool enabled;

  const ChatHistoryShimmer({super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Shimmer.fromColors(
          baseColor: colorShimmerBg,
          highlightColor: Colors.grey.shade100,
          enabled: enabled,
          period: const Duration(milliseconds: 800),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.only(top: 0, bottom: deviceHeight * 0.02),
            itemCount: 8,
            itemBuilder: (BuildContext context, position) {
              return Container(
                margin: EdgeInsetsDirectional.only(
                    start: deviceWidth * 0.012, top: deviceHeight * 0.008, bottom: deviceHeight * 0.008, end: deviceWidth * 0.012),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(deviceAverageSize * 0.05),
                            child: Icon(
                              Icons.account_circle_rounded,
                              color: colorDefaultUserProfileTint,
                              size: deviceAverageSize * 0.1,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.008, end: deviceWidth * 0.008),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.1),
                                            width: deviceWidth * 0.6,
                                            color: Colors.black,
                                            height: deviceHeight * 0.025,
                                          ),
                                          Container(
                                            margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.002),
                                            width: deviceWidth * 0.3,
                                            color: Colors.black,
                                            height: deviceHeight * 0.025,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: deviceWidth * 0.2,
                                            color: Colors.black,
                                            height: deviceHeight * 0.025,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.01),
                                            width: deviceWidth * 0.15,
                                            alignment: AlignmentDirectional.topEnd,
                                            child: Icon(
                                              Icons.delete,
                                              color: colorMainGray,
                                              size: deviceAverageSize * 0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.065),
                      child: Divider(
                        color: colorMainView,
                        height: deviceHeight * 0.005,
                        thickness: deviceWidth * 0.002,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
