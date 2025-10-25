// Path: lib/config/chat_constant.dart

import '../network/api_data.dart';
import '../network/endpoints.dart'; // Add this (if not already added)
class ChatConstant {

  //Common
  static const userIdCode = "u_";
  static const providerIdCode = "p_";
  static const adminIdCode = "a_";
  static const fbMessage = "message";
  static const fbSenderId = "sender_id";
  static const fbSenderName = "sender_name";
  static const serverTimezone = "server_timezone";
  static const timestamp = "timestamp";

  //msg table
  static String chat = EndPoint.baseUrl.replaceAll("https://", "").replaceAll("/", "").replaceAll(RegExp(r'\.'), '-');
  static const messages = "messages";
  static const fbMessageTime = "date";
  static const lastMsgOfChatting = "lastMsgOfChatting";

  //user table
  static const users = "users";
  static const fcmToken = "fcm_token";
  static const userId = "receiver_id"; //receiver_id:"p_166"/"s_id"
  static const userName = "receiver_name";
  static const userProfile = "profile_picture";
  static const adminSeen = "admin_seen";
  static const userType = "user_type";
  static const userServicesName = "services"; //services:"Courier Delivery"
  static const userDateTime = "created_at"; //created_at:"2019-06-11 11:09:54"
  static const userLastMessage = "last_message";

  static const newUserFcmToken = "fcm_token";
}