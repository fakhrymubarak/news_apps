import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_apps/core/core.dart';

import '../response/error_response.dart';

class DioException implements Exception {
  static const serverNotFound =
      "Oops, server not found, please try again in a moment or contact us.";
  static const serverError =
      "Oops, there's something error on server, please try again in a moment or contact us.";
  static const connTimeout =
      "Oops, connection timed out. Please check your connection to internet.";
  static const networkNotFound =
      "Oops, you seem to be offline. Please check your connection to internet.";
  static const appsError =
      "Oops, there's something error on apps, please contact us.";

  late String errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        errorMessage = connTimeout;
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioErrorType.response:
        errorMessage = _handleErrorResponse(dioError.response);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage = DioException.networkNotFound;
          break;
        } else if (dioError.message.contains('HandshakeException')) {
          errorMessage = DioException.networkNotFound;
        } else {
          errorMessage = 'Unexpected error occurred.';
        }
        break;
      default:
        errorMessage =
            "Oops, there's something error on apps, please contact us.";
        break;
    }
    logError(dioError.message, StackTrace.current);
  }

  String _handleErrorResponse(Response<dynamic>? response) {
    final jsonResponse = response.toString();
    ErrorResponse? errResponse;

    try {
      errResponse = ErrorResponse.fromJson(jsonDecode(jsonResponse));
    } catch (e) {
      errResponse = null;
    }

    final errorMessage = errResponse?.message ?? serverError;
    switch (response?.statusCode) {
      case 400:
        return errorMessage;
      case 401:
        return errorMessage;
      case 403:
        return errorMessage;
      case 404:
        return errorMessage;
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return "$serverError (500)";
      default:
        return "$serverError (${response?.statusCode})";
    }
  }

  @override
  String toString() => errorMessage;
}
