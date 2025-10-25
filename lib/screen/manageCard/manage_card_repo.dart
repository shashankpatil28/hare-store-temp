// Path: lib/screen/manageCard/manage_card_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam separate
import '../../network/endpoints.dart'; // <-- ADD THIS IMPORT
import '../../utils/common_util.dart'; // For shared prefs

class ManageCardRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getCardList() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointCardList, // Use EndPoint.
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      },
    );
    return response; // Return parsed Map<String, dynamic>
  }

  removeCard(int cardId) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointCardRemove, // Use EndPoint.
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
        ApiParam.paramCardId: cardId, // Ensure API expects this param name
      },
    );
    return response; // Return parsed Map<String, dynamic>
  }
}