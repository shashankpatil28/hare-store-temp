// Path: lib/screen/settingScreen/setting_bloc.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../network/api_response.dart';
import '../../network/base_dl.dart'; // MODIFIED: Added this import
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import 'setting_dl.dart';
import 'settings_repo.dart'; // Corrected import from settings_repo.dart
// Removed import 'setting_screen.dart' to break circular dependency

// Helper class for Dropdowns, as inferred from setting_screen.dart
class KeyValuePair {
  final String key;
  final double value;
  KeyValuePair(this.key, this.value);

  // Required for DropdownButtonFormField2 to compare values
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyValuePair &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}

class SettingBloc implements Bloc {
  String tag = "SettingBloc>>>";
  final SettingsRepo _repo = SettingsRepo();
  BuildContext context;
  State state; // MODIFIED: Changed from State<SettingScreen> to State

  // Streams for UI
  final settingSubject = BehaviorSubject<ApiResponse<SettingModel>>();
  final updateSubject = BehaviorSubject<ApiResponse>();
  final storeTimingSubject = BehaviorSubject<List<StoreTimings>>();

  // Text Controllers
  TextEditingController orderMinAmount = TextEditingController();
  TextEditingController packageCharge = TextEditingController();

  // Dropdown data
  List<KeyValuePair> edtList = [];
  List<KeyValuePair> radiusList = [];
  KeyValuePair? deliveryTime;
  KeyValuePair? storeDeliveryRadius;

  SettingBloc(this.context, this.state) {
    // Fetch initial settings
    getAndUpdateSetting(isUpdate: false);
  }

  // Fetch or Update settings
  getAndUpdateSetting({bool isUpdate = false}) async {
    // Use the correct subject based on the action
    final subject = isUpdate ? updateSubject : settingSubject;
    if (subject.isClosed) return;

    subject.add(ApiResponse.loading());

    // Prepare store timings data
    List<StoreTimings> currentTimings = storeTimingSubject.valueOrNull ?? [];
    List<Map<String, dynamic>> timingsJson = currentTimings
        .where((timing) => timing.isCheck) // Only send checked timings
        .map((timing) => timing.toJson())
        .toList();
    String storeTiming = jsonEncode(timingsJson);

    try {
      var response = await _repo.getAndUpdateSettings(
        etaDeliveryTime: deliveryTime?.value ?? 0,
        serviceRadius: storeDeliveryRadius?.value ?? 0,
        orderMinAmount: getDoubleFromString(orderMinAmount.text),
        packagingCharges: getDoubleFromString(packageCharge.text),
        isUpdate: isUpdate ? 1 : 0, // Pass 1 for update, 0 for get
        storeTiming: storeTiming,
      );

      if (!state.mounted) return; // This check still works perfectly

      if (isUpdate) {
        // Handle update response
        BaseModel baseResponse = BaseModel.fromJson(response);
        var apiMsg = getApiMsg(context, baseResponse.message, baseResponse.messageCode);
        if (isApiStatus(context, baseResponse.status, apiMsg)) {
          updateSubject.add(ApiResponse.completed(baseResponse));
          openSimpleSnackbar(languages.settingUpdateMsg);
        } else {
          updateSubject.add(ApiResponse.error(apiMsg));
          if (baseResponse.status != 3) openSimpleSnackbar(apiMsg);
        }
      } else {
        // Handle fetch response
        SettingModel settingResponse = SettingModel.fromJson(response);
        var apiMsg = getApiMsg(context, settingResponse.message, settingResponse.messageCode);
        if (isApiStatus(context, settingResponse.status, apiMsg)) {
          settingSubject.add(ApiResponse.completed(settingResponse));
          // Populate fields with fetched data
          _populateFields(settingResponse);
        } else {
          settingSubject.add(ApiResponse.error(apiMsg));
        }
      }
    } catch (e) {
      if (!state.mounted) return; // This check still works perfectly
      String errorMessage = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
      logd(tag, "Error: $e");
      subject.add(ApiResponse.error(errorMessage));
      if (isUpdate) openSimpleSnackbar(errorMessage);
    }
  }

  // Helper to populate controllers and dropdowns from fetched data
  void _populateFields(SettingModel data) {
    orderMinAmount.text = data.orderMinAmount.toStringAsFixed(2);
    packageCharge.text = data.packagingCharges.toStringAsFixed(2);

    // Populate dropdown lists (dummy data, replace with real logic)
    edtList = [
      KeyValuePair("10 ${languages.min}", 10),
      KeyValuePair("20 ${languages.min}", 20),
      KeyValuePair("30 ${languages.min}", 30),
      KeyValuePair("40 ${languages.min}", 40),
    ];
    radiusList = [
      KeyValuePair("1 ${languages.km}", 1),
      KeyValuePair("3 ${languages.km}", 3),
      KeyValuePair("5 ${languages.km}", 5),
      KeyValuePair("10 ${languages.km}", 10),
    ];

    // Set selected values
    try {
      deliveryTime = edtList.firstWhere((item) => item.value == data.etaDeliveryTime,
          orElse: () => edtList.first);
    } catch (e) {
      deliveryTime = null;
    }

    try {
      storeDeliveryRadius = radiusList.firstWhere((item) => item.value == data.serviceRadius,
          orElse: () => radiusList.first);
    } catch (e) {
      storeDeliveryRadius = null;
    }
    
    // Populate store timings
    storeTimingSubject.add(data.storeTimings);
  }

  // Show time picker
  Future<void> selectTime(
    BuildContext context,
    Function(TimeOfDay) onTimeSelected, {
    int hour = 0,
    int minute = 0,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );
    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  @override
  void dispose() {
    settingSubject.close();
    updateSubject.close();
    storeTimingSubject.close();
    orderMinAmount.dispose();
    packageCharge.dispose();
  }
}