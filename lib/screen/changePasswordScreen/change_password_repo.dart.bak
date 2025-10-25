// Path: lib/screen/changePasswordScreen/change_password_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam separate
import '../../network/endpoints.dart'; // <-- ADD THIS IMPORT
import '../../utils/common_util.dart'; // For shared prefs access

class ChangePasswordRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  changePassword(String oldPassword, String newPassword) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointChangePassword, // Use EndPoint.
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        // Ensure API expects these parameter names
        ApiParam.paramOldPassword: oldPassword,
        ApiParam.paramNewPassword: newPassword
      },
    );
    return response; // Return parsed Map<String, dynamic>
  }
}