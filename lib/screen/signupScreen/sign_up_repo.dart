// Path: lib/screen/signupScreen/sign_up_repo.dart

import 'dart:io';

import '../../config/constant.dart';
import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam import separate
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class SignUpRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  serviceStatusApi() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointCheckServiceStatus,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      },
    );
    return response;
  }

  signUp({
    String? email,
    String? password,
    String? fullName,
    String? contactNumber,
    String? deviceToken,
    int loginDevice = 1,
    int gender = 1,
    String? selectLanguage,
    String? selectCountryCode,
    String? selectCurrency,
  }) async {
    var map = <String, dynamic>{};
    map[ApiParam.paramEmail] = email;
    map[ApiParam.paramPassword] = password;
    map[ApiParam.paramFullName] = fullName;
    map[ApiParam.paramContactNumber] = contactNumber;
    map[ApiParam.paramDeviceToken] = getFireToken();
    map[ApiParam.paramGender] = gender;
    map[ApiParam.paramLoginDevice] = Platform.isAndroid ? loginDeviceFlutterAndroid : loginDeviceFlutterIos;
    map[ApiParam.paramSelectLanguage] = selectLanguage ?? (prefGetString(prefSelectedLanguageCode));
    map[ApiParam.paramSelectCountryCode] = selectCountryCode;
    map[ApiParam.paramSelectCurrency] = selectCurrency ?? (prefGetString(prefSelectedCurrency));

    final response = await _apiBaseHelper.post(EndPoint.endPointRegister, body: map);
    return response;
  }
}
