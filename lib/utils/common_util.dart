// Path: lib/utils/common_util.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher_string.dart';

import '../commonView/order_status.dart';
import '../config/chat_constant.dart';
import '../config/colors.dart';
import '../config/constant.dart';
import '../config/dimens.dart';
import '../dialog/simple_dialog_util.dart';
import '../firebase_options.dart';
import '../main.dart';
import '../network/api_data.dart'; // Import ApiParam
import '../network/api_response.dart'; // Import ApiParam
import '../network/base_dl.dart';
import '../network/endpoints.dart';
import '../screen/homeScreen/home_screen.dart';
import '../screen/loginScreen/login_dl.dart';
import '../screen/orderDetailScreen/order_detail_dl.dart';
import '../screen/orderDetailScreen/order_detail_screen.dart';
import '../screen/pendingScreen/pending_screen.dart';
import '../screen/splashScreen/splash_screen.dart';
import '../screen/verificationScreen/otp_screen.dart';
import '../service/push_notification_service.dart';
import 'bloc.dart';
import 'shared_preferences_util.dart';

export '../config/colors.dart';
export '../config/constant.dart';
export '../config/dimens.dart';
export '../dialog/simple_dialog_util.dart';
export '../main.dart';
export 'shared_preferences_util.dart';
// export 'custom_icons.dart';

String tag = "CommonUtil>>>";

Future navigationPage(BuildContext context, Widget widget) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) => widget),
  );
}

Future openScreenWithResult(BuildContext context, Widget screen) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void openScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext context) => screen),
  );
}

void openScreenWithReplacePrevious(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (BuildContext context) => widget),
  );
}

navigationClearStackOrReplace(BuildContext context, Widget widget,
    {bool isReplace = false}) {
  if (!isReplace) {
    navigationPage(context, widget);
  } else {
    openScreenWithClearPrevious(context, widget);
  }
}

setFCMToken() {
  String userId =
      ChatConstant.providerIdCode + prefGetInt(prefStoreId).toString();
  DatabaseReference refFcmToken = FirebaseDatabase.instance
      .ref()
      .child(ChatConstant.chat)
      .child(ChatConstant.fcmToken)
      .child(userId);
  var map = <String, String>{};
  map[ChatConstant.newUserFcmToken] = getFireToken();
  refFcmToken.set(map);
}

Future<void> clearFCMToken() async {
  String userId =
      ChatConstant.providerIdCode + prefGetInt(prefStoreId).toString();
  DatabaseReference refFcmToken = FirebaseDatabase.instance
      .ref()
      .child(ChatConstant.chat)
      .child(ChatConstant.fcmToken)
      .child(userId);
  var map = <String, String>{};
  map[ChatConstant.newUserFcmToken] = "";
  await refFcmToken.set(map);
}

void openScreenWithClearPrevious(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),
      (route) => false);
}

String getTime(String ourDate, {String format = "EEE, MMM d, yyyy"}) {
  bool isUtc =
      (prefGetStringWithDefaultValue(prefTimeZone, "UTC").toUpperCase() ==
          "UTC");
  var parse = DateFormat("yyyy-MM-dd HH:mm:ss").parse(ourDate, isUtc);

  var detroit = isUtc
      ? tz.UTC
      : tz.getLocation(prefGetStringWithDefaultValue(prefTimeZone, "UTC"));
  var now = tz.TZDateTime(detroit, parse.year, parse.month, parse.day,
      parse.hour, parse.minute, parse.second);
  var convertedDate =
      tz.TZDateTime.from(now, tz.getLocation(localTimeZone ?? "UTC"));

  var formatDate =
      DateFormat(format, localeCode.languageCode).format(convertedDate);
  return formatDate;
}

String getDateTimeWithoutTimezone(String ourDate,
    {String returnFormat = "yyyy-MM-dd hh:mm",
    String format = "yyyy-MM-dd hh:mm",
    bool useLocalTime = false}) {
  // logd(tag, ourDate);
  var parse = DateFormat(format).parse(ourDate, false);
  var formatDate =
      DateFormat(returnFormat, useLocalTime ? localeCode.languageCode : "en")
          .format(parse);
  return formatDate;
}

DateTime getDateTimeObjWithoutTimezone(String ourDate,
    {String returnFormat = "yyyy-MM-dd hh:mm",
    String format = "yyyy-MM-dd hh:mm",
    bool useLocalTime = false}) {
  // logd(tag, ourDate);
  var parse = DateFormat(format).parse(ourDate, false);
  // var formatDate = DateFormat(returnFormat, useLocalTime ? localeCode.languageCode : "en").format(parse);
  return parse;
}

compareTimesForSettings(String openTimeStr, String closeTimeStr) {
  DateTime openTime = getDateTimeObjWithoutTimezone(openTimeStr,
      returnFormat: 'HH:mm', format: 'hh:mm a');
  DateTime closeTime = getDateTimeObjWithoutTimezone(closeTimeStr,
      returnFormat: 'HH:mm', format: 'hh:mm a');
  if (openTime.isAtSameMomentAs(closeTime)) {
    return false;
  } else if (openTime.isBefore(closeTime)) {
    return true;
  }
  return false;
}

convertTimeToServerTime(DateTime dateTime) {
  bool isUtc =
      (prefGetStringWithDefaultValue(prefTimeZone, "UTC").toUpperCase() ==
          "UTC");
  final detroitTime = isUtc
      ? dateTime.toUtc()
      : tz.TZDateTime.from(dateTime,
          tz.getLocation(prefGetStringWithDefaultValue(prefTimeZone, "UTC")));
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(detroitTime);
}

String getTimeFormat(String date, {required String format, String? getFormat}) {
  var parse = DateFormat(format).parse(date);
  var formatDate =
      DateFormat(getFormat ?? format, localeCode.languageCode).format(parse);
  return formatDate;
}

getTimeAndDate(String date, {String format = "dd MMM, yyyy"}) {
  try {
    var parse = DateTime.parse(date);
    var formatDate = DateFormat(format, localeCode.languageCode).format(parse);
    return formatDate;
  } catch (e) {
    return date;
  }
}

String getTimeString(TimeOfDay timeOfDay, {String? format}) {
  // --- THIS IS THE FIX ---
  return DateFormat(format ?? 'Hm', localeCode.languageCode)
      .format(DateTime.now());
}

String getCurrentTime() {
  return DateFormat("yyyy-MM-dd HH:mm:ss", localeCode.languageCode)
      .format(DateTime.now());
}

String getCurrentTimeEnglish() {
  return DateFormat("yyyy-MM-dd HH:mm:ss", 'en').format(DateTime.now().toUtc());
}

getChatDateTime(String ourDate, {String format = "yyyy-MM-dd hh:mm"}) {
  var parse = DateFormat("yyyy-MM-dd HH:mm:ss").parse(ourDate, true).toLocal();
  var formatDate = DateFormat(format, localeCode.languageCode).format(parse);
  return formatDate;
}

DateTime getTimeAndDateObj(String ourDate) {
  String serverTimeZone = prefGetStringWithDefaultValue(prefTimeZone, "UTC");
  bool isUtc = (serverTimeZone.toUpperCase() == "UTC");
  var parse = DateFormat("yyyy-MM-dd HH:mm:ss").parse(ourDate, isUtc);

  var detroit = isUtc ? tz.UTC : tz.getLocation(serverTimeZone);
  var now = tz.TZDateTime(detroit, parse.year, parse.month, parse.day,
      parse.hour, parse.minute, parse.second);
  var convertedDate =
      tz.TZDateTime.from(now, tz.getLocation(localTimeZone ?? "UTC"));
  return convertedDate;
}

getValueFromStream(List<BehaviorSubject<String>> listValue) {
  bool isValid = true;
  for (var element in listValue) {
    if (element.valueOrNull == null || (element.valueOrNull ?? "").isEmpty) {
      if (!element.hasError) {
        element.sink.add("");
        if (isValid) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

openSimpleSnackbar(String title) {
  if (rootScaffoldMessengerKey.currentState != null) {
    rootScaffoldMessengerKey.currentState?.clearSnackBars();
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.start,
          style: bodyText(
              fontSize: textSizeRegular,
              fontWeight: FontWeight.normal,
              textColor: colorWhite),
        ),
      ),
    );
  }
}

//PAYMENT TYPE
const paymentTypeCard = 1;
const paymentTypeGoogle = 2;
const paymentTypeVipps = 3;
const paymentTypeKlarna = 4;

getPaymentType(int paymentType) {
  switch (paymentType) {
    case paymentTypeCard:
      return languages.paymentTypeCard;
    case paymentTypeGoogle:
      return languages.paymentTypeGoogle;
    case paymentTypeVipps:
      return languages.paymentTypeVipps;
    case paymentTypeKlarna:
      return languages.paymentTypeKlarna;
    default:
      return languages.paymentTypeCard;
  }
}

getPaymentSettlement(int paymentSettlement) {
  if (paymentSettlement == 1) {
    return languages.settle;
  } else {
    return languages.unSettle;
  }
}

TextStyle bodyText(
    {FontWeight? fontWeight, double? fontSize, Color? textColor}) {
  return commonTextStyle(
      fontWeight: fontWeight, fontSize: fontSize, textColor: textColor);
}

TextStyle headerText(
    {FontWeight? fontWeight, double? fontSize, Color? textColor}) {
  return commonTextStyle(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize ?? textSizeBig,
      textColor: textColor);
}

TextStyle toolbarStyle(
    {FontWeight? fontWeight, double? fontSize, Color? textColor}) {
  return commonTextStyle(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize ?? textSizeLarge,
      textColor: textColor);
}

TextStyle commonTextStyle(
    {FontWeight? fontWeight, double? fontSize, Color? textColor}) {
  return GoogleFonts.nunito(
      textStyle: TextStyle(
        color: textColor ?? colorTextCommon,
        fontSize: deviceAverageSize * (fontSize ?? textSizeRegular),
        decoration: TextDecoration.none,
      ),
      fontWeight: fontWeight ?? FontWeight.normal);
}

bool getTwoDigitRegExp(String value) {
  return RegExp(r'^\d+\.?\d{0,2}$').hasMatch(value);
}

bool emailRegExp(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  return RegExp(pattern).hasMatch(value);
}

bool validatePassword(String value) {
  // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  // RegExp regExp = new RegExp(pattern);
  // return regExp.hasMatch(value);
  return value.length >= 6;
}

bool isNumeric(String string) {
  if (string.isEmpty) return false;
  final numericRegex = RegExp(r'^-?((\d*)|((\d*)\.(\d*)))$');
  return numericRegex.hasMatch(string);
}

double getDoubleFromString(String value) {
  if (value.isEmpty) return 0.0;
  var val = double.parse(value);
  return val;
}

double getDouble(dynamic value) {
  if (value == null) {
    StackTrace.current;
  }
  return value.toDouble();
}

bool isRtl() {
  if (localeCode.languageCode == 'ar' ||
      localeCode.languageCode == 'fa' ||
      localeCode.languageCode == 'he' ||
      localeCode.languageCode == 'ps' ||
      localeCode.languageCode == 'ur') {
    logd(tag, "rtl : true");
    return true;
  }
  logd(tag, "rtl : false");
  return false;
}

bool isApiStatus(BuildContext context, int status, String message,
    [bool isLogout = true]) {
  // 0 => false,
  // 1 => true,
  // 2 => registration pending,
  // 3 => app driver blocked,
  // 4 => app driver access token not match,
  // 5 => app driver not found
  // 6 => app driver service not register,
  // 7 => app driver service rejected,
  // 8 => app driver service pending,

  bool apiStatus = false;

  switch (status) {
    case 0:
      break;
    case 1:
      apiStatus = true;
      break;
    case 2:
      navigationPage(context, const OtpScreen());
      break;
    case 4:
      if (isLogout) logout(context);
      break;
    case 5:
      if (isLogout) logout(context);
      break;
    case 3:
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialogUtil(
              title: message,
              message: "",
              positiveButtonTxt: languages.ok,
              onPositivePress: () {
                logout(context);
              },
            );
          });
      break;
    case 6:
    case 7:
    case 8:
      openScreenWithClearPrevious(
          context,
          PendingScreen(
            data: message,
          ));
      break;
  }

  return apiStatus;
}

setDataInPref(LoginPojo response) {
  prefSetInt(prefStoreId, response.storeId);
  prefSetInt(prefStoreVerified, response.storeVerified);
  prefSetInt(prefServiceStatus, response.serviceStatus);
  prefSetString(prefAccessToken, response.accessToken.toString());
  prefSetString(prefFullName, response.storeProviderName);
  prefSetString(prefEmail, response.email);
  prefSetString(prefLoginType, response.loginType);
  prefSetString(prefProfileImage, response.providerProfileImage);
  prefSetInt(prefGender, response.providerGender);
  prefSetString(prefContactNumber, response.contactNumber);
  prefSetString(prefCountryCode, response.selectCountryCode);
  prefSetString(prefStoreBanner, response.storeBanner);
  prefSetInt(prefStoreCurrentStatus, response.serviceCurrentStatus);
  prefSetInt(prefStoreServiceId, response.storeServiceId);
  prefSetString(prefTimeZone, response.serverTimeZone);
  prefSetString(prefServiceCategoryName, response.serviceCategoryName);
  prefSetString(prefStoreName, response.storeName);
}

navigateToPending(BuildContext context) {
  Widget widget = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: languages.servicePendingMessage,
        style: bodyText(fontWeight: FontWeight.w600),
        children: <TextSpan>[
          TextSpan(
              text: "${EndPoint.baseUrl}${EndPoint.endPointStoreLogin}",
              style: bodyText(
                textColor: colorPrimary,
                fontWeight: FontWeight.w600,
              ).copyWith(
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrlString(
                      "${EndPoint.baseUrl}${EndPoint.endPointStoreLogin}",
                      mode: LaunchMode.externalApplication);
                })
        ]),
  );
  openScreenWithClearPrevious(
      context,
      PendingScreen(
        widget: widget,
      ));
}

Widget checkOrderStatus(
  int status, {
  bool? isRight,
  EdgeInsetsDirectional? padding,
}) {
  // 1 => request pending,
  // 2 => approved by store,
  // 3 => rejected,
  // 4 => cancelled,
  // 5 => processing,
  // 6 => approved-by-driver,
  // 7 => arrived-driver,
  // 8 => ongoing,
  // 9 => completed,
  // 10 => failed

  switch (status) {
    case 1:
      // new
      return pendingStatus(languages.newOrderDetail,
          isRight: isRight, padding: padding);
    case 2:
      return orderStatusView(languages.accepted,
          color: colorYellow, isRight: isRight, padding: padding);
    //ACCEPTED;
    case 3:
      return cancelStatus(languages.rejected,
          isRight: isRight, padding: padding);
    //REJECTED;
    case 4:
      return cancelStatus(languages.cancelled,
          isRight: isRight, padding: padding);
    //CANCELLED;
    case 5:
    case 6:
    case 7:
      return orderStatusView(languages.processingOrder,
          color: colorYellow, isRight: isRight, padding: padding);
    //PROCESSING;

    case 8:
      return orderStatusView(languages.dispatchOrder,
          color: colorYellow, isRight: isRight, padding: padding);
    //DISPATCHED;
    case 9:
      return completeStatus(languages.completed,
          isRight: isRight, padding: padding);
    //COMPLETE;
  }
  return pendingStatus(languages.newOrder, isRight: isRight, padding: padding);
}

dynamic getApiMsg(
  BuildContext context,
  String defaultMessage,
  int messageCode,
) {
  return defaultMessage;
  // if (messageCode == 9) {
  //   return defaultMessage ?? "";
  // }
  //
  // var msgKey = "api_msg_$messageCode";
  // if (languages.apiCode.containsKey(msgKey)) {
  //   return languages.apiCode[msgKey];
  // } else {
  //   return defaultMessage ?? "";
  // }
  // throw ArgumentError('propery not found');
}

String getAmountWithCurrency(dynamic amount) {
  String selectedCurrency = prefGetString(prefSelectedCurrency);
  if (selectedCurrency.isEmpty) {
    selectedCurrency = defaultCurrency;
  }
  return "$selectedCurrency ${amount.toStringAsFixed(2)}";
}

double getDoubleFromDynamic(dynamic value) {
  return double.parse(value.toString());
}

isLoggedIn() {
  if (prefGetInt(prefStoreId) == 0) {
    return false;
  }
  return true;
}

appVersionName({Color? textColor}) {
  if (!kIsWeb) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        return Text(
          (snapshot.data != null && snapshot.data?.version != null)
              ? "V${snapshot.data?.version}"
              : "",
          textAlign: TextAlign.center,
          maxLines: 1,
          style: bodyText(
              textColor: textColor ?? colorWhite,
              fontSize: textSizeSmall,
              fontWeight: FontWeight.w600),
        );
      },
    );
  } else {
    return Container();
  }
}

logout(BuildContext context) {
  clearFCMToken();
  prefClear();
  openScreenWithClearPrevious(context, const SplashScreen());
}

BoxDecoration getStatusBorder(Color color, {bool? isLeft}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadiusDirectional.only(
        topStart: (isLeft ?? false) ? topLeftRadiusStatus : zeroRadius,
        bottomStart: (isLeft ?? false) ? bottomLeftRadiusStatus : zeroRadius,
        topEnd: (isLeft ?? true) ? zeroRadius : topRightRadiusStatus,
        bottomEnd: (isLeft ?? true) ? zeroRadius : bottomRightRadiusStatus),
  );
}

authResponse(BuildContext context, LoginPojo response,
    BehaviorSubject<ApiResponse<LoginPojo>> dynamic) {
  var apiMsg = getApiMsg(context, response.message, response.messageCode);
  logd(tag, "authResponse $apiMsg");
  if (isApiStatus(context, response.status, apiMsg, false)) {
    dynamic.add(ApiResponse.completed(response));
    setDataInPref(response);
    if (response.storeVerified == 1) {
      if (response.serviceStatus == 1) {
        openScreenWithClearPrevious(context, const HomeScreen());
      } else if (response.serviceStatus == 4) {
        navigateToPending(context);
      } else {
        navigationPage(context, PendingScreen(data: response.serviceMessage));
      }
    } else {
      navigationPage(context, const OtpScreen());
    }
  } else {
    dynamic.add(ApiResponse.error(apiMsg));
    if (response.status != 3) openSimpleSnackbar(apiMsg);
  }
}

isBackgroundNotification() async {
  NotificationPojo? newRequestPojo = getPrefNotificationData();
  if (newRequestPojo != null) {
    openScreenWithClearPrevious(
        navigatorKey.currentContext!,
        OrderDetailScreen(
          orderId: /*int.parse(newRequestPojo.orderId)*/ newRequestPojo.orderId,
          playRing: true,
          setAction: true,
          isFromNotification: true,
        ));
  }
  setPrefNotificationData(null);
}

Future<void> openUrl(String url,
    {LaunchMode launchMode = LaunchMode.externalApplication}) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: launchMode);
  } else {
    logd(tag, "Error");
  }
}

setChangedLanguage(BuildContext context, String languageCode, State state,
    {Function()? nextAction}) {
  changeLanguage(context, languageCode, state).then((value) {
    localeCode = getLocale();
    AppLocalizations.delegate.load(localeCode).then((value) {
      languages = value;
      if (nextAction != null) nextAction();
    });
  });
}

getGenderInEnum(int gender) {
  switch (gender) {
    case genderTypeMale:
      return GenderEnum.male;
    case genderTypeFemale:
      return GenderEnum.female;
    default:
      return GenderEnum.other;
  }
}

getGenderInInt(GenderEnum genderEnum) {
  if (genderEnum == GenderEnum.male) {
    return genderTypeMale;
  } else if (genderEnum == GenderEnum.female) {
    return genderTypeFemale;
  } else {
    return genderTypeOther;
  }
}

Future<void> firebaseAuth() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String email = (prefGetString(prefEmail)).trim().isNotEmpty
      ? (prefGetString(prefEmail))
      : "dummy@gmail.com";
  if (currentUser == null) {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(password: "123456", email: "d_$email");
      final User? user = result.user;
      if (user == null) {
        await firebaseAuthWithEmail(email);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logd(tag, 'No user found for that email.');
        await firebaseAuthWithEmail(email);
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        logd(tag, 'No user found for that email.');
        await firebaseAuthWithEmail(email);
      } else if (e.code == 'wrong-password') {
        logd(tag, 'Wrong password provided for that user.');
      }
    } catch (e) {
      logd(tag, e.toString());
    }
  }
}

Future<void> firebaseAuthWithEmail(String email) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          password: "123456", email: "d_$email");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logd(tag, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logd(tag, 'The account already exists for that email.');
        await firebaseAuth();
      }
    } catch (e) {
      logd(tag, e.toString());
    }
  }
}

logd(String tag, String message) {
  debugPrint("$tag $message");
}

setKeyValuePair(List<KeyValueModel> keyValuesList, bool setDivider,
    bool setBold, bool setValueWithCurrency, String key, String value) {
  if (setValueWithCurrency) {
    if (value.isNotEmpty && double.parse(value) > 0) {
      keyValuesList.add(KeyValueModel(
        key,
        getAmountWithCurrency(double.parse(value)),
        setDivider: setDivider,
        setBold: setBold,
      ));
    }
  } else {
    keyValuesList.add(
        KeyValueModel(key, value, setDivider: setDivider, setBold: setBold));
  }
}

// initConfig() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   myFirebaseService = PushNotificationService();
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       badge: true, alert: true, sound: true);
//   myFirebaseService?.setToken();
//   myFirebaseService?.setListener();
//   return true;
// }

String getChatWithDefaultProfile(int userType) {
  switch (userType) {
    case chatWithTypeStore:
      return "assets/images/avatar_store.png";
    case chatWithTypeDriver:
      return "assets/images/avatar_driver.png";
    case chatWithTypeUser:
      return "assets/images/avatar_user.png";
    default:
      return "assets/images/avatar_admin.png";
  }
}

String getChatWithService(int userType) {
  switch (userType) {
    case chatWithTypeDriver:
      return languages.driver;
    case chatWithTypeUser:
      return languages.customer;
    default:
      return "";
  }
}