// Path: lib/screen/productsScreen/product_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class ProductRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getProductList({String? search}) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointProductList, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramSearch: search,
    });

    return response;
  }

  updateProduct({required int productId, required int productStatus}) async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointUpdateProductStatus, body: {
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramProductId: productId,
      ApiParam.paramProductStatus: productStatus,
    });

    return response;
  }
}
