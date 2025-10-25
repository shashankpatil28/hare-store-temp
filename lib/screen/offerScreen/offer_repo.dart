// Path: lib/screen/offerScreen/offer_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam separate
import '../../network/endpoints.dart'; // <-- ADD THIS IMPORT
import '../../utils/common_util.dart'; // For shared prefs access

class OfferRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getAndUpdateOffer({
    required double offerMinBillAmount,
    required double offerDiscount,
    required int offerDiscountType,
    required int isUpdate, // API likely expects 0 or 1
  }) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointGetAndUpdateOffer, body: { // Use EndPoint.
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramOfferMinBillAmount: offerMinBillAmount,
      ApiParam.paramOfferDiscount: offerDiscount,
      ApiParam.paramOfferDiscountType: offerDiscountType,
      ApiParam.paramIsUpdate: isUpdate, // Send 0 or 1
    });

    return response; // Return parsed Map<String, dynamic>
  }
}