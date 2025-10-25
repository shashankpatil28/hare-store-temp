// Path: lib/screen/verificationScreen/otp_verify_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class OtpVerifyRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  callVerifyOtpApi(String otp) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointContactVerification,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramOtp: otp,
      },
    );
    return response;
  }

  callResendOtpApi() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointResendOtpContactVerification,
      body: {ApiParam.paramStoreId: prefGetInt(prefStoreId), ApiParam.paramAccessToken: prefGetString(prefAccessToken)},
    );
    return response;
  }

  callChangeNumberApi(String phoneNum, String countryCode) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointChangeContactNumber,
      body: {
        ApiParam.paramUserid: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramContactNumber: phoneNum,
        ApiParam.paramSelectCountryCode: countryCode,
      },
    );
    return response;
  }
}
