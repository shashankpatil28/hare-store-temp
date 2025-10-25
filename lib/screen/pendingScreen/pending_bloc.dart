// Path: lib/screen/pendingScreen/pending_bloc.dart

import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:flutter/material.dart'; // Changed from cupertino.dart for BuildContext
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../loginScreen/login_repo.dart'; // Assuming this repo is correct
import '../loginScreen/login_screen.dart'; // Import LoginScreen
import 'pending_screen.dart';

class PendingBloc extends Bloc {
  final BuildContext context; // Make context final
  final LoginRepo _repo = LoginRepo(); // Assuming LoginRepo has logout

  final logoutSubject = BehaviorSubject<ApiResponse<dynamic>>(); // Use specific type if possible
  State<PendingScreen> state;

  PendingBloc(this.context, this.state);

  logoutCall() async { // Removed BuildContext context argument, use this.context
    if (!isLoggedIn()) {
      logout(context); // Use the global logout from common_util
      return; // Exit early if already logged out
    }

    if(logoutSubject.isClosed) return; // Check if stream is closed
    logoutSubject.add(ApiResponse.loading());

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      try {
        BaseModel response = BaseModel.fromJson(await _repo.callLogoutApi());

        if(!state.mounted) return; // Check mounted status after await

        var apiMsg = getApiMsg(context, response.message, response.messageCode);
        // Pass false for isLogout as we handle navigation here
        if (isApiStatus(context, response.status, apiMsg, false)) {
          logoutSubject.add(ApiResponse.completed(response)); // Pass response
          logout(context); // Call global logout function which handles prefClear and navigation
        } else {
          // isApiStatus might handle UI for critical errors (like status 3)
          logoutSubject.add(ApiResponse.error(apiMsg)); // Update stream state
          // Snack bar might be redundant if isApiStatus showed a dialog
          // if (response.status != 3) openSimpleSnackbar(apiMsg);
        }
      } catch (e) {
        if(!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logoutSubject.add(ApiResponse.error(errorMessage));
        // Don't pop context here, let the UI handle the error state
        // Navigator.pop(context, false);
        openSimpleSnackbar(errorMessage);
        logd("PendingBloc Logout", "Error: $e");
      }
    } else { // No internet
      if(!state.mounted) return;
      // Don't pop context here
      // Navigator.pop(context, false);
      openSimpleSnackbar(languages.noInternet);
      logoutSubject.add(ApiResponse.error(languages.noInternet)); // Update stream state
    }
  }

  @override
  void dispose() {
    logoutSubject.close();
    // No super.dispose needed
  }
}