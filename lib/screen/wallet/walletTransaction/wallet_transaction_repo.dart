// Path: lib/screen/wallet/walletTransaction/wallet_transaction_repo.dart

import '../../../network/api_base_helper.dart';
import '../../../network/api_data.dart' show ApiParam;
import '../../../network/endpoints.dart';
import '../../../utils/shared_preferences_util.dart';

class WalletTransactionRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getWalletTransactions() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointWalletTransaction,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      },
    );
    return response;
  }
}
