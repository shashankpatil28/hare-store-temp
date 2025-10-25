// Path: lib/screen/supportScreen/support_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/shared_preferences_util.dart';

class SupportRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getSupportPages() async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointSupportPages,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      },
    );
    return response;
  }
}
