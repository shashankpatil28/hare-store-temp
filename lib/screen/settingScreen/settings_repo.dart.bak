// Path: lib/screen/settingScreen/settings_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/common_util.dart';

class SettingsRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getAndUpdateSettings({
    required double etaDeliveryTime,
    required double serviceRadius,
    required double orderMinAmount,
    required double packagingCharges,
    required int isUpdate,
    required String storeTiming,
  }) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointGetAndUpdateSettings, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramEtaDeliveryTime: etaDeliveryTime,
      ApiParam.paramServiceRadius: serviceRadius,
      ApiParam.paramOrderMinAmount: orderMinAmount,
      ApiParam.paramPackagingCharge: packagingCharges,
      ApiParam.paramStoreTiming: storeTiming,
      ApiParam.paramIsUpdate: isUpdate,
    });

    return response;
  }
}
