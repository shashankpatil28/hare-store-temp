// Path: lib/screen/addCard/add_card_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam import separate
import '../../network/endpoints.dart'; // <-- ADD THIS IMPORT
import '../../utils/shared_preferences_util.dart'; // Ensure common_util/shared_prefs is imported

class AddCardRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  addCard(String holderName, String cardNumber, String month, String year,
      String cvv) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointAddCard, // Use EndPoint.
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
        ApiParam.paramHolderName: holderName,
        ApiParam.paramCardNumber: cardNumber, // Send cleaned number
        ApiParam.paramMonth: month,
        ApiParam.paramYear: year, // Ensure API expects 2 or 4 digits
        ApiParam.paramCvv: cvv
      },
    );
    return response; // Return the parsed response (Map<String, dynamic>)
  }
}