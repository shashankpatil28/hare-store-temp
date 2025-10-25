// Path: lib/screen/splashScreen/splash_bloc.dart
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../dialog/simple_dialog_box.dart';
import '../../network/api_response.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../homeScreen/home_screen.dart';
import '../loginScreen/login_dl.dart';
import '../pendingScreen/pending_screen.dart';
import '../selectLanguageAndCurrency/language_currency_screen.dart';
import 'splash_dl.dart';
import 'splash_repo.dart';
import 'splash_screen.dart';

class SplashBloc extends Bloc {
  String tag = "SplashBloc>>>";
  final SplashRepo _repo = SplashRepo();
  BuildContext context;

  final checkServiceStatus = BehaviorSubject<ApiResponse>();
  State<SplashScreen> state;

  SplashBloc(this.context, this.state) {
    setToken();
    _loadWidget();
  }

  final _subject = BehaviorSubject<ApiResponse<AppVersionCheckPojo>>();

  BehaviorSubject<ApiResponse<AppVersionCheckPojo>> get subject => _subject;

  _loadWidget() async {
    var connectivityResult = await cp.Connectivity().checkConnectivity();
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      checkAppVersionApi();
    } else {
      if (!state.mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialogBox( // Corrected duplicated line
                title: languages.connection,
                positiveClick: () async {
                  var newConnectivityResult =
                      await cp.Connectivity().checkConnectivity();
                  if (!newConnectivityResult.contains(cp.ConnectivityResult.none)) {
                    Navigator.pop(context);
                    // await initConfig();
                    _loadWidget();
                  }
                },
                descriptions: languages.connectionMsg,
                positiveButton: languages.retry,
              );
          },
          barrierDismissible: false);
    }
  }

  Future<void> setToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    firebaseAuth().then((value) {
      setFireToken(token ?? "");
    });
  }

  checkServiceStatusCall() async {
    if (checkServiceStatus.isClosed) return;
    checkServiceStatus.add(ApiResponse.loading());

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      try {
        LoginPojo response =
            LoginPojo.fromJson(await _repo.checkServiceStatus());
        if (!state.mounted) return;
        var apiMsg = getApiMsg(context, response.message, response.messageCode);
        if (isApiStatus(context, response.status, apiMsg)) {
          setDataInPref(response);
          checkServiceStatus.add(ApiResponse.completed(true));
          if (response.storeVerified == 1) {
            if (response.serviceStatus == 0) {
              navigateToPending(context);
            } else if (response.serviceStatus == 1) {
              openScreenWithClearPrevious(context, const HomeScreen());
            } else if (response.serviceStatus == 2) {
              navigationPage(
                  context, PendingScreen(data: languages.blockMessage));
            } else if (response.serviceStatus == 3) {
              navigationPage(
                  context, PendingScreen(data: languages.rejectMessage));
            } else if (response.serviceStatus == 4) {
              navigateToPending(context);
            } else {
              navigationPage(context, PendingScreen(data: response.message));
            }
          } else {
            openScreenWithReplacePrevious(
                context, const LanguageCurrencyScreen());
          }
        } else {
          checkServiceStatus.add(ApiResponse.error());
          if (response.status != 3) openSimpleSnackbar(apiMsg);
        }
      } catch (e) {
        if (!state.mounted) return;
        checkServiceStatus.add(ApiResponse.error(e.toString()));
        openSimpleSnackbar(e.toString());
        logd(tag, e.toString());
      }
    } else {
      if (!state.mounted) return;
      Future.delayed(const Duration(seconds: 3), () {
        checkServiceStatus.add(ApiResponse.error());
      });
      openSimpleSnackbar(languages.noInternet);
    }
  }

  checkAppVersionApi() async {
    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      subject.add(ApiResponse.loading());
      try {
        AppVersionCheckPojo response =
            AppVersionCheckPojo.fromJson(await _repo.appVersionCheckApi());
        if (!state.mounted) return;

        var apiMsg = getApiMsg(
            context, response.message ?? "", response.messageCode ?? 0);
        if (isApiStatus(context, response.status ?? 0, apiMsg)) {
          subject.add(ApiResponse.completed(response));
          openForceFullyUpdateDialog(
              response.appVersion ?? "0", response.isForcefullyUpdate ?? 0);
        } else {
          subject.add(ApiResponse.error());
        }
      } catch (e) {
        if (!state.mounted) return;
        subject.add(ApiResponse.error(e.toString()));
        openSimpleSnackbar(e.toString());
      }
    } else {
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
    }
  }

  openForceFullyUpdateDialog(String versionName, int forcefullyUpdate) async {
    String currentVersion = "0", packageName = "";
    if (!kIsWeb) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      currentVersion = packageInfo.version;
      packageName = packageInfo.packageName;
    }
    if (currentVersion.compareTo(versionName) == -1 && forcefullyUpdate == 1) {
      if (!state.mounted) return;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialogUtil(
              title: languages.newUpdateAvailable,
              message: languages.newUpdateMsg,
              positiveButtonTxt: languages.update,
              onPositivePress: () {
                String url = "";
                if (Platform.isAndroid) {
                  url =
                      "https://play.google.com/store/apps/details?id=$packageName";
                } else {
                  url = "https://apps.apple.com/app/id$appleId";
                }
                openUrl(url);
              },
              onNegativePress: () {
                Navigator.pop(context, true);
              },
            );
          }).then((value) {
        openForceFullyUpdateDialog(versionName, forcefullyUpdate);
      });
    } else {
      if (prefGetInt(prefStoreId) > 0) {
        checkServiceStatusCall();
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          openScreenWithReplacePrevious(
              context, const LanguageCurrencyScreen());
        });
      }
    }
  }

  @override
  void dispose() {
    checkServiceStatus.close();
    _subject.close();
  }
}
