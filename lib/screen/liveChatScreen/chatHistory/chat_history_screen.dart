// Path: lib/screen/liveChatScreen/chatHistory/chat_history_screen.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../../commonView/no_record_found.dart';
import '../../../config/chat_constant.dart';
import '../../../utils/common_util.dart';
import '../chating/chatting_screen.dart';
import 'chat_history_bloc.dart';
import 'chat_history_dl.dart';
import 'chat_history_shimmer.dart';
import 'item_chat_history.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  ChatHistoryScreenState createState() => ChatHistoryScreenState();
}

class ChatHistoryScreenState extends State<ChatHistoryScreen> {
  late ChatHistoryBloc _chatHistoryBloc;

  @override
  void didChangeDependencies() {
    _chatHistoryBloc = ChatHistoryBloc();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _chatHistoryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: toolbarStyle(),
        title: Text(languages.liveChat),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.005),
        child: StreamBuilder(
          stream: _chatHistoryBloc.getChatHistory().onValue,
          builder: (context, snap) {
            Widget shimmer = Container(
              margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
              child: const ChatHistoryShimmer(
                enabled: true,
              ),
            );
            if (snap.connectionState == ConnectionState.waiting) {
              return shimmer;
            } else {
              if (snap.hasData && !snap.hasError && snap.data != null && snap.data!.snapshot.value != null) {
                return FirebaseAnimatedList(
                  query: _chatHistoryBloc.getChatHistory(),
                  reverse: true,
                  shrinkWrap: true,
                  sort: (DataSnapshot a, DataSnapshot b) {
                    Map<String, dynamic> resultA = Map<String, dynamic>.from(a.value as Map<dynamic, dynamic>);
                    Map<String, dynamic> resultB = Map<String, dynamic>.from(b.value as Map<dynamic, dynamic>);
                    return resultA[ChatConstant.userDateTime].compareTo(resultB[ChatConstant.userDateTime]);
                  },
                  defaultChild: shimmer,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    ModelChatList modelChatList = ModelChatList.fromSnapshot(snapshot);
                    String snapshotKey = snapshot.key!;
                    return GestureDetector(
                      onTap: () {
                        openScreen(
                          context,
                          ChattingScreen(
                            chatWithId: modelChatList.userId,
                            chatWithImage: modelChatList.userProfile,
                            chatWithName: modelChatList.userName,
                            chatWithServicesName: modelChatList.userServicesName,
                            chatWithUserType: modelChatList.userType,
                          ),
                        );
                      },
                      child: SizeTransition(
                        sizeFactor: animation,
                        child: ItemChatHistory(
                          modelChatList: modelChatList,
                          chatHistoryBloc: _chatHistoryBloc,
                          snapshotKey: snapshotKey,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return NoRecordFound(
                  image: "assets/svgs/empty_chat.svg",
                  message: languages.chatHistoryEmpty,
                  height: deviceHeight * 0.2,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
