// Path: lib/screen/offerScreen/offer_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/app_exceptions.dart'; // <-- ADD THIS IMPORT
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import 'offer_dl.dart';
import 'offer_repo.dart';
import 'offer_screen.dart';

class OfferBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "OfferBloc>>>";
  BuildContext context;
  final OfferRepo _repo = OfferRepo();

  TextEditingController minimumBillAmount = TextEditingController();
  TextEditingController discountOffer = TextEditingController();
  OfferType? offerType; // Make nullable initially

  // List of available offer types
  List<OfferType> list = [
    OfferType(languages.amount, 1),
    OfferType(languages.percentage, 2)
  ];

  // Streams for UI state
  final getOfferSubject = BehaviorSubject<ApiResponse<OfferResponse>>();
  // Separate streams for update and remove actions
  final getOfferUpdate = BehaviorSubject<ApiResponse<OfferResponse>>();
  final getOfferRemove = BehaviorSubject<ApiResponse<OfferResponse>>();

  State<OfferSate> state; // Assuming OfferSate is the State class for OfferScreen

  OfferBloc(this.context, this.state) {
    getAndUpdateOffer(isUpdate: false); // Fetch initial offer data
  }

  // Get current offer details or update/remove offer
  getAndUpdateOffer({
    required bool isUpdate,
    // Use specific subject for update/remove actions
    BehaviorSubject<ApiResponse<OfferResponse>>? subject,
    bool isClearOffer = false, // Flag to indicate removal
  }) async {
    // Use the correct subject based on action type
    final targetSubject = subject ?? getOfferSubject;
     if (targetSubject.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      targetSubject.add(ApiResponse.loading());
      try {
        // Prepare parameters for API call
        double minAmount = 0;
        double discount = 0;
        int type = 0;

        if (isUpdate && !isClearOffer) {
           // Ensure controllers have valid numbers if updating
           minAmount = getDoubleFromString(minimumBillAmount.text.trim());
           discount = getDoubleFromString(discountOffer.text.trim());
           type = offerType?.offerType ?? 0; // Use selected type or default
        } else if (isClearOffer) {
           // Send 0s to clear the offer on the backend
           isUpdate = true; // Still an update action, but clearing
           minAmount = 0;
           discount = 0;
           type = 0;
        }

        OfferResponse response = OfferResponse.fromJson(await _repo.getAndUpdateOffer(
          offerMinBillAmount: minAmount,
          offerDiscount: discount,
          offerDiscountType: type,
          isUpdate: isUpdate ? 1 : 0, // API expects int 0 or 1
        ));

        if (!state.mounted) return; // Check mounted after await

        var apiMsg = getApiMsg(context, response.message ?? languages.apiErrorUnexpectedErrorMsg, response.messageCode ?? 0);

        // Pass false for isLogout
        if (isApiStatus(context, response.status ?? 0, apiMsg, false)) {
          targetSubject.add(ApiResponse.completed(response));

           // Update UI fields only when fetching (isUpdate == false) or after successful clear
          if (!isUpdate || isClearOffer) {
             setOfferData(response.offer);
          }
          // Show success message only on explicit update/remove actions
          if (isUpdate) {
             openSimpleSnackbar(isClearOffer ? languages.removeOfferSuccessMsg : languages.updateOfferSuccessMsg);
          }
        } else {
           // API status indicates an issue
          targetSubject.add(ApiResponse.error(apiMsg));
           if (response.status != 3) openSimpleSnackbar(apiMsg); // Show error if not handled
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        targetSubject.add(ApiResponse.error(errorMessage));
        openSimpleSnackbar(errorMessage);
        logd(tag, "Offer Action Error: $e");
      }
    } else { // No internet
      if (!state.mounted) return;
      targetSubject.add(ApiResponse.error(languages.noInternet));
      openSimpleSnackbar(languages.noInternet);
    }
  }

  // Update text controllers and selected offer type
  setOfferData(Offer? offer) {
     if (offer != null) {
       minimumBillAmount.text = offer.offerMinBillAmount.toStringAsFixed(2); // Format as needed
       discountOffer.text = offer.offerDiscount.toStringAsFixed(2); // Format as needed
       // Find the corresponding OfferType object
       offerType = list.firstWhere(
             (element) => element.offerType == offer.offerDiscountType,
             orElse: () => list[0] // Default to first type if not found
       );
     } else {
        // Clear fields if no offer data
        minimumBillAmount.clear();
        discountOffer.clear();
        offerType = list[0]; // Reset to default type
     }
     // Notify dropdown if needed (though DropdownButtonFormField usually handles this)
     // Consider adding a stream for offerType if direct UI updates are needed
  }

  @override
  void dispose() {
    getOfferSubject.close();
    getOfferUpdate.close();
    getOfferRemove.close();
    minimumBillAmount.dispose();
    discountOffer.dispose();
    // No super.dispose needed
  }
}