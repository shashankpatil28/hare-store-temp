// Path: lib/screen/liveChatScreen/chatHistory/chat_history_bloc.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import '../../../config/chat_constant.dart';
import '../../../utils/bloc.dart';
import '../../../utils/shared_preferences_util.dart';

class ChatHistoryBloc extends Bloc {
  final DatabaseReference _chatHistoryRef = FirebaseDatabase.instance
      .ref()
      .child(ChatConstant.chat)
      .child(ChatConstant.users)
      .child(ChatConstant.providerIdCode + prefGetInt(prefStoreId).toString());

  DatabaseReference getChatHistory() {
    return _chatHistoryRef;
  }

  deleteChatHistory(String userRefId) {
    _chatHistoryRef.child(userRefId).remove();
  }

  @override
  void dispose() {}
}
