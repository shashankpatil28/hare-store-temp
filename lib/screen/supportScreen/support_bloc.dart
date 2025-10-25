// Path: lib/screen/supportScreen/support_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import 'support_dl.dart';
import 'support_repo.dart';
import 'support_screen.dart';

class SupportBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "SupportBloc>>>";
  final SupportRepo _repo = SupportRepo();
  // Use BehaviorSubject for initial value/loading state
  final _getSupportPagesSubject = BehaviorSubject<ApiResponse<List<Pages>>>();

  BuildContext context;
  State<SupportScreen> state;

  SupportBloc(this.context, this.state) {
    getSupportPages(); // Fetch data when bloc is initialized
  }

  // Expose the stream for the UI to listen to
  Stream<ApiResponse<List<Pages>>> get getSupportPagesStream => _getSupportPagesSubject.stream;

  getSupportPages() async {
    // Check if the stream is closed before adding events
    if (_getSupportPagesSubject.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _getSupportPagesSubject.add(ApiResponse.loading());
      try {
        SupportModel response = SupportModel.fromJson(await _repo.getSupportPages());

        if (!state.mounted) return; // Check if the widget is still mounted after async call

        var apiMsg = getApiMsg(context, response.message ?? languages.apiErrorUnexpectedErrorMsg, response.messageCode ?? 0);

        // Pass false for isLogout since we handle UI updates here
        if (isApiStatus(context, response.status ?? 0, apiMsg, false)) {
          List<Pages> pageList = response.pages ?? []; // Use empty list if null

          if (pageList.isNotEmpty) {
             _getSupportPagesSubject.add(ApiResponse.completed(pageList));
          } else {
             _getSupportPagesSubject.add(ApiResponse.error(languages.emptyData)); // Specific message for no data
          }
        } else {
           // isApiStatus might handle navigation/dialogs for critical errors
          // For non-critical errors, just update the stream with the error message
          _getSupportPagesSubject.add(ApiResponse.error(apiMsg));
          // openSimpleSnackbar might be redundant if isApiStatus showed a dialog
          // if (response.status != 3) openSimpleSnackbar(apiMsg);
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        _getSupportPagesSubject.add(ApiResponse.error(errorMessage));
        logd(tag, "Error fetching support pages: $e");
        openSimpleSnackbar(errorMessage); // Show error to user
      }
    } else { // No internet connection
      if (!state.mounted) return;
      _getSupportPagesSubject.add(ApiResponse.error(languages.noInternet));
      openSimpleSnackbar(languages.noInternet);
    }
  }

  @override
  void dispose() {
    _getSupportPagesSubject.close(); // Close the stream controller
     // No super.dispose() needed
  }
}