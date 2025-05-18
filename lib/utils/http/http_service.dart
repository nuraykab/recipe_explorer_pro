import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<Map<String, dynamic>> getRequest(String url,
      [bool isPrint = false]) async {
    _logRequest('GET', url);

    try {
      final response = await http.get(Uri.parse(url));
      _logResponse('GET', response, url, isPrint);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          return data;
        } else {
          return {};
        }
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      log("GET request failed with error: $e");
      // throw Exception('GET request failed');
      return {};
    }
  }

  static void _logRequest(String method, String url, [String? body]) {
    log('HTTP $method Request: $url');
    if (body != null) log('Request Body: $body');
  }

  static void _logResponse(
      String method, http.Response response, String url, bool isPrint) {
    var data = isPrint ? response.body : '';
    log('HTTP $method Request:- Url:$url, HTTP Response: ${response.statusCode} - $data');
    // log(ExceptionHandler.handleException(response));
  }
}
