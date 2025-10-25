// Path: lib/screen/ordersHistoryScreen/order_history_repo.dart

import '../../config/constant.dart';
import '../../main.dart';
import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class OrderHistoryRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getOrderHistory({required int page, required int filterType}) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointOrderHistory, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramPerPage: 15,
      ApiParam.paramPage: page,
      ApiParam.paramFilterType: filterType,
      ApiParam.paramTimezone: localTimeZone ?? defaultTimeZone,
    });

    return response;
  }
}
