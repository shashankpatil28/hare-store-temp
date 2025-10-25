// Path: lib/dialog/changePasswordDialog/change_password_dialog_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus

import '../../network/api_response.dart';
import '../../screen/loginScreen/login_dl.dart';
import '../../screen/loginScreen/login_repo.dart';
import '../../screen/loginScreen/login_screen.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';

class ChangePasswordDialogBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "ChangePasswordDialogBloc>>>";
  final otpController = TextEditingController();
  final passController = TextEditingController();
  final rePassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _subject = BehaviorSubject<ApiResponse<LoginPojo>>();
  BuildContext context;
  final LoginRepo _loginRepo = LoginRepo();

  final State state;

  ChangePasswordDialogBloc(this.context, this.state);

  BehaviorSubject<ApiResponse<LoginPojo>> get subject => _subject;

  submit(int driverId) async {
    FocusManager.instance.primaryFocus!.unfocus(); // Use alias
    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _subject.sink.add(ApiResponse.loading());
      try {
        var response = LoginPojo.fromJson(await _loginRepo.forgotChangePassApi(driverId, otpController.text.trim(), passController.text.trim()));

        String message = response.message;
        if (!state.mounted) return;
        if (isApiStatus(context, response.status, message, true)) {
          _subject.sink.add(ApiResponse.completed(response));
          /*setDataInPref(response);
          openScreenWithClearPrevious(context, HomeScreen());*/
          openSimpleSnackbar(languages.passChangeSuccessMsg);
          openScreenWithReplacePrevious(context, const LoginScreen());
        } else {
          _subject.sink.add(ApiResponse.completed(response));
          if (response.status != 3) openSimpleSnackbar(message);
        }
      } catch (e) {
        logd(tag, e.toString());
        openSimpleSnackbar(e.toString());
        _subject.sink.add(ApiResponse.error(e.toString()));
      }
    } else {
      openSimpleSnackbar(languages.noInternet);
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    passController.dispose();
    rePassController.dispose();
    _subject.close();
  }
}
