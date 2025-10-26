// Path: lib/screen/myProfileScreen/my_profile_bloc.dart

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:dio/dio.dart'; // Import Dio for MultipartFile
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../commonView/validator.dart';
import '../../config/chat_constant.dart'; // For chat constants
import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../network/app_exceptions.dart'; // <-- ADD THIS IMPORT
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../../dialog/simple_dialog_util.dart'; // Import for dialog
import 'my_profile_dl.dart';
import 'my_profile_screen.dart';
import 'profile_repo.dart';

class MyProfileBloc implements Bloc {
  String tag = "MyProfileBloc>>>";
  BuildContext context;
  final ProfileRepo _repo = ProfileRepo();

  final _contactNumber = TextEditingController();
  final _email = TextEditingController();
  final _fullName = TextEditingController();

  final _profileFile = BehaviorSubject<File?>(); // Allow null for no file selected
  final profileImageStored = BehaviorSubject<String>.seeded(""); // Seed with empty
  final _genderEnum = BehaviorSubject<GenderEnum>();
  final deleteAccountSubject = BehaviorSubject<ApiResponse<BaseModel>>();

  final _updateEnable = BehaviorSubject<bool>.seeded(false);
  final _updateProfile = BehaviorSubject<ApiResponse<bool>>();
  // Ensure userId format matches where it's used (e.g., ChatConstant.providerIdCode)
  late String userId; // = ChatConstant.providerIdCode + prefGetInt(prefStoreId).toString(); // Initialize in constructor
  late DatabaseReference _referenceUser;

  var countryCode = defaultCountryCode.dialCode; // Use default initially
  State<MyProfileScreen> state;

  MyProfileBloc(this.context, this.state) {
    // Initialize user ID after ensuring prefs are available
    userId = ChatConstant.providerIdCode + prefGetInt(prefStoreId).toString();
    // Reference specific user node using the correct ID format
    _referenceUser = FirebaseDatabase.instance.ref()
                                      .child(ChatConstant.chat)
                                      .child(ChatConstant.users)
                                      .child(userId); // Reference the specific user node directly
    setProfileData();
  }

  setProfileData() {
    _contactNumber.text = prefGetString(prefContactNumber);
    _email.text = prefGetString(prefEmail);
    _fullName.text = prefGetString(prefFullName);
    countryCode = prefGetStringWithDefaultValue(prefCountryCode, defaultCountryCode.dialCode!);
    changeGenderEnum(getGenderInEnum(prefGetInt(prefGender)));
    profileImageStored.add(prefGetString(prefProfileImage));
    // Reset file stream
    if(!_profileFile.isClosed) _profileFile.add(null);
    buttonHide(); // Calculate initial button state
    // Update Firebase user data (simplified)
    updateFirebaseUser();
  }

  // Update Firebase Realtime DB entry for this user
  updateFirebaseUser() async {
     // Use the direct reference _referenceUser initialized in constructor
     if (_referenceUser.key == null) {
        logd(tag, "Firebase user reference key is null, cannot update.");
        return;
     }
      var updateMap = <String, dynamic>{
          // Ensure these constants match your DB structure
          ChatConstant.userId : userId, // Ensure ID is present if creating
          ChatConstant.userName: prefGetString(prefFullName),
          ChatConstant.userProfile: prefGetString(prefProfileImage),
          ChatConstant.userType: chatWithTypeStore, // Assuming this is for store owner
          // Add other relevant fields like FcmToken if needed
          ChatConstant.fcmToken: getFireToken(),
          ChatConstant.userDateTime: DateTime.now().toIso8101String(), // Optional: timestamp
      };
      try {
          // Use set() to create or overwrite the user node with the correct ID
          await _referenceUser.set(updateMap);
          logd(tag, "Firebase user data updated/set successfully for $userId");
      } catch (e) {
          logd(tag, "Error updating Firebase user data for $userId: $e");
      }
  }


  // --- Getters for Controllers ---
  TextEditingController get contactNumberController => _contactNumber;
  TextEditingController get emailController => _email;
  TextEditingController get fullNameController => _fullName;

  // --- Streams ---
  Stream<File?> get profileFileStream => _profileFile.stream;
  Stream<GenderEnum> get genderEnumStream => _genderEnum.stream;
  Stream<ApiResponse<bool>> get updateProfileStream => _updateProfile.stream;
  Stream<bool> get updateEnableStream => _updateEnable.stream;

  // --- Sinks ---
  Function(File?) get changeProfileFile => _profileFile.sink.add;
  Function(GenderEnum) get changeGenderEnum => _genderEnum.sink.add;
  // Function(bool) get changeUpdateEnable => _updateEnable.sink.add; // Handled by buttonHide


  updateProfileCall() async {
    // MODIFIED: Removed form validation. The screen handles validation before calling this.
    FocusManager.instance.primaryFocus?.unfocus();

    if (_updateProfile.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _updateProfile.add(ApiResponse.loading());
      try {
        MultipartFile? multipartFile;
        final currentFile = _profileFile.valueOrNull; // Get current file from stream
        if (currentFile != null && await currentFile.exists()) {
           // Use try-catch for file operations
          try {
             multipartFile = await MultipartFile.fromFile(currentFile.path, filename: currentFile.path.split('/').last);
          } catch (e) {
             logd(tag, "Error creating MultipartFile: $e");
             // Decide how to handle file error: proceed without image or show error?
             // For now, proceed without image if file error occurs
          }
        }

        ProfileResponse response = ProfileResponse.fromJson(
          await _repo.updateProfile(
            selectCountryCode: countryCode, // Use the stored country code
            contactNumber: _contactNumber.text.trim(),
            gender: getGenderInInt(_genderEnum.valueOrNull ?? GenderEnum.other), // Handle potential null
            fullName: _fullName.text.trim(),
            emailAddress: _email.text.trim(),
            profileImage: multipartFile, // Pass MultipartFile or null
          ),
        );

        if (!state.mounted) return; // Check mounted after await

        var apiMsg = getApiMsg(context, response.message, response.messageCode);

        // Pass false for isLogout
        if (isApiStatus(context, response.status, apiMsg, false)) {
          updateProfileData(response); // Update prefs and controllers
          updateFirebaseUser(); // Update Firebase DB
          _updateProfile.add(ApiResponse.completed(true)); // Signal success
          openSimpleSnackbar(languages.myProfileUpdated);
          // Reset file stream after successful upload?
           if(!_profileFile.isClosed) _profileFile.add(null);
           buttonHide(); // Recalculate button state
        } else {
           // API status indicates an issue
          _updateProfile.add(ApiResponse.completed(false)); // Signal failure
           if (response.status != 3) openSimpleSnackbar(apiMsg); // Show error if not handled
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        _updateProfile.sink.add(ApiResponse.error(errorMessage)); // Signal error
        openSimpleSnackbar(errorMessage);
        logd(tag, "Update Profile Error: $e");
      }
    } else { // No internet
      if (!state.mounted) return;
      _updateProfile.sink.add(ApiResponse.error(languages.noInternet)); // Signal error
      openSimpleSnackbar(languages.noInternet);
    }
  }

  // Updates local prefs and controllers after successful API call
  updateProfileData(ProfileResponse response) {
    String providerName = response.storeProviderName;
    String providerProfileImage = response.providerProfileImage;
    int providerGender = response.providerGender;
    String email = response.email;
    String contactNumber = response.contactNumber;
    String selectCountryCode = response.selectCountryCode;

    // Await preference setting
    Future.wait([
      prefSetString(prefFullName, providerName),
      prefSetString(prefProfileImage, providerProfileImage),
      prefSetString(prefEmail, email),
      prefSetString(prefContactNumber, contactNumber),
      prefSetString(prefCountryCode, selectCountryCode),
      prefSetInt(prefGender, providerGender)
    ]).then((_) {
        // Update controllers and streams after prefs are saved
        _contactNumber.text = contactNumber;
        _email.text = email;
        _fullName.text = providerName;
        countryCode = selectCountryCode;
        if(!_genderEnum.isClosed) changeGenderEnum(getGenderInEnum(providerGender));
        if(!profileImageStored.isClosed) profileImageStored.add(providerProfileImage);
    });
  }

  deleteAccountApiCall() async {
    if (deleteAccountSubject.isClosed) return;
    deleteAccountSubject.add(ApiResponse.loading());

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      try {
        BaseModel response = BaseModel.fromJson(await _repo.deleteAccount());

        if (!state.mounted) return; // Check mounted after await

        var apiMsg = getApiMsg(context, response.message, response.messageCode);
        // Pass false for isLogout, handle navigation here
        if (isApiStatus(context, response.status, apiMsg, false)) {
          deleteAccountSubject.add(ApiResponse.completed(response));
          logout(context); // Call global logout which clears prefs and navigates
        } else {
           // API status indicates issue
          deleteAccountSubject.add(ApiResponse.error(apiMsg));
          if (response.status != 3) openSimpleSnackbar(apiMsg); // Show error if not handled
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        deleteAccountSubject.add(ApiResponse.error(errorMessage));
        openSimpleSnackbar(errorMessage);
        logd(tag, "Delete Account Error: $e");
      }
    } else { // No internet
      if (!state.mounted) return;
      deleteAccountSubject.add(ApiResponse.error(languages.noInternet));
      openSimpleSnackbar(languages.noInternet);
    }
  }

  openDeleteAccountDialog() {
    showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing easily
        builder: (BuildContext dialogContext) { // Use different context name
          return SimpleDialogUtil(
            title: languages.accountDelete,
            message: languages.accountDeleteMsg,
            positiveButtonTxt: languages.delete,
            negativeButtonTxt: languages.cancel,
            onPositivePress: () {
              Navigator.pop(dialogContext); // Close dialog first
              deleteAccountApiCall(); // Then call API
            },
            onNegativePress: () {
              Navigator.pop(dialogContext); // Just close dialog
            },
          );
        });
  }

  // Call this when any field or file changes
  buttonHide() {
    // Check validation errors
    String fullNameError = fullNameValidate(_fullName.text);
    String emailError = emailValidate(_email.text);
    String mobileError = mobileNumberValidate(_contactNumber.text);

    // Check if data has actually changed from prefs or if a new file is selected
    bool nameChanged = _fullName.text != prefGetString(prefFullName);
    bool emailChanged = _email.text != prefGetString(prefEmail);
    bool contactChanged = _contactNumber.text != prefGetString(prefContactNumber);
    // Assuming countryCode is updated via CustomCountryCodePicker's onChanged
    bool countryChanged = countryCode != prefGetString(prefCountryCode);
    bool genderChanged = (_genderEnum.valueOrNull != null) && (getGenderInInt(_genderEnum.value) != prefGetInt(prefGender));
    bool fileSelected = _profileFile.valueOrNull != null;

    bool dataIsValid = fullNameError.isEmpty && emailError.isEmpty && mobileError.isEmpty;
    bool dataHasChanged = nameChanged || emailChanged || contactChanged || countryChanged || genderChanged || fileSelected;

    bool shouldEnable = dataIsValid && dataHasChanged;

    // Update stream only if value changes
    if (!_updateEnable.isClosed && _updateEnable.valueOrNull != shouldEnable) {
      _updateEnable.add(shouldEnable);
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _contactNumber.dispose();
    _email.dispose();
    _fullName.dispose();
    // Close streams
    _profileFile.close();
    _updateProfile.close();
    _genderEnum.close();
    deleteAccountSubject.close();
    profileImageStored.close();
    _updateEnable.close();
     // No super.dispose needed
  }
}