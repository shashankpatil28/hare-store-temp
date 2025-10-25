// Path: lib/screen/liveChatScreen/chating/chatting_screen.dart

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../commonView/custom_text_field.dart';
import '../../../commonView/load_image_with_placeholder.dart';
import '../../../utils/common_util.dart';
import '../../splashScreen/splash_screen.dart';
import '../chatHistory/chat_history_dl.dart';
import 'chatting_bloc.dart';
import 'item_chatting.dart';

class ChattingScreen extends StatefulWidget {
  final String chatWithImage, chatWithName, chatWithId, chatWithServicesName;
  final int chatWithUserType;

  const ChattingScreen({
    super.key,
    required this.chatWithId,
    required this.chatWithName,
    required this.chatWithImage,
    required this.chatWithServicesName,
    this.chatWithUserType = -1,
  });

  @override
  ChattingScreenState createState() => ChattingScreenState();
}

class ChattingScreenState extends State<ChattingScreen> {
  late ChattingBloc _chattingBloc;
  final _controller = ScrollController();
  String serviceName = '';

  @override
  void initState() {
    isChatOpen = true;
    chatState = this;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    isChatOpen = true;
    _chattingBloc = ChattingBloc(context, widget.chatWithId, widget.chatWithName, widget.chatWithImage, widget.chatWithServicesName, widget.chatWithUserType);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _chattingBloc.dispose();
    _controller.dispose();
    isChatOpen = false;
    super.dispose();
  }

  @override
  void deactivate() {
    isChatOpen = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: false,
          titleSpacing: 0,
          titleTextStyle: toolbarStyle(),
          title: Text(languages.liveChat),
        ),
        body: _buildChatting(_chattingBloc),
      ),
      onWillPop: () {
        if (!Navigator.canPop(context)) {
          openScreenWithClearPrevious(context, const SplashScreen());
        }
        return Future.value(true);
      },
    );
  }

  scrollToBottom() {
    Timer(
      const Duration(milliseconds: 500),
      () => _controller.animateTo(
        _controller.position.maxScrollExtent + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  _buildChatting(ChattingBloc bloc) => Column(
        children: [
          Expanded(
            flex: 0,
            child: Container(
              padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.015, top: deviceHeight * 0.012, bottom: deviceHeight * 0.012, end: deviceWidth * 0.015),
              color: colorPrimaryDark,
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: LoadImageWithPlaceHolder(
                      image: widget.chatWithUserType == -1 ? "" : widget.chatWithImage,
                      width: deviceAverageSize * 0.09,
                      height: deviceAverageSize * 0.09,
                      defaultAssetImage: getChatWithDefaultProfile(widget.chatWithUserType),
                      borderRadius: BorderRadius.circular(deviceAverageSize * 0.05),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chatWithUserType == -1 ? languages.admin : widget.chatWithName,
                            textAlign: TextAlign.start,
                            style: bodyText(fontSize: textSizeMediumBig, textColor: colorWhite, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.002,
                          ),
                          Text(
                            getChatWithService(widget.chatWithUserType),
                            textAlign: TextAlign.start,
                            style: bodyText(fontSize: 0.021, textColor: colorWhite),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*Expanded(
            flex: 1,
            child: StreamBuilder(
                stream: _chattingBloc.getChatList().onValue,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.active) {
                    scrollToBottom();
                  }
                  return FirebaseAnimatedList(
                    query: _chattingBloc.getChatList(),
                    reverse: false,
                    shrinkWrap: true,
                    controller: _controller,
                    defaultChild: Container(
                      margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.012),
                      child: const ChattingShimmer(),
                    ),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                      ModelChatting modelChatList = ModelChatting.fromSnapshot(snapshot);
                      return SizeTransition(
                        sizeFactor: animation,
                        child: ItemChatting(
                          userId: _chattingBloc.storeId,
                          modelChatting: modelChatList,
                        ),
                      );
                    },
                  );
                }),
          ),*/
          Expanded(
            flex: 1,
            child: StreamBuilder<List<ModelChatting>>(
                stream: _chattingBloc.subjectChatList,
                builder: (context, snap) {
                  List<ModelChatting> chatList = snap.data ?? [];

                  if (chatList.isNotEmpty) {
                    _controller.jumpTo(0);
                  }

                  return ListView.builder(
                    controller: _controller,
                    itemCount: chatList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      ModelChatting modelChatList = chatList[index];
                      return ItemChatting(
                        userId: _chattingBloc.storeId,
                        modelChatting: modelChatList,
                      );
                    },
                  );
                }),
          ),
          Divider(
            height: 0,
            thickness: deviceHeight * 0.002,
            color: colorMainView,
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015, end: deviceWidth * 0.015, bottom: deviceHeight * 0.01),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.015),
                      child: msgField(bloc),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: GestureDetector(
                      onTap: () {
                        bloc.sendMsg();
                      },
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(deviceAverageSize * 0.035), color: colorPrimary),
                          padding: EdgeInsetsDirectional.all(deviceAverageSize * 0.012),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(isRtl() ? pi : 0),
                            child: Image.asset(
                              "assets/images/ic_chat_arrow.png",
                              width: deviceAverageSize * 0.03,
                              height: deviceAverageSize * 0.03,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  msgField(ChattingBloc bloc) => TextFormFieldCustom(
        backgroundColor: colorWhite,
        controller: bloc.msgController,
        hint: languages.writeAMessageHere,
        keyboardType: TextInputType.multiline,
        maxLine: 4,
        minLine: 1,
      );
}
