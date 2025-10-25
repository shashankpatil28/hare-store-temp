// Path: lib/dialog/editNumberDialog/edit_number_dialog_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus

import '../../commonView/customCountryCodePicker/country_code.dart';
import '../../network/api_response.dart';
import '../../screen/verificationScreen/otp_verify_dl.dart';
import '../../screen/verificationScreen/otp_verify_repo.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';

class EditNumberDialogBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "EditNumberDialogBloc>>>";
  final BehaviorSubject<CountryCode> _countryCodeController = BehaviorSubject<CountryCode>();
  final formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final _subject = BehaviorSubject<ApiResponse<EditNumberPojo>>();
  BuildContext context;
  final OtpVerifyRepo _otpVerifyRepo = OtpVerifyRepo();

  final State state;

  EditNumberDialogBloc(this.context, this.state);

  BehaviorSubject<ApiResponse<EditNumberPojo>> get subject => _subject;

  Stream<CountryCode> get countryValue => _countryCodeController.stream;

  Function(CountryCode) get changeCountry => _countryCodeController.sink.add;

  editNumber() async {
    if (formKey.currentState!.validate()) {
      if ("${prefGetString(prefCountryCode)}${prefGetString(prefContactNumber)}" ==
          "${_countryCodeController.valueOrNull?.dialCode ?? defaultCountryCode.dialCode}${mobileController.text.trim()}") {
        openSimpleSnackbar(languages.sameEditNumberMsg);
      } else {
        editNumberApiCall();
      }
    }
  }

  editNumberApiCall() async {
    FocusManager.instance.primaryFocus!.unfocus();
    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _subject.sink.add(ApiResponse.loading());
      try {
        var response =
            EditNumberPojo.fromJson(await _otpVerifyRepo.callChangeNumberApi(mobileController.text.trim(), _countryCodeController.value.dialCode!));

        String message = response.message ?? "";
        _subject.sink.add(ApiResponse.completed(response));

        if (!state.mounted) return;
        if (isApiStatus(context, response.status!, message, true)) {
          prefSetString(prefCountryCode, response.selectCountryCode!);
          prefSetString(prefContactNumber, response.contactNumber!);
          openSimpleSnackbar(languages.resendOtpSuccessMsg);
          Navigator.pop(context, true);
        } else {
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
    _countryCodeController.close();
    mobileController.dispose();
    _subject.close();
  }
}
