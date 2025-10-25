// Path: lib/screen/bankDetailScreen/bank_detail_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam import separate
import '../../network/endpoints.dart'; // <-- ADD THIS IMPORT
import '../../utils/common_util.dart'; // For shared prefs access

class BankDetailRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getBankDetailsApi() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointGetBankDetails, // Use EndPoint.
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      },
    );
    return response; // Return parsed Map<String, dynamic>
  }

  updateBankDetailsApi(String accountNumber, String holderName, String bankName,
      String bankLocation, String paymentEmail, String bicSwiftCode) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointUpdateBankDetails, // Use EndPoint.
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
        ApiParam.paramAccountNumber: accountNumber,
        ApiParam.paramHolderName: holderName,
        ApiParam.paramBankName: bankName,
        ApiParam.paramBankLocation: bankLocation,
        ApiParam.paramPaymentEmail: paymentEmail,
        ApiParam.paramBicSwiftCode: bicSwiftCode
      },
    );
    return response; // Return parsed Map<String, dynamic>
  }
}