// Path: lib/screen/splashScreen/splash_dl.dart

/// status : 1
/// message : "success!"
/// message_code : 1
/// app_version : "1.0"
/// is_forcefully_update : 0

class AppVersionCheckPojo {
  AppVersionCheckPojo({
    int? status,
    String? message,
    int? messageCode,
    String? appVersion,
    int? isForcefullyUpdate,
  }) {
    _status = status;
    _message = message;
    _messageCode = messageCode;
    _appVersion = appVersion;
    _isForcefullyUpdate = isForcefullyUpdate;
  }

  AppVersionCheckPojo.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _messageCode = json['message_code'];
    _appVersion = json['app_version'];
    _isForcefullyUpdate = json['is_forcefully_update'];
  }

  int? _status;
  String? _message;
  int? _messageCode;
  String? _appVersion;
  int? _isForcefullyUpdate;

  int? get status => _status;

  String? get message => _message;

  int? get messageCode => _messageCode;

  String? get appVersion => _appVersion;

  int? get isForcefullyUpdate => _isForcefullyUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['message_code'] = _messageCode;
    map['app_version'] = _appVersion;
    map['is_forcefully_update'] = _isForcefullyUpdate;
    return map;
  }
}