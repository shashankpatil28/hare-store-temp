// Path: lib/service/push_notification_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth_io;
import 'package:audioplayers/audioplayers.dart';

import '../screen/liveChatScreen/chating/chatting_screen.dart';
import '../screen/orderDetailScreen/order_detail_screen.dart';
import '../screen/splashScreen/splash_screen.dart';
import '../screen/homeScreen/home_screen.dart';
import '../screen/wallet/walletTransaction/wallet_transaction.dart';
import '../utils/common_util.dart';

class PushNotificationService {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  PushNotificationService() {
    init();
  }

  @pragma('vm:entry-point')
  Future<void> init() async {
    FirebaseMessaging.instance.subscribeToTopic(topicSubScribe);
    // FirebaseMessaging.instance.subscribeToTopic("fcm_test");

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (!kIsWeb) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      await initLocalNotification();
    }
  }

  Future<void> setToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setFireToken(token ?? "");
  }

  setListener() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("getInitialMessage : ${message}");
        // handleNotificationClick(navigatorKey.currentContext!, message.data,
        // isReplace: true);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage : ${message}");
      final player = AudioPlayer();
      print('Notification ringing...');
      await player.play(AssetSource('audio/sring.mp3'));
      if (isLoggedIn()) {
        openScreenWithClearPrevious(
            navigatorKey.currentContext!, const HomeScreen());
      } else {
        openScreenWithClearPrevious(
            navigatorKey.currentContext!, const SplashScreen());
      }
      // showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp : ${message}");
      // handleNotificationClick(navigatorKey.currentContext!, message.data);
    });
  }

  showNotification(RemoteMessage message) async {
    debugPrint(message.data.toString());

    RemoteNotification? notification = message.notification;
    Map<String, dynamic> data = message.data;

    String title = notification?.title ?? "";
    String msg = notification?.body ?? "";

    int orderStatus = 0;
    if (data.containsKey("order_status")) {
      orderStatus = int.parse(message.data["order_status"]);
    }

    // title = data["title"] ?? "";
    // msg = data["message"] ?? "";
    // if (data.containsKey("desc")) {
    //   msg = data["desc"] ?? "";
    // }

    if (!kIsWeb) {
      if (orderStatus == 1) {
        handleNotificationClick(navigatorKey.currentContext!, message.data);
      }

      if (!Platform.isIOS) {
        if (data["order_id"] != null) {
          await flutterLocalNotificationsPlugin.show(
              data.hashCode,
              title,
              msg,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'ic_notification',
                  color: colorPrimary,
                ),
                iOS: const DarwinNotificationDetails(),
              ),
              payload: jsonEncode(data));
        } else if (!isChatOpen) {
          await flutterLocalNotificationsPlugin.show(
              data.hashCode,
              title,
              msg,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'ic_notification',
                  color: colorPrimary,
                ),
                iOS: const DarwinNotificationDetails(),
              ),
              payload: jsonEncode(data));
        }
      }
    }
  }

  Future initLocalNotification() async {
    if (Platform.isIOS) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('ic_notification');
      var initializationSettingsIOS = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      ); // Corrected syntax
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          _selectNotification(details.payload);
        },
      );
    } else {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('ic_notification');
      var initializationSettingsIOS = DarwinInitializationSettings(
      ); // Corrected syntax (removed extra parenthesis)
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          _selectNotification(details.payload);
        },
      );
    }
    _requestPermissions();
  }

  handleNotificationClick(BuildContext context, Map<String, dynamic> message,
      {bool isReplace = false}) {
    debugPrint("objectmessage=====>$message");
    if (isLoggedIn()) {
      Widget screen = const SplashScreen();
      bool isChatScreen = false;
      bool isNotificationScreen = false;
      int notificationType = message.containsKey("notification_type")
          ? int.parse((message["notification_type"] ?? 0).toString())
          : 0;
      if (notificationType == 6) {
        screen = const WalletTransaction();
      } else if (notificationType == 3) {
        // if (notificationState != null && notificationState!.mounted) isNotificationScreen = true;
        // screen = const Notifications();
      } else {
        int orderId = message.containsKey("order_id")
            ? (message["order_id"] is int
                ? message["order_id"]
                : int.parse(message["order_id"]))
            : 0;
        int orderStatus = message.containsKey("order_status")
            ? (message["order_status"] is int
                ? message["order_status"]
                : int.parse(message["order_status"]))
            : 0;
        if (orderId > 0) {
          screen = OrderDetailScreen(
              setAction: true,
              orderId: orderId,
              playRing: true,
              isFromNotification: true);
          if (orderStatus == 1) {
            isReplace = true;
          }
        } else if (message.containsKey("user_id")) {
          // ignore: unnecessary_statements
          var userId = message["user_id"] ?? "";
          var userImg = message["user_img"] ?? "";
          var userServiceName = message["title"] ?? "";
          var serviceName = message["user_service_name"] ?? "";
          var userType = message["user_type"] ?? "-1";

          if (chatState != null && chatState!.mounted) isChatScreen = true;
          screen = ChattingScreen(
            chatWithId: userId.toString(),
            chatWithImage: userImg.toString(),
            chatWithName: userServiceName.toString(),
            chatWithServicesName: serviceName.toString(),
            chatWithUserType: int.parse(userType),
          );
        }
      }
      if (isReplace) {
        openScreenWithClearPrevious(navigatorKey.currentContext!, screen);
      } else if (isChatScreen || isNotificationScreen) {
        openScreenWithReplacePrevious(navigatorKey.currentContext!, screen);
      } else {
        openScreen(navigatorKey.currentContext!, screen);
      }
    } else {
      navigationClearStackOrReplace(context, const SplashScreen(),
          isReplace: true);
    }
  }

  Future _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    handleNotificationClick(
        navigatorKey.currentContext!, jsonDecode(payload ?? ""));
  }

  Future _selectNotification(String? payload) async {
    handleNotificationClick(
        navigatorKey.currentContext!, jsonDecode(payload ?? ""));
  }

  _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final bool isGranted =
          await androidImplementation?.areNotificationsEnabled() ?? false;
      if (!isGranted) {
        final bool? granted =
            await androidImplementation?.requestNotificationsPermission();
        debugPrint("Notification Permission: $granted");
      }
    }
  }

  Future<String> autoRefreshCredentialsInitialize() async {
    auth_io.AccessCredentials? pushAccessTokenCred;
    String prefAccountAccessToken =
        prefGetString(prefServiceAccountAccessToken).trim();
    if (prefAccountAccessToken.isNotEmpty) {
      pushAccessTokenCred = auth_io.AccessCredentials.fromJson(jsonDecode(prefAccountAccessToken));
    }

    if (firebaseProjectId.trim().isEmpty) {
      String source =
          await rootBundle.loadString('assets/json/service_account.json');
      final serviceAccount = jsonDecode(source);
      if (serviceAccount['project_id'] != null) {
        firebaseProjectId = serviceAccount['project_id'];
      }
    }

    if (pushAccessTokenCred != null &&
        !pushAccessTokenCred.accessToken.hasExpired) {
      return pushAccessTokenCred.accessToken.data;
    }

    String source =
        await rootBundle.loadString('assets/json/service_account.json');
    final Map<String, dynamic> serviceAccount = jsonDecode(source);
    var accountCredentials = auth_io.ServiceAccountCredentials.fromJson(serviceAccount);

    // MODIFIED: Added 'auth_io.' prefix
    auth_io.AutoRefreshingAuthClient autoRefreshingAuthClient =
        // MODIFIED: Added 'auth_io.' prefix
        await auth_io.clientViaServiceAccount(
      accountCredentials,
      ['https://www.googleapis.com/auth/firebase.messaging'],
    );

    pushAccessTokenCred = autoRefreshingAuthClient.credentials;

    autoRefreshingAuthClient.credentialUpdates.listen((cred) {
      pushAccessTokenCred = cred;
    });
    prefSetString(
        prefServiceAccountAccessToken, jsonEncode(pushAccessTokenCred));
    return pushAccessTokenCred!.accessToken.data;
  }
}

Future<void> setToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  firebaseAuth().then((value) {
    setFireToken(token ?? "");
  });
}