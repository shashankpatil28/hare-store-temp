// Path: lib/screen/homeScreen/home_repo.dart

import 'package:package_info_plus/package_info_plus.dart';

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class HomeRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  updateStatus(bool status) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointUpdateCurrentStatus, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramUpdateStatus: status ? 1 : 0,
    });

    return response;
  }

  updateOrderStatus(
      {required int orderId,
      required int updateStatus,
      String? rejectedReason}) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointUpdateOrderStatus, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramOrderId: orderId,
      ApiParam.paramUpdateStatus: updateStatus,
      ApiParam.paramRejectReason: rejectedReason,
    });

    return response;
  }

  getHomeData() async {
    PackageInfo fromPlatform = await PackageInfo.fromPlatform();
    final response = await _apiBaseHelper.post(EndPoint.endPointHome, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramAppVersion: fromPlatform.version,
    });

    return response;
  }

  getProviderStores() async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointGetProviderStores, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
    });

    return response;
  }
}
