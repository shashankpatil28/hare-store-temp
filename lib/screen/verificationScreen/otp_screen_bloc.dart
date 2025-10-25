// Path: lib/screen/verificationScreen/otp_screen_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../pendingScreen/pending_screen.dart'; // Import PendingScreen
import 'otp_screen.dart';
import 'otp_verify_repo.dart';


class OtpScreenBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "OtpScreenBloc>>>";
  final BehaviorSubject<String> _otpController = BehaviorSubject<String>.seeded(""); // Seed with empty
  final _subjectVerify = BehaviorSubject<ApiResponse<BaseModel>>();
  final _subjectResend = BehaviorSubject<ApiResponse<BaseModel>>();
  // Seed with false, indicating timer not running initially
  final resendOTPStream = BehaviorSubject<bool>.seeded(false);
  BuildContext context;
  final OtpVerifyRepo _otpVerifyRepo = OtpVerifyRepo();
  State<OtpScreen> state;

  OtpScreenBloc(this.context, this.state);

  Stream<String> get otptValue => _otpController.stream;

  // Use .sink.add for adding values
  Function(String) get changeOtp => _otpController.sink.add;

  BehaviorSubject<ApiResponse<BaseModel>> get subjectVerify => _subjectVerify;

  BehaviorSubject<ApiResponse<BaseModel>> get subjectResend => _subjectResend;

  verify() async {
    // Check for null or empty using valueOrNull safely
    final currentOtp = _otpController.valueOrNull ?? "";
    if (currentOtp.isEmpty || currentOtp.length != 4) {
      openSimpleSnackbar(languages.enterCompleteOtp);
      return;
    }

    // Prevent adding events to closed streams
    if (_subjectVerify.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _subjectVerify.sink.add(ApiResponse.loading());
      try {
        var response = BaseModel.fromJson(
            await _otpVerifyRepo.callVerifyOtpApi(currentOtp));

        if (!state.mounted) return; // Check mounted status *after* await

        String message = response.message;
        // Pass false for isLogout as we handle navigation here
        if (isApiStatus(context, response.status, message, false)) {
          _subjectVerify.sink.add(ApiResponse.completed(response));
          await prefSetInt(prefStoreVerified, 1); // Await preference setting
          // Navigate to Pending screen after successful verification
          navigateToPending(context); // Assuming this clears stack
        } else {
           // isApiStatus might have navigated or shown dialog, just update stream
          _subjectVerify.sink.add(ApiResponse.error(message));
          // Snack bar might be redundant if isApiStatus showed a dialog
          // if (response.status != 3) openSimpleSnackbar(message);
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logd(tag, "Verify OTP Error: $e");
        openSimpleSnackbar(errorMessage);
        _subjectVerify.sink.add(ApiResponse.error(errorMessage));
      }
    } else { // No internet
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
       _subjectVerify.sink.add(ApiResponse.error(languages.noInternet)); // Update stream
    }
  }

  resendOtp() async {
     // Prevent adding events to closed streams
    if (_subjectResend.isClosed || resendOTPStream.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _subjectResend.sink.add(ApiResponse.loading());
      try {
        var response =
            BaseModel.fromJson(await _otpVerifyRepo.callResendOtpApi());

        if (!state.mounted) return; // Check mounted status *after* await

        String message = response.message;
        // Pass false for isLogout
        if (isApiStatus(context, response.status, message, false)) {
          _subjectResend.sink.add(ApiResponse.completed(response));
          resendOTPStream.sink.add(true); // Start the timer UI
          openSimpleSnackbar(languages.resendOtpSuccessMsg);
        } else {
           // isApiStatus might handle UI, just update stream
          _subjectResend.sink.add(ApiResponse.error(message));
          // Snack bar might be redundant
          // if (response.status != 3) openSimpleSnackbar(message);
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logd(tag, "Resend OTP Error: $e");
        openSimpleSnackbar(errorMessage);
        _subjectResend.sink.add(ApiResponse.error(errorMessage));
      }
    } else { // No internet
       if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
       _subjectResend.sink.add(ApiResponse.error(languages.noInternet)); // Update stream
    }
  }

  @override
  void dispose() {
    _otpController.close();
    _subjectVerify.close();
    _subjectResend.close();
    resendOTPStream.close();
    // No super.dispose needed
  }
}