// Path: lib/screen/liveChatScreen/chatHistory/chat_history_dl.dart

import 'package:firebase_database/firebase_database.dart';

import '../../../config/chat_constant.dart';

class ModelChatList {
  String userId = "";
  String userName = "";
  String userProfile = "";
  String lastMsg = "";
  String lastMsgTime = "";
  String userServicesName = "";
  String userFCMToken = "";
  String userDateTime = "";
  int userType = -1;

  ModelChatList(
    this.userId,
    this.userName,
    this.userProfile,
    this.lastMsg,
    this.lastMsgTime,
    this.userServicesName,
    this.userFCMToken,
    this.userDateTime,
  );

  ModelChatList.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> result = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
    userId = result[ChatConstant.userId];
    userName = result[ChatConstant.userName];
    userProfile = result[ChatConstant.userProfile] ?? "";
    lastMsg = result[ChatConstant.userLastMessage] ?? "";
    lastMsgTime = result[ChatConstant.userDateTime] ?? "";
    userServicesName = result[ChatConstant.userServicesName] ?? "";
    userDateTime = result[ChatConstant.userDateTime] ?? "";
    userType = result[ChatConstant.userType] ?? -1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[ChatConstant.userDateTime] = lastMsgTime;
    map[ChatConstant.userLastMessage] = lastMsg;
    map[ChatConstant.userProfile] = userProfile;
    map[ChatConstant.userId] = userId;
    map[ChatConstant.userName] = userName;
    map[ChatConstant.userServicesName] = userServicesName;
    return map;
  }
}

class ModelChatting {
  String? _message, _senderId, _senderName, _date;

  ModelChatting(this._message, this._senderId, this._senderName, this._date);

  String? get message => _message;

  String? get senderId => _senderId;

  String? get senderName => _senderName;

  String? get date => _date;

  ModelChatting.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> result = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
    _message = result[ChatConstant.fbMessage];
    _senderId = result[ChatConstant.fbSenderId];
    _senderName = result[ChatConstant.fbSenderName] ?? "";
    _date = result[ChatConstant.fbMessageTime] ?? "";
  }

  ModelChatting.fromJson(dynamic json) {
    _message = json[ChatConstant.fbMessage];
    _senderId = json[ChatConstant.fbSenderId];
    _senderName = json[ChatConstant.fbSenderName];
    _date = json[ChatConstant.fbMessageTime];
  }
}
