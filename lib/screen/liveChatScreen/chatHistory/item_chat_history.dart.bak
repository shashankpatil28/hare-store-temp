// Path: lib/screen/liveChatScreen/chatHistory/item_chat_history.dart

import 'package:flutter/material.dart';

import '../../../commonView/load_image_with_placeholder.dart';
import '../../../utils/common_util.dart';
import 'chat_history_bloc.dart';
import 'chat_history_dl.dart';

class ItemChatHistory extends StatelessWidget {
  final ModelChatList modelChatList;
  final ChatHistoryBloc chatHistoryBloc;
  final String snapshotKey;

  const ItemChatHistory({super.key, required this.modelChatList, required this.chatHistoryBloc, required this.snapshotKey});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.transparent,
        margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, end: deviceWidth * 0.02, top: deviceHeight * 0.01, bottom: deviceHeight * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: LoadImageWithPlaceHolder(
                    image: modelChatList.userProfile,
                    width: deviceAverageSize * 0.09,
                    height: deviceAverageSize * 0.09,
                    defaultAssetImage: getChatWithDefaultProfile(modelChatList.userType),
                    borderRadius: BorderRadius.circular(deviceAverageSize * 0.05),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: AlignmentDirectional.topEnd,
                    margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, end: deviceWidth * 0.008),
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
                                  Text(
                                    modelChatList.userName,
                                    textAlign: TextAlign.start,
                                    style: bodyText(fontSize: textSizeBig, textColor: colorBlack, fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(top: deviceWidth * 0.002),
                                    child: Text(
                                      modelChatList.lastMsg,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyText(fontSize: textSizeRegular, textColor: colorTextCommonLight, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  getChatDateTime(modelChatList.lastMsgTime).trim().isNotEmpty
                                      ? getChatDateTime(modelChatList.lastMsgTime, format: "hh:mm aa")
                                      : modelChatList.lastMsgTime,
                                  // convertFullDateTimeToTime(modelChatList.lastMsgTime).trim().isNotEmpty
                                  //     ? convertFullDateTimeToTime(modelChatList.lastMsgTime)
                                  //     : modelChatList.lastMsgTime,
                                  textAlign: TextAlign.start,
                                  style: bodyText(fontSize: textSizeSmall, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.01),
                                  width: deviceWidth * 0.15,
                                  alignment: AlignmentDirectional.topEnd,
                                  child: GestureDetector(
                                      onTap: () {
                                        chatHistoryBloc.deleteChatHistory(snapshotKey);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: colorMainGray,
                                        size: deviceAverageSize * 0.035,
                                      )),
                                )
                              ],
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
              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.065, top: deviceHeight * 0.005),
              child: Divider(
                color: colorMainView,
                height: deviceHeight * 0.005,
                thickness: deviceWidth * 0.002,
              ),
            ),
          ],
        ),
      );
}
