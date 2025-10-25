// Path: lib/dialog/forgotPasswordDialog/forgot_pass_req_pojo.dart


class ForgotPassReqPojo {
  int? _status;
  String? _message;
  int? _storeId;
  int? _messageCode;

  int? get status => _status;

  String? get message => _message;

  int? get storeId => _storeId;

  int? get messageCode => _messageCode;

  ForgotPassReqPojo({int? status, String? message, int? driverId, int? messageCode}) {
    _status = status;
    _message = message;
    _storeId = driverId;
    _messageCode = messageCode;
  }

  ForgotPassReqPojo.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _storeId = json["store_id"];
    _messageCode = json["message_code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["store_id"] = _storeId;
    map["message_code"] = _messageCode;
    return map;
  }
}