// Path: lib/screen/wallet/my_wallet_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class MyWalletRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getWalletBalance() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointGetWalletBalance,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      },
    );
    return response;
  }

  addWalletBalance(double amount, int paymentType) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointAddWalletBalance,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramAmount: amount,
        ApiParam.paramCardId: 0,
        ApiParam.paramPaymentType: paymentType,
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      },
    );
    return response;
  }
}
