// Path: lib/screen/liveChatScreen/chating/chatting_bloc.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/chat_constant.dart';
import '../../../network/api_base_helper.dart';
import '../../../utils/bloc.dart';
import '../../../utils/common_util.dart';
import '../chatHistory/chat_history_dl.dart';

class ChattingBloc extends Bloc {
  String tag = "ChattingBloc>>>";
  late String chatWithId,
      chatWithName,
      chatWithImage,
      chatWithFCMToken,
      chatWithServicesName,
      storeId,
      storeName;
  final int chatWithUserType;
  late FirebaseDatabase firebaseDatabase;
  late DatabaseReference _refUserToChatWith,
      _refChatWithToUser,
      _referenceUser,
      _referenceChatWith,
      _referenceServerTimeZone;
  TextEditingController msgController = TextEditingController();

  final subjectChatList = BehaviorSubject<List<ModelChatting>>();

  ChattingBloc(BuildContext context, this.chatWithId, this.chatWithName,
      this.chatWithImage, this.chatWithServicesName, this.chatWithUserType) {
    storeName = prefGetString(prefStoreName);
    storeId = ChatConstant.providerIdCode + prefGetInt(prefStoreId).toString();
    logd(tag, "id==$storeId");
    logd(tag, "id==${"${storeId}_$chatWithId"}");

    firebaseDatabase = FirebaseDatabase.instance;
    _refUserToChatWith = firebaseDatabase
        .ref()
        .child(ChatConstant.chat)
        .child(ChatConstant.messages)
        .child("${storeId}_$chatWithId");
    _refChatWithToUser = firebaseDatabase
        .ref()
        .child(ChatConstant.chat)
        .child(ChatConstant.messages)
        .child("${chatWithId}_$storeId");
    _referenceUser = firebaseDatabase
        .ref()
        .child(ChatConstant.chat)
        .child(ChatConstant.users)
        .child(storeId);
    _referenceChatWith = firebaseDatabase
        .ref()
        .child(ChatConstant.chat)
        .child(ChatConstant.users)
        .child(chatWithId);
    _referenceServerTimeZone = firebaseDatabase
        .ref()
        .child(ChatConstant.chat)
        .child(ChatConstant.serverTimezone)
        .child(ChatConstant.timestamp);
    /*firebaseAuth().then((value) {
      setFCMToken();
    });*/
    setFCMToken();
    getChatWithFCMToken();
    setChatList();
  }

  setChatList() {
    _refUserToChatWith.onValue.forEach((element) {
      DataSnapshot dataSnapshot = element.snapshot;
      Map? data = dataSnapshot.value as Map<dynamic, dynamic>?;
      List<ModelChatting> chatList = [];
      data?.forEach((key, value) {
        ModelChatting modelChatList = ModelChatting.fromJson(value);
        chatList.add(modelChatList);
      });
      if (chatList.isNotEmpty) {
        chatList.sort((a, b) {
          String aDate =
              getChatDateTime(a.date ?? "", format: "yyyy-MM-dd HH:mm:ss");
          String bDate =
              getChatDateTime(b.date ?? "", format: "yyyy-MM-dd HH:mm:ss");

          return bDate.compareTo(aDate);
        });
      }

      subjectChatList.add(chatList);
    });
  }

  DatabaseReference getChatList() {
    return _refUserToChatWith;
  }

  sendMsg() {
    String msg = msgController.text.trim();
    if (msg.isNotEmpty) {
      msgController.text = "";
      _referenceServerTimeZone.set(ServerValue.timestamp).then((value) {
        _referenceServerTimeZone.once().then((dataSnapshot) {
          String key = "${dataSnapshot.snapshot.value}";
          logd(tag, "myKey $key");
          FocusManager.instance.primaryFocus!.unfocus();
          var map = <String, String>{};
          map[ChatConstant.fbSenderId] = storeId;
          map[ChatConstant.fbMessage] = msg;
          map[ChatConstant.fbSenderName] = storeName;
          map[ChatConstant.fbMessageTime] = getCurrentTimeEnglish();
          _refUserToChatWith.child(key).set(map);
          _refChatWithToUser.child(key).set(map);
          checkAndSetUser(msg);
          callNotificationApi(msg);
        });
      });
    }
  }

  checkAndSetUser(String msg) {
    String key = DateTime.now().toUtc().microsecondsSinceEpoch.toString();
    _referenceUser
        .orderByChild(ChatConstant.userId)
        .equalTo(chatWithId)
        .once()
        .then((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value == null) {
        var map = <String, dynamic>{};
        map[ChatConstant.userId] = chatWithId;
        map[ChatConstant.userName] = chatWithName;
        map[ChatConstant.userProfile] = chatWithImage;
        map[ChatConstant.userServicesName] = chatWithServicesName;
        map[ChatConstant.userDateTime] = getCurrentTimeEnglish();
        map[ChatConstant.userLastMessage] = msg;
        map[ChatConstant.userType] = chatWithUserType;
        if (chatWithId.contains(ChatConstant.adminIdCode)) {
          map[ChatConstant.adminSeen] = false;
        }
        return _referenceUser.child(key).set(map);
      } else {
        Map data = dataSnapshot.value as Map<dynamic, dynamic>;
        var updateMap = <String, dynamic>{};
        updateMap[ChatConstant.userDateTime] = getCurrentTimeEnglish();
        updateMap[ChatConstant.userLastMessage] = msg;
        updateMap[ChatConstant.userType] = chatWithUserType;
        if (chatWithId.contains(ChatConstant.adminIdCode)) {
          updateMap[ChatConstant.adminSeen] = false;
        }
        return _referenceUser
            .orderByChild(ChatConstant.userId)
            .equalTo(chatWithId)
            .ref
            .child(data.keys.elementAt(0))
            .update(updateMap);
      }
    });

    _referenceChatWith
        .orderByChild(ChatConstant.userId)
        .equalTo(storeId)
        .once()
        .then((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value == null) {
        var map = <String, dynamic>{};
        map[ChatConstant.userId] = storeId;
        map[ChatConstant.userName] = storeName;
        map[ChatConstant.userProfile] = prefGetString(prefStoreBanner);
        map[ChatConstant.userServicesName] =
            prefGetString(prefServiceCategoryName);
        map[ChatConstant.userDateTime] = getCurrentTimeEnglish();
        map[ChatConstant.userLastMessage] = msg;
        map[ChatConstant.userType] = chatWithTypeStore;
        if (chatWithId.contains(ChatConstant.adminIdCode)) {
          map[ChatConstant.adminSeen] = false;
        }
        return _referenceChatWith.child(key).set(map);
      } else {
        Map data = dataSnapshot.value as Map<dynamic, dynamic>;
        var updateMap = <String, dynamic>{};
        updateMap[ChatConstant.userDateTime] = getCurrentTimeEnglish();
        updateMap[ChatConstant.userLastMessage] = msg;
        updateMap[ChatConstant.userType] = chatWithTypeStore;
        if (chatWithId.contains(ChatConstant.adminIdCode)) {
          updateMap[ChatConstant.adminSeen] = false;
        }
        return _referenceChatWith
            .orderByChild(ChatConstant.userId)
            .equalTo(storeId)
            .ref
            .child(data.keys.elementAt(0))
            .update(updateMap);
      }
    });
  }

  getChatWithFCMToken() {
    DatabaseReference refUsers = firebaseDatabase
        .ref()
        .child(ChatConstant.chat)
        .child(ChatConstant.fcmToken)
        .child(chatWithId)
        .child(ChatConstant.fcmToken);
    refUsers.once().then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        chatWithFCMToken = dataSnapshot.snapshot.value.toString();
      } else {
        chatWithFCMToken = "";
      }
      return;
    });
  }

  callNotificationApi(String msg) async {
    var mainPushData = <String, dynamic>{};
    var message = <String, dynamic>{};
    var data = <String, dynamic>{};
    data["user_id"] = storeId;
    data["title"] = storeName;
    data["desc"] = msg;
    data["body"] = msg;
    data["sound"] = "default";
    data["user_img"] = prefGetString(prefStoreBanner);
    data["user_service_name"] = "Store";
    data["user_fcm_token"] = prefGetString(prefDeviceToken);
    data["receiver_name"] = storeName;
    data["receiver_id"] = prefGetInt(prefStoreId).toString();
    data["profile_picture"] = prefGetString(prefStoreBanner);
    data["click_action"] = "FLUTTER_NOTIFICATION_CLICK";
    data["user_type"] = chatWithTypeStore.toString();

    message["token"] = chatWithFCMToken;
    message["data"] = data;
    message["notification"] = {
      'title': storeName,
      'body': msg,
    };
    message["android"] = {
      'notification': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      }
    };
    message["apns"] = {
      'payload': {
        'aps': {
          'content-available': 1,
        }
      }
    };

    //Main all push notification data(Which include all things)
    mainPushData["validate_only"] = false;
    mainPushData["message"] = message;

    // String auth2Token = await myFirebaseService?.autoRefreshCredentialsInitialize() ?? "";
    // var response = await ApiFirebaseHelper(auth2Token)
    //     .postFormData("send", body: mainPushData);
    // debugPrint(response.toString());
  }

  @override
  void dispose() {
    msgController.dispose();
    subjectChatList.close();
  }
}
