// Path: lib/screen/walletTransfer/wallet_transfer_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class WalletTransferRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  findUser(String search) async {
    // provider_id => numeric
    // access_token => numeric
    // search  => numeric
    final response = await _apiBaseHelper.post(
      EndPoint.endPointSearchUser,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
        ApiParam.paramSearch: search,
      },
    );
    return response;
  }

  transferWalletBalance(
      double amount, int transferId, int walletProviderType) async {
    // user_id => numeric
    // access_token => numeric
    // amount => numeric
    // transfer_id => numeric
    // wallet_provider_type => 0-user,1-store,2-driver,3-provider:

    final response = await _apiBaseHelper.post(
      EndPoint.endPointWalletTransfer,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
        ApiParam.paramAmount: amount,
        ApiParam.paramTransferId: transferId,
        ApiParam.paramWalletProviderType: walletProviderType,
      },
    );
    return response;
  }
}
