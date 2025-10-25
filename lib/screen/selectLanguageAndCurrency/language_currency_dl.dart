// Path: lib/screen/selectLanguageAndCurrency/language_currency_dl.dart

class LanguageListItem {
  final String languageName;
  final String languageCode;

  LanguageListItem(this.languageName, this.languageCode);

  @override
  String toString() {
    return languageName;
  }
}

class CurrencyData {
  int? _status;
  String? _message;
  int? _messageCode;
  List<dynamic>? _countryList;
  List<CurrencyList>? _currencyList;

  int? get status => _status;

  String? get message => _message;

  int? get messageCode => _messageCode;

  List<dynamic>? get countryList => _countryList;

  List<CurrencyList>? get currencyList => _currencyList;

  CurrencyData({int? status, String? message, int? messageCode, List<dynamic>? countryList, List<CurrencyList>? currencyList}) {
    _status = status;
    _message = message;
    _messageCode = messageCode;
    _countryList = countryList;
    _currencyList = currencyList;
  }

  CurrencyData.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _messageCode = json["message_code"];
    if (json["currency_list"] != null) {
      _currencyList = [];
      json["currency_list"].forEach((v) {
        _currencyList?.add(CurrencyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["message_code"] = _messageCode;
    if (_countryList != null) {
      map["country_list"] = _countryList?.map((v) => v.toJson()).toList();
    }
    if (_currencyList != null) {
      map["currency_list"] = _currencyList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CurrencyList {
  int? _currencyId;
  String? _currencyName;
  String? _currencySymbol;

  int? get currencyId => _currencyId;

  String? get currencyName => _currencyName;

  String? get currencySymbol => _currencySymbol;

  CurrencyList({int? currencyId, String? currencyName, String? currencySymbol}) {
    _currencyId = currencyId;
    _currencyName = currencyName;
    _currencySymbol = currencySymbol;
  }

  CurrencyList.fromJson(dynamic json) {
    _currencyId = json["currency_id"];
    _currencyName = json["currency_name"];
    _currencySymbol = json["currency_symbol"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currency_id"] = _currencyId;
    map["currency_name"] = _currencyName;
    map["currency_symbol"] = _currencySymbol;
    return map;
  }
}

/// status : 1
/// message : "success!"
/// message_code : 1
/// driver_service : "خدمة الركوب, تسليم البريد السريع, تسليم المتجر"

class UpdateData {
  UpdateData({
    int? status,
    String? message,
    int? messageCode,
    String? driverService,
  }) {
    _status = status;
    _message = message;
    _messageCode = messageCode;
    _driverService = driverService;
  }

  UpdateData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _messageCode = json['message_code'];
    _driverService = json['driver_service'];
  }

  int? _status;
  String? _message;
  int? _messageCode;
  String? _driverService;

  int? get status => _status;

  String? get message => _message;

  int? get messageCode => _messageCode;

  String? get driverService => _driverService;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['message_code'] = _messageCode;
    map['driver_service'] = _driverService;
    return map;
  }
}
