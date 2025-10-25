// Path: lib/dialog/forgotPasswordDialog/forgot_password_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus

import '../../commonView/customCountryCodePicker/country_code.dart';
import '../../network/api_response.dart';
import '../../screen/loginScreen/login_repo.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../changePasswordDialog/change_password_dialog.dart';
import 'forgot_pass_req_pojo.dart';

class ForgotPassBloc implements Bloc { // Changed from 'with Bloc'
  String tag = "ForgotPassBloc>>>";
  final BehaviorSubject<CountryCode> _countryController = BehaviorSubject<CountryCode>();
  final mobileController = TextEditingController();
  final _subject = BehaviorSubject<ApiResponse<ForgotPassReqPojo>>();
  final LoginRepo _loginRepo = LoginRepo();
  BuildContext context;
  final formKey = GlobalKey<FormState>();

  final State state;

  ForgotPassBloc(this.context, this.state);

  BehaviorSubject<ApiResponse<ForgotPassReqPojo>> get subject => _subject;

  Stream<CountryCode> get countryValue => _countryController.stream;

  Function(CountryCode) get changeCountry => _countryController.sink.add;

  forgotPass() async {
    FocusManager.instance.primaryFocus!.unfocus();
    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _subject.sink.add(ApiResponse.loading());
      try {
        var response =
            ForgotPassReqPojo.fromJson(await _loginRepo.forgotPassReqApi(mobileController.text.trim(), _countryController.value.dialCode!));

        String message = response.message ?? "";
        if (!state.mounted) return;
        if (isApiStatus(context, response.status!, message, true)) {
          _subject.sink.add(ApiResponse.completed(response));
          prefSetString(prefCountryCode, _countryController.value.dialCode!);
          // Navigator.pop(context, true);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return ChangePasswordDialog(
                  storeId: response.storeId ?? 0,
                );
              });
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
    _countryController.close();
    mobileController.dispose();
    _subject.close();
  }
}
