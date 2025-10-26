// Path: lib/network/api_base_helper.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:temp/utils/common_util.dart'; // Assuming temp is your project name

import '../main.dart'; // Assuming main.dart exports languages
import '../utils/shared_preferences_util.dart';
import 'endpoints.dart'; // Import EndPoint from its dedicated file
import 'app_exceptions.dart'; // Assuming this is the correct exceptions file

class ApiBaseHelper {
  final String _baseUrl = EndPoint.baseUrl;
  final Dio _dio = Dio();

  String get baseUrl => _baseUrl;

  ApiBaseHelper() {
    _dio.options.baseUrl = _baseUrl;
    // Dio 5 uses Duration directly for timeouts, which your code already does.
    _dio.options.connectTimeout = const Duration(minutes: 3);
    _dio.options.receiveTimeout = const Duration(minutes: 3);
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      _dio.options.headers = headers ?? await getHeaders();
      final response = await _dio.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception(languages.noInternet);
    } on DioException catch (e) { // Updated from DioError to DioException
      responseJson = _handleDioException(e);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic body, Map<String, String>? headers}) async {
    try {
      dynamic responseJson;
      _dio.options.headers = headers ?? await getHeaders();
      final response = await _dio.post(url, data: body);
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw Exception(languages.noInternet);
    } on DioException catch (e) { // Updated from DioError to DioException
      return _handleDioException(e);
    }
  }

  Future<dynamic> postFormData(String url, {dynamic body, Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      _dio.options.headers = headers ?? await getHeaders(isFormData: true);
      final response = await _dio.post(url, data: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception(languages.noInternet);
    } on DioException catch (e) { // Updated from DioError to DioException
      responseJson = _handleDioException(e);
    }
    return responseJson;
  }
  Future<dynamic> put(String url, {dynamic body, Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      _dio.options.headers = headers ?? await getHeaders();
      final response = await _dio.put(url, data: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception(languages.noInternet);
    } on DioException catch (e) { // Updated from DioError to DioException
      responseJson = _handleDioException(e);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url,
      {dynamic body, Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      _dio.options.headers = headers ?? await getHeaders();
      final response = await _dio.delete(url, data: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception(languages.noInternet);
    } on DioException catch (e) { // Updated from DioError to DioException
      responseJson = _handleDioException(e);
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.data;
        // You might want to add basic status checking here if your API includes it in the body
        // e.g., if (responseJson['status'] == 0) throw Exception(responseJson['message']);
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        // Consider triggering logout or token refresh logic here
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw Exception(
            '${languages.apiErrorCommunicationMsg} : ${response.statusCode}');
    }
  }

  // --- Updated Exception Handling for Dio v5 ---
  dynamic _handleDioException(DioException dioException) {
    String errorDescription = "";
    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorDescription = languages.apiErrorCancelMsg;
        break;
      case DioExceptionType.connectionTimeout: // Updated from connectTimeout
        errorDescription = languages.apiErrorConnectTimeoutMsg;
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = languages.apiErrorSendTimeoutMsg;
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = languages.apiErrorReceiveTimeoutMsg;
        break;
      case DioExceptionType.badResponse: // Updated from response
        // You can get status code from dioException.response?.statusCode
        errorDescription =
            "${languages.apiErrorResponseMsg} ${dioException.response?.statusCode ?? ''}";
        // Optionally handle specific status codes like 401/403 here too
        if (dioException.response?.statusCode == 401 || dioException.response?.statusCode == 403) {
           // Maybe throw UnauthorisedException or trigger logout
        }
        break;
      case DioExceptionType.connectionError: // New type in v5, covers SocketException etc.
         errorDescription = languages.noInternet; // Or a more specific connection error message
         break;
      case DioExceptionType.unknown: // Updated from other
      default: // Includes badCertificate, unknown
        // Check if it's a SocketException disguised as 'unknown'
        if (dioException.error is SocketException) {
          errorDescription = languages.noInternet;
        } else {
          errorDescription = languages.apiErrorOtherMsg;
        }
        break;
    }
    throw Exception(errorDescription);
  }

  Future<Map<String, String>> getHeaders({bool isFormData = false}) async {
    String accessToken = prefGetString(prefAccessToken);
    String languageCode = prefGetStringWithDefaultValue(prefSelectedLanguageCode, defaultLanguage); // Use default if empty
    String currency = prefGetStringWithDefaultValue(prefSelectedCurrency, defaultCurrency); // Use default if empty
    // MODIFIED: Added .toString() to get the timezone name string
    String timeZone = (await FlutterTimezone.getLocalTimezone()).toString();

    Map<String, String> headers = {
      // Content-Type might be set automatically by Dio based on data, but explicitly setting is fine
      // 'Content-Type': isFormData ? 'multipart/form-data' : 'application/json',
      'Accept': 'application/json', // Usually always accept JSON
    };

    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    // Only add headers if they have values
    if (languageCode.isNotEmpty) {
      headers['X-localization'] = languageCode;
    }
    if (currency.isNotEmpty) {
      headers['X-currency'] = currency;
    }
    if (timeZone.isNotEmpty) {
      headers['X-timezone'] = timeZone;
    }

    // Add platform header (good practice)
    headers['X-Platform'] = Platform.isAndroid ? 'android' : (Platform.isIOS ? 'ios' : 'other');


    logd("API Headers", headers.toString()); // Log headers for debugging
    return headers;
  }
}