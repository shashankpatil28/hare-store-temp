// Path: lib/screen/splashScreen/splash_repo.dart

import 'dart:io';

import '../../network/api_base_helper.dart';
import '../../network/endpoints.dart'; // Use the dedicated endpoints file
import '../../network/api_data.dart' show ApiParam; // Import ApiParam explicitly
import '../../utils/common_util.dart';

class SplashRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  checkServiceStatus() async {
    final response = await _apiBaseHelper.post(EndPoint.endPointCheckServiceStatus, body: { // Use named body
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
    });
    return response;
  }

  appVersionCheckApi() async {
    final response = await _apiBaseHelper.post(EndPoint.endPointAppVersionCheck, body: { // Use named body
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramAppType: 1,
      ApiParam.paramLoginDevice: Platform.isAndroid ? loginDeviceFlutterAndroid : loginDeviceFlutterIos,
    });
    return response;
  }
}
