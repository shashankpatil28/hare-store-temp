// Path: lib/screen/signupScreen/signup_bloc.dart

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:flutter/material.dart'; // Changed from cupertino.dart for BuildContext
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../commonView/validator.dart';
import '../../network/api_response.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../homeScreen/home_screen.dart';
import '../loginScreen/login_dl.dart';
import '../pendingScreen/pending_screen.dart';
import '../verificationScreen/otp_screen.dart';
import 'sign_up_repo.dart';
import 'signup_screen.dart';

class SignUpBloc implements Bloc { // Changed from 'with Bloc'
  String tag = "SignUpBloc>>>";
  BuildContext context;
  final SignUpRepo _repo = SignUpRepo();

  var formKey = GlobalKey<FormState>();
  final submitValid = BehaviorSubject<bool>.seeded(false); // Seed with false
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var rePassController = TextEditingController();
  var mobileController = TextEditingController();
  String? countryCode = defaultCountryCode.dialCode;
  State<SignUpScreen> state;

  SignUpBloc(this.context, this.state);

  // Use specific type for ApiResponse if possible, otherwise dynamic is okay
  var signUpSubject = BehaviorSubject<ApiResponse<dynamic>>();

  final acceptTermsController = BehaviorSubject<bool>.seeded(false); // Seed with false

  // Call this on field changes and checkbox change
  buttonHide() {
    // Use the validation functions directly, check if they return empty string for valid
    String fullNameError = fullNameValidate(fullNameController.text);
    String emailError = emailValidate(emailController.text);
    String passError = passwordValidate(passController.text);
    String rePassError = confirmPasswordValidate(rePassController.text, passController.text);
    String mobileError = mobileNumberValidate(mobileController.text);
    bool termsAccepted = acceptTermsController.valueOrNull ?? false;

    // Button is valid if all errors are empty AND terms are accepted
    bool isValid = fullNameError.isEmpty &&
                   emailError.isEmpty &&
                   passError.isEmpty &&
                   rePassError.isEmpty &&
                   mobileError.isEmpty &&
                   termsAccepted;

    // Update the stream only if the value changes
    if (submitValid.valueOrNull != isValid) {
      submitValid.add(isValid);
    }
  }

  signUp() async {
    // Ensure form is validated before proceeding
    if (!(formKey.currentState?.validate() ?? false) || !(acceptTermsController.valueOrNull ?? false)) {
        if(!(acceptTermsController.valueOrNull ?? false)) {
           openSimpleSnackbar(languages.termAndConditionUse); // Provide specific feedback
        }
      return; // Stop if form is invalid or terms not accepted
    }

    var currencySymbol = prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency);
    var language = prefGetStringWithDefaultValue(prefSelectedLanguageCode, defaultLanguage);

    // Ensure Firebase token is fetched before making API call
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await firebaseAuth(); // Ensure user is authenticated with Firebase
      setFireToken(token ?? "");
    } catch(e) {
       logd(tag, "Error getting FCM token or Firebase Auth: $e");
       openSimpleSnackbar(languages.emptyData); // Inform user
       return; // Stop signup if token fails
    }


    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
       if (signUpSubject.isClosed) return;
      signUpSubject.add(ApiResponse.loading());
      try {
        LoginPojo response = LoginPojo.fromJson(await _repo.signUp(
          email: emailController.text.trim(), // Trim input
          password: passController.text.trim(), // Trim input
          contactNumber: mobileController.text.trim(), // Trim input
          fullName: fullNameController.text.trim(), // Trim input
          gender: 0, // Assuming 0 is default or placeholder for store signup
          selectLanguage: language,
          selectCurrency: currencySymbol,
          selectCountryCode: countryCode,
          // deviceToken is handled by setFireToken internally based on your code
        ));

        if (!state.mounted) return; // Check mounted after await

        var apiMsg = getApiMsg(context, response.message, response.messageCode);

        // Pass false for isLogout
        if (isApiStatus(context, response.status, apiMsg, false)) {
          setDataInPref(response); // Save user data
          signUpSubject.add(ApiResponse.completed(response)); // Pass response data

          // Navigate based on verification and service status
          if (response.storeVerified == 1) {
            // Verified, check service status
             // 0:pending, 1:approved, 2:blocked, 3:rejected, 4:not registered
            switch (response.serviceStatus) {
              case 0: // Pending
              case 4: // Not registered - treat as pending?
                navigateToPending(context);
                break;
              case 1: // Approved
                openScreenWithClearPrevious(context, const HomeScreen());
                break;
              case 2: // Blocked
                navigationPage(context, PendingScreen(data: languages.blockMessage));
                break;
              case 3: // Rejected
                navigationPage(context, PendingScreen(data: languages.rejectMessage));
                break;
              default: // Unknown status
                 navigationPage(context, PendingScreen(data: response.serviceMessage.isNotEmpty ? response.serviceMessage : languages.apiErrorUnexpectedErrorMsg));
            }
          } else {
            // Not verified, go to OTP screen
            navigationPage(context, const OtpScreen());
          }
        } else {
          // isApiStatus might handle navigation/dialogs, just update stream
          signUpSubject.add(ApiResponse.error(apiMsg));
          // Snack bar might be redundant
          // if (response.status != 3) openSimpleSnackbar(apiMsg);
        }
      } catch (e) {
        if (!state.mounted) return;
         String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        signUpSubject.add(ApiResponse.error(errorMessage));
        openSimpleSnackbar(errorMessage);
        logd(tag, "Signup Error: $e");
      }
    } else { // No internet
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
       signUpSubject.add(ApiResponse.error(languages.noInternet)); // Update stream state
    }
  }

  @override
  void dispose() {
    signUpSubject.close();
    acceptTermsController.close();
    submitValid.close();
    fullNameController.dispose();
    emailController.dispose();
    passController.dispose();
    rePassController.dispose();
    mobileController.dispose();
     // No super.dispose needed
  }
}