// Path: lib/screen/loginScreen/login_repo.dart

import 'dart:io';

import '../../config/constant.dart';
import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class LoginRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  login(
      {String? loginType,
      required String email,
      String? password,
      String? name,
      String? loginId,
      String? countryCode}) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointLogin,
      body: {
        ApiParam.paramLoginType: loginType,
        ApiParam.paramDeviceToken: prefGetString(prefDeviceToken),
        ApiParam.paramEmail: email,
        ApiParam.paramPassword: password,
        ApiParam.paramFullName: name,
        ApiParam.paramLoginId: loginId,
        ApiParam.paramLoginDevice: Platform.isAndroid
            ? loginDeviceFlutterAndroid
            : loginDeviceFlutterIos,
        ApiParam.paramSelectLanguage: prefGetStringWithDefaultValue(
            prefSelectedLanguageCode, defaultLanguage),
        ApiParam.paramSelectCountryCode: countryCode,
        ApiParam.paramSelectCurrency:
            prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency)
      },
    );
    return response;
  }

  forgotPassReqApi(String phoneNum, String countryCode) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointForgotPasswordRequest,
      body: {
        ApiParam.paramContactNumber: phoneNum,
        ApiParam.paramSelectCountryCode: countryCode,
        ApiParam.paramSelectLanguage: prefGetStringWithDefaultValue(
            prefSelectedLanguageCode, defaultLanguage),
        ApiParam.paramSelectCurrency:
            prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency)
      },
    );
    return response;
  }

  forgotChangePassApi(int storeId, String otp, String password) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointForgotChangePassword,
      body: {
        ApiParam.paramStoreId: storeId,
        ApiParam.paramOtp: otp,
        ApiParam.paramNewPassword: password,
        ApiParam.paramLoginDevice: Platform.isAndroid
            ? loginDeviceFlutterAndroid
            : loginDeviceFlutterIos,
        ApiParam.paramSelectLanguage: prefGetStringWithDefaultValue(
            prefSelectedLanguageCode, defaultLanguage),
        ApiParam.paramSelectCurrency:
            prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency)
      },
    );
    return response;
  }

  callLogoutApi() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointLogout,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken)
      },
    );
    return response;
  }
}
