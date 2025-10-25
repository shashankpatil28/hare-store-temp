// Path: lib/screen/liveChatScreen/chating/item_chatting.dart

import 'package:flutter/material.dart';

import '../../../utils/common_util.dart';
import '../chatHistory/chat_history_dl.dart';

class ItemChatting extends StatelessWidget {
  final ModelChatting modelChatting;
  final String userId;

  const ItemChatting({super.key, required this.userId, required this.modelChatting});

  @override
  Widget build(BuildContext context) => userId.trim() == modelChatting.senderId
      ? Container(
          alignment: AlignmentDirectional.centerEnd,
          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008, start: deviceWidth * 0.1, end: deviceWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: deviceWidth * 0.025,
                  end: deviceWidth * 0.025,
                  top: deviceHeight * 0.01,
                  bottom: deviceHeight * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(deviceAverageSize * 0.01),
                      topEnd: Radius.circular(deviceAverageSize * 0.01),
                      bottomStart: Radius.circular(deviceAverageSize * 0.01),
                      bottomEnd: Radius.zero),
                  color: colorPrimary.withOpacity(0.08),
                ),
                child: Text(
                  modelChatting.message ?? "",
                  textAlign: TextAlign.end,
                  style: bodyText(fontSize: textSizeSmallest, textColor: colorBlack),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008),
                child: Text(
                  getChatDateTime(modelChatting.date ?? "", format: "MMM d yyyy hh:mm aa"),
                  textAlign: TextAlign.end,
                  style: bodyText(fontSize: 0.018, textColor: colorTextCommonLight),
                ),
              ),
            ],
          ),
        )
      : Container(
          alignment: AlignmentDirectional.centerStart,
          margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008, start: deviceWidth * 0.02, end: deviceWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: deviceWidth * 0.025,
                  end: deviceWidth * 0.025,
                  top: deviceHeight * 0.01,
                  bottom: deviceHeight * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(deviceAverageSize * 0.01),
                      topEnd: Radius.circular(deviceAverageSize * 0.01),
                      bottomStart: Radius.zero,
                      bottomEnd: Radius.circular(deviceAverageSize * 0.01)),
                  color: const Color(0xffF5F5F5),
                ),
                child: Text(
                  modelChatting.message ?? "",
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: textSizeSmallest, textColor: colorBlack),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.008),
                child: Text(
                  getChatDateTime(modelChatting.date ?? "", format: "MMM d yyyy hh:mm aa"),
                  textAlign: TextAlign.start,
                  style: bodyText(fontSize: 0.018, textColor: colorTextCommonLight),
                ),
              ),
            ],
          ),
        );
}
