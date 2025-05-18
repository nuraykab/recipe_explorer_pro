import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ExceptionHandler {
  // Firebase Auth Exception handling
  static String _handleFirebaseAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-verification-code':
        return 'The OTP entered is invalid. Please check and try again.';
      case 'invalid-phone-number':
        return 'The phone number entered is invalid. Please check and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'session-expired':
        return 'The OTP session has expired. Please request a new OTP.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'unknown':
        return 'An unknown error occurred. Please try again.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // MongoDB API Exception handling
  static String _handleMongoDBException(http.Response response) {
    String errorMessage;

    switch (response.statusCode) {
      case 400:
        errorMessage = 'Bad request. Please verify the data being sent.';
        break;
      case 401:
        errorMessage =
            'Unauthorized. Authentication failed. Please check your credentials.';
        break;
      case 403:
        errorMessage =
            'Forbidden. You do not have permission to access this resource.';
        break;
      case 404:
        errorMessage = 'Resource not found. The requested item does not exist.';
        break;
      case 405:
        errorMessage =
            'Method not allowed. The HTTP method used is not supported by this endpoint.';
        break;
      case 408:
        errorMessage =
            'Request timeout. The server took too long to respond. Please try again.';
        break;
      case 409:
        errorMessage =
            'Conflict. The request could not be completed due to a conflict with the current state of the resource.';
        break;
      case 429:
        errorMessage =
            'Too many requests. You have exceeded the rate limit. Please wait and try again later.';
        break;
      case 500:
        errorMessage =
            'Internal server error. The server encountered an unexpected condition.';
        break;
      case 502:
        errorMessage =
            'Bad gateway. The server received an invalid response from an upstream server.';
        break;
      case 503:
        errorMessage =
            'Service unavailable. The server is currently unavailable. Please try again later.';
        break;
      case 504:
        errorMessage =
            'Gateway timeout. The server did not receive a timely response from an upstream server.';
        break;
      default:
        errorMessage =
            'An unknown error occurred with MongoDB. Status code: ${response.statusCode}, '
            'Message: ${response.reasonPhrase ?? 'No additional information.'}';
        break;
    }

    // Optionally, log the response for debugging purposes
    log('MongoDB Error [${response.statusCode}]: ${response.body}');

    return errorMessage;
  }

  static String handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      return _handleFirebaseAuthException(e);
    } else if (e is FirebaseException) {
      return 'Firebase Exception: ${e.message}';
    } else if (e is FormatException) {
      return 'Format Exception: ${e.message}';
    } else if (e is PlatformException) {
      return 'Platform Exception: ${e.message}';
    } else if (e is http.Response) {
      return _handleMongoDBException(e);
    } else {
      return 'An unknown exception occurred.';
    }
  }
}
