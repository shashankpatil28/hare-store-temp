// Path: lib/network/base_dl.dart

import 'dart:convert';

class BaseModel {
  String message = "";
  String? serviceCategoryName;
  int status = 0;
  int messageCode = 0;


  BaseModel({this.message = "", this.status = 0, this.messageCode = 0});

  BaseModel.fromJson(dynamic json) {
    message = json["message"] as String? ?? "";
    status = json["status"] as int? ?? 0;
    messageCode = json["message_code"] as int? ?? 0;
    serviceCategoryName = json["service_category_name"] as String? ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    map["status"] = status;
    map["message_code"] = messageCode;
    map["service_category_name"] = serviceCategoryName;

    return map;
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class KeyValueModel {
  String key;
  bool? setDivider;
  bool? setBold;
  double? keySize;
  double? valueSize;
  String value;

  KeyValueModel(this.key, this.value, {this.setDivider, this.keySize, this.valueSize, this.setBold});
}
