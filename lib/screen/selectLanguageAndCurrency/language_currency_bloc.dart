// Path: lib/screen/selectLanguageAndCurrency/language_currency_bloc.dart

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../network/base_dl.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import '../homeScreen/home_screen.dart';
import '../loginScreen/login_screen.dart';
import 'language_currency_dl.dart';
import 'language_currency_screen.dart';
import 'select_language_and_currency_repo.dart';

class LanguageCurrencyBloc implements Bloc { // Changed from 'extends Bloc'
  String tag = "LanguageCurrencyBloc>>>";
  BuildContext context;
  final SelectLanguageAndCurrencyRepo _languageAndCurrencyRepo = SelectLanguageAndCurrencyRepo();
  // Define supported languages directly in the bloc or load from a config
  final List<LanguageListItem> spLanguage = [
    LanguageListItem("English", "en"),
    LanguageListItem("Norsk", "no"), // Norwegian
    // LanguageListItem("Svenska", "sv"),//Swedish
    // LanguageListItem("Dansk", "da"),//danish
    // LanguageListItem("Español", "es"),//spanish
  ];
  // Use late initialization or nullable types for selected items
  late LanguageListItem language;
  late CurrencyList currency;

  // Use BehaviorSubject to hold the latest value
  final _languageController = BehaviorSubject<List<LanguageListItem>>();
  final _selectedLanguageController = BehaviorSubject<LanguageListItem>();
  final _selectedCurrencyController = BehaviorSubject<CurrencyList>();
  final _languageAndCurrencySubject = BehaviorSubject<ApiResponse<CurrencyData>>();
  final BehaviorSubject<ApiResponse<BaseModel>> _updateSubject = BehaviorSubject<ApiResponse<BaseModel>>();

  State<LanguageCurrencyScreen> state;

  LanguageCurrencyBloc(this.context, this.state) {
    // Initialize language and fetch currency data
    _initializeSelections();
    getCurrencyData();
  }

  // Helper for initialization
  void _initializeSelections() {
    // Initialize Language
    String currentLangCode = prefGetStringWithDefaultValue(prefSelectedLanguageCode, defaultLanguage);
    int index = spLanguage.indexWhere((element) => element.languageCode == currentLangCode);
    language = spLanguage[index >= 0 ? index : 0]; // Default to first if not found
    _selectedLanguageController.sink.add(language);
    _languageController.sink.add(spLanguage); // Add the full list to the stream

    // Currency will be initialized in getCurrencyData after fetching
  }


  BehaviorSubject<ApiResponse<BaseModel>> get updateSubject => _updateSubject;

  Stream<List<LanguageListItem>> get streamLanguage => _languageController.stream;

  BehaviorSubject<ApiResponse<CurrencyData>> get languageAndCurrencySubject => _languageAndCurrencySubject;

  // Expose streams for selected values
  Stream<LanguageListItem> get streamSelectedLanguage => _selectedLanguageController.stream;
  Stream<CurrencyList> get streamSelectedCurrency => _selectedCurrencyController.stream;

  // Update selected language and notify listeners
  void setSelectedLanguage(LanguageListItem newLanguage) {
    language = newLanguage;
    if (!_selectedLanguageController.isClosed) {
      _selectedLanguageController.sink.add(newLanguage);
    }
  }

  // Update selected currency and notify listeners
  void setSelectedCurrency(CurrencyList newCurrency) {
    currency = newCurrency;
     if (!_selectedCurrencyController.isClosed) {
       _selectedCurrencyController.sink.add(newCurrency);
     }
  }

  // // Redundant, language list is added during init
  // void setLanguageData(List<LanguageListItem> languageList) {
  //   if(!_languageController.isClosed) {
  //     _languageController.sink.add(languageList);
  //   }
  // }

  // // Redundant, handled in _initializeSelections
  // getLanguageData() { ... }

  getCurrencyData() async {
     if (_languageAndCurrencySubject.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _languageAndCurrencySubject.sink.add(ApiResponse.loading());
      try {
        CurrencyData response = CurrencyData.fromJson(await _languageAndCurrencyRepo.getLanguageAndCurrency());

        if (!state.mounted) return; // Check mounted after await

        String message = response.message ?? languages.apiErrorUnexpectedErrorMsg;
        // Pass false for isLogout
        if (isApiStatus(context, response.status ?? 0, message, false)) {
           // Initialize currency selection after data is fetched
          if (response.currencyList != null && response.currencyList!.isNotEmpty) {
            String currentCurrencySymbol = prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency);
            int index = response.currencyList!.indexWhere(
              (element) => element.currencySymbol == currentCurrencySymbol,
            );
             // Ensure currency is initialized before adding to stream
            currency = response.currencyList![index >= 0 ? index : 0]; // Default to first
            setSelectedCurrency(currency); // This adds to the stream
          } else {
             // Handle case where currency list is empty - maybe show error or default?
             // For now, add error to stream
             _languageAndCurrencySubject.sink.add(ApiResponse.error(languages.noCurrenciesAvailable));
             return; // Stop further processing
          }
          // Add completed response to the main subject
          _languageAndCurrencySubject.sink.add(ApiResponse.completed(response));
        } else {
          // isApiStatus might handle UI, update stream state
          _languageAndCurrencySubject.sink.add(ApiResponse.error(message));
          // if (response.status != 3) openSimpleSnackbar(message); // Might be redundant
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logd(tag, "Get Currency Error: $e");
        openSimpleSnackbar(errorMessage);
        _languageAndCurrencySubject.sink.add(ApiResponse.error(errorMessage));
      }
    } else { // No internet
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
       _languageAndCurrencySubject.sink.add(ApiResponse.error(languages.noInternet));
    }
  }

  updateLanguageAndCurrency(bool isFromHome) async {
     if (_updateSubject.isClosed) return;

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) { // Use alias
      _updateSubject.sink.add(ApiResponse.loading());
      try {
        // Ensure language and currency are not null before accessing properties
        if (language.languageCode.isEmpty || (currency.currencySymbol ?? "").isEmpty) {
           throw Exception("Language or Currency not selected");
        }

        BaseModel response =
            BaseModel.fromJson(await _languageAndCurrencyRepo.updateCountryAndCurrency(language.languageCode, currency.currencySymbol!));

        if (!state.mounted) return; // Check mounted after await

        String message = response.message;
        // Pass false for isLogout
        if (isApiStatus(context, response.status, message, false)) {
          _updateSubject.sink.add(ApiResponse.completed(response));

          // Save preferences *before* navigating
          await prefSetString(prefSelectedCurrency, currency.currencySymbol);
          if (response.serviceCategoryName != null && response.serviceCategoryName!.isNotEmpty) {
             await prefSetString(prefServiceCategoryName, response.serviceCategoryName);
          }

          // Change language and navigate
          await setChangedLanguage(context, language.languageCode, state, nextAction: () {
            // Ensure navigation happens only once and context is valid
            if (state.mounted) {
               openScreenWithClearPrevious(context, isFromHome ? const HomeScreen() : const LoginScreen());
            }
          });
        } else {
          // isApiStatus might handle UI, update stream state
           _updateSubject.sink.add(ApiResponse.error(message));
          // if (response.status != 3) openSimpleSnackbar(message); // Might be redundant
        }
      } catch (e) {
        if (!state.mounted) return;
        String errorMessage = e is Exception ? e.toString() : (e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg);
        openSimpleSnackbar(errorMessage);
        _updateSubject.sink.add(ApiResponse.error(errorMessage));
        logd(tag, "Update Lang/Currency Error: $e");
      }
    } else { // No internet
      if (!state.mounted) return;
      openSimpleSnackbar(languages.noInternet);
      _updateSubject.sink.add(ApiResponse.error(languages.noInternet));
    }
  }

  void submit(BuildContext context, bool isFromHome) {
     // Ensure currency is selected (language is initialized in constructor)
     if (currency.currencySymbol == null || currency.currencySymbol!.isEmpty) {
        openSimpleSnackbar(languages.selectCurrency); // Assuming you have this string
        return;
     }

    if (!isLoggedIn()) {
      // Not logged in: Save preferences locally and navigate to Login
      prefSetString(prefSelectedCurrency, currency.currencySymbol!);
      setChangedLanguage(context, language.languageCode, state, nextAction: () {
         if (state.mounted) { // Check mounted again before navigating
            openScreenWithClearPrevious(context, const LoginScreen());
         }
        // openScreenWithClearPrevious(context, const LoginAndSignUp()); // Old logic?
      });
    } else {
      // Logged in: Call API to update preferences on server
      updateLanguageAndCurrency(isFromHome);
    }
  }

  @override
  void dispose() {
    // Close all stream controllers
    _updateSubject.close();
    _languageController.close();
    _languageAndCurrencySubject.close();
    _selectedLanguageController.close();
    _selectedCurrencyController.close();
    // No super.dispose needed
  }
}