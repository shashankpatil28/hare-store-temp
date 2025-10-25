// Path: lib/screen/selectLanguageAndCurrency/select_language_and_currency_repo.dart

import '../../network/api_base_helper.dart';
import '../../network/api_data.dart' show ApiParam;
import '../../network/endpoints.dart';
import '../../utils/common_util.dart';

class SelectLanguageAndCurrencyRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  getLanguageAndCurrency() async {
    final response =
        await _apiBaseHelper.post(EndPoint.endPointCountryCurrency);
    return response;
  }

  updateCountryAndCurrency(String languageCode, String currencySymbol) async {
    final response = await _apiBaseHelper.post(
      EndPoint.endPointUpdateCountryCurrency,
      body: {
        ApiParam.paramStoreId: prefGetInt(prefStoreId),
        ApiParam.paramStoreServiceId: prefGetInt(prefStoreServiceId),
        ApiParam.paramAccessToken: prefGetString(prefAccessToken),
        ApiParam.paramSelectLanguage: languageCode,
        ApiParam.paramSelectCountryCode: defaultCountryCode.dialCode,
        ApiParam.paramSelectCurrency: currencySymbol,
      },
    );
    return response;
  }
}
