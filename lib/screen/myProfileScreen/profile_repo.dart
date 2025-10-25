// Path: lib/screen/myProfileScreen/profile_repo.dart

import 'package:dio/dio.dart'; // Import for MultipartFile

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam; // Keep ApiParam separate
import '../../network/endpoints.dart'; // <-- ADD THIS IMPORT
import '../../utils/common_util.dart'; // For shared prefs

class ProfileRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  updateProfile({
    required String? selectCountryCode,
    required String contactNumber,
    required int gender,
    required String fullName,
    required String emailAddress,
    MultipartFile? profileImage, // Make MultipartFile nullable
  }) async {
    // Create FormData object
    FormData formData = FormData.fromMap({
      ApiParam.paramStoreId: prefGetInt(prefStoreId),
      ApiParam.paramAccessToken: prefGetString(prefAccessToken),
      ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
      ApiParam.paramSelectCountryCode: selectCountryCode,
      ApiParam.paramContactNumber: contactNumber,
      ApiParam.paramGender: gender,
      ApiParam.paramFullName: fullName,
      ApiParam.paramEmail: emailAddress,
      // Add profile image only if it's not null
      if (profileImage != null) ApiParam.paramProfileImage: profileImage,
    });

    // Use postFormData from ApiBaseHelper
    final response =
        await _apiBaseHelper.postFormData(EndPoint.endPointEditProfile, body: formData);

    return response; // Return parsed Map<String, dynamic>
  }

   deleteAccount() async {
     final response =
         await _apiBaseHelper.post(EndPoint.endPointRemoveAccount, body: {
       ApiParam.paramStoreId: prefGetInt(prefStoreId),
       ApiParam.paramAccessToken: prefGetString(prefAccessToken),
       ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
     });
     return response; // Return parsed Map<String, dynamic>
   }
}