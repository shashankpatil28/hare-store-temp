// Path: lib/screen/loginScreen/login_bloc.dart

import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:flutter/material.dart'; // Ensure material.dart is imported for BuildContext

import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../service/push_notification_service.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../homeScreen/home_screen.dart';
import '../pendingScreen/pending_screen.dart';
import '../verificationScreen/otp_screen.dart';
import 'login_dl.dart';
import 'login_repo.dart';
import 'login_screen.dart';
class LoginBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "LoginBloc>>>";
  BuildContext context;
  Validator validator = Validator();
  final LoginRepo _repository = LoginRepo();

  final _contactNumber = TextEditingController();
  var _password = TextEditingController();
  String _countryCode = defaultCountryCode.dialCode ?? "";

  final _loginAuthSubject = BehaviorSubject<ApiResponse>();
  final _forgotPassword = BehaviorSubject<ApiResponse>();
  final _forgotChangePass = BehaviorSubject<ApiResponse>();
  State<LoginScreen> state;
  LoginBloc(this.context, this.state) {
    // setToken();
  }

  get contactNumber => _contactNumber;

  get password => _password;

  final formKey = GlobalKey<FormState>();

  BehaviorSubject<ApiResponse> get loginAuthSubject => _loginAuthSubject;

  BehaviorSubject<ApiResponse> get forgotPassword => _forgotPassword;
  final submitValid = BehaviorSubject<bool>();

  BehaviorSubject<ApiResponse> get forgotChangePass => _forgotChangePass;

  set contactNumber(value) {
    _contactNumber.text = value;
  }

  set countryCode(String value) {
    _countryCode = value;
  }

  set password(value) {
    _password = value;
  }

  loginAuthentication() async {
    _loginAuthSubject.add(ApiResponse.loading());
    var contactNo = _contactNumber.text;
    var password = _password.text;
    var connectivityResult = await cp.Connectivity().checkConnectivity();
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      try {
        LoginPojo response = LoginPojo.fromJson(await _repository.login(
            email: contactNo,
            password: password,
            countryCode: _countryCode,
            loginType: "email"));
        if (!state.mounted) return;
        authResponse(response, _loginAuthSubject);
      } catch (e) {
        if (!state.mounted) return;
        _loginAuthSubject.sink.add(ApiResponse.error(e.toString()));
        openSimpleSnackbar(e.toString());
        logd(tag, e.toString());
      }
    } else {
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
    }
  }

  bool loginValidate() {
    if (_contactNumber.text.isEmpty) {
      openSimpleSnackbar(languages.enterContactNumber);
      return false;
    } else if (_password.text.isEmpty) {
      openSimpleSnackbar(languages.enterPass);
      return false;
    }
    return true;
  }

  authResponse(LoginPojo response, BehaviorSubject<ApiResponse> dynamic) {
    var apiMsg = getApiMsg(context, response.message, response.messageCode);

    if (isApiStatus(context, response.status, apiMsg, false)) {
      dynamic.add(ApiResponse.completed(response));
      setDataInPref(response);
      if (response.storeVerified == 1) {
        // 0 => pending,
        // 1 => approved,
        // 2 => blocked,
        // 3 => rejected,
        // 4 => not service register
        if (response.serviceStatus == 0) {
          navigateToPending(context);
        } else if (response.serviceStatus == 1) {
          openScreenWithClearPrevious(context, const HomeScreen());
        } else if (response.serviceStatus == 2) {
          navigationPage(context, PendingScreen(data: languages.blockMessage));
        } else if (response.serviceStatus == 3) {
          navigationPage(context, PendingScreen(data: languages.rejectMessage));
        } else if (response.serviceStatus == 4) {
          navigateToPending(context);
        } else {
          navigationPage(context, PendingScreen(data: response.message));
        }
      } else {
        navigationPage(context, const OtpScreen());
      }
    } else {
      if (response.status != 3) openSimpleSnackbar(apiMsg);
      dynamic.add(ApiResponse.error());
    }
  }

  @override
  void dispose() {
    submitValid.close();
    _loginAuthSubject.close();
    _forgotPassword.close();
    _forgotChangePass.close();
  }

  buttonHide() {
    // String mobile = mobileNumberValidate(contactNumber.text);
    String mobile = emailValidate(contactNumber.text);
    String pass = /*passwordValidate(password.text)*/ password.text;

    if (pass.isNotEmpty && mobile.isEmpty) {
      submitValid.add(true);
    } else {
      submitValid.add(false);
    }
  }
}
