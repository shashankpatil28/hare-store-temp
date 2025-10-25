// Path: lib/utils/shared_preferences_util.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/orderDetailScreen/order_detail_dl.dart';
import 'common_util.dart';

class SharedPreferencesUtil {
  static const authentication = "authentication";
  static const fireToken = "fireToken";
  static const isAppOpen = "isAppOpen";
}

const String prefNewRequestPojo = "newRequestPojo";
const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String prefSelectedLanguageName = "SelectedLanguageName";
const String prefAccessToken = "accessToken";
const String prefSelectedCurrency = "SelectedCurrency";
const String prefDeviceToken = "deviceToken";
const String prefStoreId = "storeId";
const String prefStoreVerified = "storeVerified";
const String prefStoreServiceId = "storeServiceId";
const String prefServiceStatus = "serviceStatus";
const String prefStoreBanner = "storeBanner";
const String prefEmail = "email";
const String prefContactNumber = "contactNumber";
const String prefCountryCode = "countryCode";
const String prefStoreCurrentStatus = "storeCurrentStatus";
const String prefServiceCategoryName = "serviceCategoryName";
const String prefStoreName = "storeName";
const String prefFullName = "fullName";
const String prefLoginType = "loginType";
const String prefProfileImage = "profileImage";
const String prefGender = "gender";
const String prefTimeZone = "timeZone";
const String prefDemoDialogOpen = "demoDialogOpen";
const String prefDisclosureDialogOpen = "disclosureDialogOpen";
const String prefIsShownOnBoarding = "isShownOnBoarding";
const String prefIsOpenDialog = "isOpenDialog";
const String prefEstimateTime = "estimatedTime";
const String prefServiceAccountAccessToken = "serviceAccountAccessToken";
const String prefIsOrderEmpty = "isOrderEmpty";

Future<SharedPreferences> reloadSharedPreference() async {
  sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.reload();
  return sharedPrefs;
}

Future<void> prefSetString(String key, String? value) async {
  if (value != null) {
    await sharedPrefs.setString(key, value);
  }
}

String prefGetString(String key) {
  return sharedPrefs.getString(key) ?? "";
}

Future<void> prefSetDouble(String key, double? value) async {
  if (value != null) {
    await sharedPrefs.setDouble(key, value);
  }
}

double prefGetDouble(String key) {
  return sharedPrefs.getDouble(key) ?? 0.0;
}

String prefGetStringWithDefaultValue(String key, String defaultValue) {
  return sharedPrefs.getString(key) ?? defaultValue;
}

int prefGetInt(String key) {
  return sharedPrefs.getInt(key) ?? 0;
}

prefSetInt(String key, int value) async {
  sharedPrefs.setInt(key, value);
}

bool prefGetBool(String key) {
  return sharedPrefs.getBool(key) ?? false;
}

prefSetBool(String key, bool value) async {
  sharedPrefs.setBool(key, value);
}

setPrefNotificationData(NotificationPojo? newRequestPojo, {String? tag}) async {
  debugPrint("$tag set : ${newRequestPojo?.toJsonString()}");
  if (newRequestPojo != null) {
    sharedPrefs.setString(prefNewRequestPojo, newRequestPojo.toJsonString());
  } else {
    sharedPrefs.setString(prefNewRequestPojo, "");
  }
}

NotificationPojo? getPrefNotificationData() {
  var value = sharedPrefs.getString(prefNewRequestPojo);

  if (value == null || value.isEmpty) {
    return null;
  }
  var newRequestPojo = NotificationPojo.fromJson(jsonDecode(value));
  return newRequestPojo;
}

setFireToken(String token) {
  debugPrint("firebase token => $token");
  sharedPrefs.setString(prefDeviceToken, token);
}

String getFireToken() {
  return sharedPrefs.getString(prefDeviceToken) ?? "";
}

prefClear() {
  sharedPrefs.clear();
}

Locale getLocale() {
  String languageCode =
      sharedPrefs.getString(prefSelectedLanguageCode) ?? defaultLanguage;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale(defaultLanguage, '');
}

Future changeLanguage(
    BuildContext context, String selectedLanguageCode, State state) async {
  var locale = await setLocale(selectedLanguageCode);
  if (!state.mounted) return;
  MyApp.setLocale(context, locale);
}

Future<Locale> setLocale(String languageCode) async {
  await sharedPrefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}
