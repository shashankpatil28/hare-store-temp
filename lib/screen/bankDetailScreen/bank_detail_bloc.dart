// Path: lib/screen/bankDetailScreen/bank_detail_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../network/app_exceptions.dart'; // <-- ADD THIS IMPORT
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import 'bank_detail_dl.dart';
import 'bank_detail_repo.dart';
import 'bank_detail_screen.dart';

class BankDetailBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "BankDetailBloc>>>";
  TextEditingController accountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController bankLocation = TextEditingController();
  TextEditingController paymentEmail = TextEditingController();
  TextEditingController swiftCode = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Use BehaviorSubject for initial/loading state
  final _subject = BehaviorSubject<ApiResponse<BankDetailPojo>>();
  final _updateSubject = BehaviorSubject<ApiResponse<BaseModel>>();
  BuildContext context;
  final BankDetailRepo _bankDetailRepo = BankDetailRepo();
  State<BankDetailScreen> state;

  BankDetailBloc(this.context, this.state) {
    callGetBankDetailsApi(); // Fetch initial details
  }

  // Expose streams for UI
  Stream<ApiResponse<BankDetailPojo>> get bankDetailStream => _subject.stream;
  Stream<ApiResponse<BaseModel>> get updateStream => _updateSubject.stream;

  callGetBankDetailsApi() async {
     if (_subject.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _subject.sink.add(ApiResponse.loading());
      try {
        var response = BankDetailPojo.fromJson(await _bankDetailRepo.getBankDetailsApi());

        if (!state.mounted) return; // Check mounted after await

        String message = response.message ?? languages.apiErrorUnexpectedErrorMsg;
        // Pass false for isLogout
        if (isApiStatus(context, response.status ?? 0, message, false)) {
          _subject.sink.add(ApiResponse.completed(response));
          setData(response); // Update text controllers
        } else {
          // isApiStatus might handle UI, update stream state
          _subject.sink.add(ApiResponse.error(message));
          // if (response.status != 3) openSimpleSnackbar(message); // Might be redundant
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logd(tag, "Get Bank Details Error: $e");
        _subject.sink.add(ApiResponse.error(errorMessage));
         openSimpleSnackbar(errorMessage); // Show error
      }
    } else { // No internet
      if (!state.mounted) return;
      _subject.sink.add(ApiResponse.error(languages.noInternet));
      openSimpleSnackbar(languages.noInternet);
    }
  }

  void setData(BankDetailPojo response) {
    accountNumber.text = response.accountNumber ?? "";
    accountHolderName.text = response.holderName ?? "";
    bankName.text = response.bankName ?? "";
    bankLocation.text = response.bankLocation ?? "";
    paymentEmail.text = response.paymentEmail ?? "";
    swiftCode.text = response.bicSwiftCode ?? "";
  }

  callUpdateBankDetailApi() async {
    // Validate form first
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

     if (_updateSubject.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _updateSubject.sink.add(ApiResponse.loading());
      try {
        var response = BaseModel.fromJson(await _bankDetailRepo.updateBankDetailsApi(
            accountNumber.text.trim(),
            accountHolderName.text.trim(),
            bankName.text.trim(),
            bankLocation.text.trim(),
            paymentEmail.text.trim(),
            swiftCode.text.trim()));

        if (!state.mounted) return; // Check mounted after await

        String message = response.message;
        // Pass false for isLogout
        if (isApiStatus(context, response.status, message, false)) {
          _updateSubject.sink.add(ApiResponse.completed(response));
          openSimpleSnackbar(languages.updateBankDetailSuccessMsg);
          // Optionally refresh details after update?
           callGetBankDetailsApi(); // Refresh data on success
          // Or pop if this screen should close after update
          // Navigator.pop(context);
        } else {
           // isApiStatus might handle UI, update stream state
          _updateSubject.sink.add(ApiResponse.error(message));
           if (response.status != 3) openSimpleSnackbar(message); // Show error if not handled
        }
      } catch (e) {
        if (!state.mounted) return;
         String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logd(tag, "Update Bank Details Error: $e");
        openSimpleSnackbar(errorMessage);
        _updateSubject.sink.add(ApiResponse.error(errorMessage));
      }
    } else { // No internet
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
      _updateSubject.sink.add(ApiResponse.error(languages.noInternet));
    }
  }

  @override
  void dispose() {
    _subject.close();
    _updateSubject.close();
    accountNumber.dispose();
    accountHolderName.dispose();
    bankName.dispose();
    bankLocation.dispose();
    paymentEmail.dispose();
    swiftCode.dispose();
     // No super.dispose needed
  }
}