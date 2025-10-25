// Path: lib/screen/orderDetailScreen/order_details_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/common_util.dart';

class OrderDetailsRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getOrderDetail({required int orderId}) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointOrderDetail, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramOrderId: orderId,
    });

    return response;
  }

  updateOrderStatus(
      {required int orderId,
      required int updateStatus,
      required String rejectedReason}) async {
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
}
