// Path: lib/screen/addCard/add_card_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../network/app_exceptions.dart'; // <-- ADD THIS IMPORT
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../../utils/payment_card.dart';
import 'add_card.dart';
import 'add_card_repo.dart';

class AddCardBloc implements Bloc { // Changed from 'extends Bloc'
  BuildContext context;
  final AddCardRepo _addCardRepo = AddCardRepo();
  State<AddCard> state;
  AddCardBloc(this.context,this.state);

  TextEditingController cardHolderNameTEC = TextEditingController();
  TextEditingController cardNumberTEC = TextEditingController();
  TextEditingController expiredDateTEC = TextEditingController();
  TextEditingController cvvTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Initialize with a default or invalid type
  final _cardTypeController = BehaviorSubject<CardType>.seeded(CardType.invalid);
  final _subject = BehaviorSubject<ApiResponse<BaseModel>>();

  BehaviorSubject<ApiResponse<BaseModel>> get subject => _subject;

  Stream<CardType> get cardType => _cardTypeController.stream;

  // No need for a separate changeCardType function if only used internally
  // Function(CardType) get changeCardType => _cardTypeController.sink.add;

  // This function now handles both updating the text field and card type stream
  changeCardNumber(String value) {
    // Note: The CardNumberInputFormatter might interfere if it adds spaces
    // It's usually better to let the formatter handle display and work with cleaned number here.
    // cardNumberTEC.text = value; // Let formatter handle this
    String input = CardUtils.getCleanedNumber(value); // Get cleaned number
    // Update card type based on cleaned number
    CardType newType = CardUtils.getCardTypeFrmNumber(input);
    if (!_cardTypeController.isClosed && _cardTypeController.value != newType) {
       _cardTypeController.sink.add(newType);
    }
  }

  addCard() async {
    FocusManager.instance.primaryFocus?.unfocus();
    // Validate form before proceeding
    if (formKey.currentState?.validate() ?? false) {
      if (_subject.isClosed) return; // Check stream status

      var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
      if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
        _subject.sink.add(ApiResponse.loading());
        try {
          List<int> expiryDate = CardUtils.getExpiryDate(expiredDateTEC.text.trim());
          // Ensure expiryDate has two parts
          if (expiryDate.length == 2) {
             var response = BaseModel.fromJson(await _addCardRepo.addCard(
               cardHolderNameTEC.text.trim(),
               // Send cleaned card number to API
               CardUtils.getCleanedNumber(cardNumberTEC.text.trim()),
               expiryDate[0].toString(), // Month
               // Assuming year is 2 digits, convert if needed, or ensure API expects 2 digits
               expiryDate[1].toString(), // Year
               cvvTEC.text.trim()));

             if(!state.mounted) return; // Check mounted after await

             String message = response.message;
             // Pass false for isLogout
             if (isApiStatus(context, response.status, message, false)) {
               _subject.sink.add(ApiResponse.completed(response));
               Navigator.pop(context, true); // Pop with success result
             } else {
               // isApiStatus might handle UI, update stream state
               _subject.sink.add(ApiResponse.error(message));
               openSimpleSnackbar(message); // Show error if not handled by isApiStatus
             }
          } else {
             // Handle invalid date format if CardUtils.getExpiryDate didn't parse correctly
             throw Exception(languages.invalidDateSelection); // Or a more specific error
          }

        } catch (e) {
           if(!state.mounted) return; // Check mounted again
           // Use Exception's message if available, otherwise default
           String errorMessage = e is Exception ? e.toString() : (e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg);
          _subject.sink.add(ApiResponse.error(errorMessage));
          openSimpleSnackbar(errorMessage);
           logd("AddCardBloc", "Error: $e");
        }
      } else { // No internet
        if(!state.mounted) return;
        _subject.sink.add(ApiResponse.error(languages.noInternet));
        openSimpleSnackbar(languages.noInternet);
      }
    } else {
        logd("AddCardBloc", "Form validation failed");
    }
  }

  @override
  void dispose() {
    cardHolderNameTEC.dispose();
    cardNumberTEC.dispose();
    cvvTEC.dispose();
    expiredDateTEC.dispose();
    _cardTypeController.close();
    _subject.close();
    // No super.dispose needed
  }
}