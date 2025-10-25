// Path: lib/commonView/validator.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/payment_card.dart';

String validateCardNumber(value) {
  String validateCardNum = CardUtils().validateCardNum(value) ?? "";
  if (validateCardNum.isNotEmpty) {
    return validateCardNum;
  } else {
    return "";
  }
}

String validateExpirationDate(value) {
  String validateCardDate = CardUtils().validateDate(value) ?? "";
  if (validateCardDate.isNotEmpty) {
    return validateCardDate;
  } else {
    return "";
  }
}

String validateEmptyField(String value, String message) {
  if ((value.trim()).isEmpty) {
    return message;
  } else {
    return "";
  }
}

String validateWithFixLength(String value, int length, String emptyMsg, String invalidMsg) {
  if (value.trim().isEmpty) {
    return emptyMsg;
  } else if (value.trim().length != length) {
    return invalidMsg;
  } else {
    return "";
  }
}

String passwordValidate(value) {
  if (value.trim().isEmpty) {
    return languages.enterPass;
  } else if (value.trim().length < 6) {
    return languages.passwordMustBe6Characters;
  } else {
    return "";
  }
}

String validateOldPassword(String value) {
  if (value.trim().isEmpty) {
    return languages.enterOldPass;
  } else if (value.trim().length < 6) {
    return languages.passwordMustBe6Characters;
  } else {
    return "";
  }
}

String validateNewPassword(String value) {
  if (value.trim().isEmpty) {
    return languages.enterNewPass;
  } else if (value.trim().length < 6) {
    return languages.passwordMustBe6Characters;
  } else {
    return "";
  }
}

String validateConfPassword(String value, String newPass) {
  if (value.trim().isEmpty) {
    return languages.enterConfirmPass;
  } else if (0 != newPass.trim().compareTo(value)) {
    return languages.passwordMustBe6Characters;
  } else {
    return "";
  }
}

String fullNameValidate(value) {
  if (value.isEmpty) {
    return languages.enterFullName;
  }
  return "";
}

String mobileNumberValidate(value) {
  if (value.isEmpty) {
    return languages.enterContactNumber;
  }
  return "";
}

String confirmPasswordValidate(value, compareValue) {
  if (value.isEmpty) {
    return languages.enterConfirmPass;
  } else if (value != compareValue) {
    return languages.passwordNotMatched;
  }
  return "";
}

String emailValidate(value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  if (value.isEmpty) {
    return languages.enterEmailAddress;
  } else if (!RegExp(pattern).hasMatch(value)) {
    return languages.invalidEmailAddress;
  }
  return "";
}

String validateCourierGoods(dynamic value, double goodsItem, String emptyMsg, String invalidMsg) {
  if (value.trim().isEmpty) {
    return emptyMsg;
  } else if (value.trim().isNotEmpty && double.parse(value.trim()) > goodsItem) {
    return invalidMsg;
  }
  return "";
}

class Validator {
  validateEmptyField(String message) {
    return StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
      if ((value.trim()).isEmpty) {
        sink.addError(message);
      } else {
        sink.add(value);
      }
    });
  }

  validateEmptyFieldWithLength(int length, String emptyMessage, String lengthMessage) {
    return StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
      if (value.trim().isEmpty) {
        sink.addError(emptyMessage);
      } else if (value.trim().length < length) {
        sink.addError(lengthMessage);
      } else {
        sink.add(value);
      }
    });
  }

  final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.trim().isEmpty) {
      sink.addError(languages.enterPass);
    } else if (value.trim().length < 6) {
      sink.addError(languages.passwordMustBe6Characters);
    } else {
      sink.add(value);
    }
  });

  final validateMobileNumber = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.trim().isEmpty) {
      sink.addError(languages.enterContactNumber);
    } else {
      sink.add(value);
    }
  });

  final validateOldPassword = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    debugPrint(value);
    if ((value.trim()).isEmpty) {
      sink.addError(languages.enterOldPass);
    } else if ((value.trim()).length < 6) {
      sink.addError(languages.passwordMustBe6Characters);
    } else {
      sink.add(value);
    }
  });

  final validateNewPassword = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.trim().isEmpty) {
      sink.addError(languages.enterNewPass);
    } else if (value.trim().length < 6) {
      sink.addError(languages.passwordMustBe6Characters);
    } else {
      sink.add(value);
    }
  });

  validateWithFixLength(int length, String emptyMsg, String invalidMsg) {
    return StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
      if (value.trim().isEmpty) {
        sink.addError(emptyMsg);
      } else if (value.trim().length != length) {
        sink.addError(invalidMsg);
      } else {
        sink.add(value);
      }
    });
  }

  validateEmail(String emptyMsg, String invalidMsg) {
    return StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      if (value.trim().isEmpty) {
        sink.addError(emptyMsg);
      } else if (!RegExp(pattern).hasMatch(value)) {
        sink.addError(invalidMsg);
      } else {
        sink.add(value);
      }
    });
  }

  validateCourierGoods(double goodsItem, String emptyMsg, String invalidMsg) {
    return StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
      if (value.trim().isEmpty) {
        sink.addError(emptyMsg);
      } else if (value.trim().isNotEmpty && double.parse(value.trim()) > goodsItem) {
        sink.addError(invalidMsg);
      } else {
        sink.add(value);
      }
    });
  }
}
