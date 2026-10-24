import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/route/route_names.dart';
import 'package:wasiyyat/app/core/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import '../shared_pref/prefs_service.dart';
import '../../utils/api_constants.dart';

class ApiService extends GetxService {
  static final http.Client _client = http.Client();
  static bool _isLoggingOut = false;
  static const int timeoutInSeconds = 30;
  static String _bearerToken = '';

  // ========================== COMMON RESPONSE BUILDER ==========================
  static void _handleUnauthorized() async {
    if (_isLoggingOut) return;

    _isLoggingOut = true;

    // Clear session
    await PrefsHelper.remove(AppConstants.bearerToken);

    // Navigate to login (delay avoids context issues)
    Future.microtask(() {
      Get.offAllNamed(RouteName.loginPage);
      _isLoggingOut = false;
    });
  }

  static Response _buildResponse(http.Response response, String uri) {
    dynamic body;
    String? message;

    final rawBody = utf8.decode(response.bodyBytes).trim();

    // 1. Parse the response body.
    if (rawBody.isEmpty) {
      body = null;
    } else {
      try {
        body = jsonDecode(rawBody);
      } catch (_) {
        // The response is not valid JSON.
        body = rawBody;
      }
    }

    // 2. Extract a meaningful error message.
    if (body is Map) {
      final apiMessage = body['message'];

      if (apiMessage != null && apiMessage.toString().trim().isNotEmpty) {
        message = apiMessage.toString().trim();
      }
    } else if (body is String && body.trim().isNotEmpty) {
      message = body.trim();
    }

    // 3. Use a fallback when the API provides no useful message.
    final statusText = message ?? 'Something went wrong. Please try again.';

    log(
      '====> API Response: [${response.statusCode}] '
      '${ApiConstants.baseUrl + uri}\n'
      'Token: $_bearerToken\n'
      'Body:\n${jsonEncode(body)}',
    );

    // 4. Handle unauthorized responses globally.
    if (response.statusCode == 401) {
      _handleUnauthorized();
    }

    return Response(
      statusCode: response.statusCode,
      body: body,
      statusText: statusText,
      headers: response.headers,
      request: Request(
        url: response.request!.url,
        method: response.request!.method,
        headers: response.request!.headers,
      ),
    );
  }

  static Future<Map<String, String>> _defaultHeaders() async {
    _bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_bearerToken',
    };
  }

  // ========================== GET ==========================
  static Future<Response> getData(
    String uri, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client
          .get(
            Uri.parse(ApiConstants.baseUrl + uri),
            headers: headers ?? await _defaultHeaders(),
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _buildResponse(response, uri);
    } on SocketException {
      return Response(
          statusCode: 404,
          statusText:
              AppLocalizations.of(Get.context!)!.cant_connect_to_the_internet);
    } on TimeoutException {
      return Response(
          statusCode: 404,
          statusText: AppLocalizations.of(Get.context!)!.request_timeout);
    } catch (e) {
      return Response(statusCode: 404, statusText: e.toString());
    }
  }

  // ========================== POST ==========================

  static Future<Response> postData(
    String uri, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    log('====> API Request: [POST] ${ApiConstants.baseUrl + uri}\n$headers\n$body');
    try {
      final response = await _client
          .post(
            Uri.parse(ApiConstants.baseUrl + uri),
            headers: headers ?? await _defaultHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } on SocketException {
      return Response(
          statusCode: -1,
          statusText:
              AppLocalizations.of(Get.context!)!.cant_connect_to_the_internet);
    } on TimeoutException {
      return Response(
          statusCode: -1,
          statusText: AppLocalizations.of(Get.context!)!.request_timeout);
    } catch (e) {
      return Response(statusCode: -1, statusText: e.toString());
    }
  }

  // ========================== PUT ==========================

  static Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client
          .put(
            Uri.parse(ApiConstants.baseUrl + uri),
            headers: headers ?? await _defaultHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } catch (_) {
      return Response(
          statusCode: -1,
          statusText:
              AppLocalizations.of(Get.context!)!.cant_connect_to_the_internet);
    }
  }

  // ========================== PATCH ==========================

  static Future<Response> patchData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client
          .patch(
            Uri.parse(ApiConstants.baseUrl + uri),
            headers: headers ?? await _defaultHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } catch (_) {
      return Response(
          statusCode: -1,
          statusText:
              AppLocalizations.of(Get.context!)!.cant_connect_to_the_internet);
    }
  }

  // ========================== DELETE ==========================

  static Future<Response> deleteData(
    String uri, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client
          .delete(
            Uri.parse(ApiConstants.baseUrl + uri),
            headers: headers ?? await _defaultHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } catch (_) {
      return Response(
          statusCode: -1,
          statusText:
              AppLocalizations.of(Get.context!)!.cant_connect_to_the_internet);
    }
  }

  // ========================== MULTIPART POST ==========================

//   static Future<Response> postMultipartData(
//     String uri,
//     Map<String, String> fields, {
//     required List<MultipartBody> files,
//   }) async {
//     try {
//       _bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

//       final request =
//           http.MultipartRequest('POST', Uri.parse(ApiConstants.baseUrl + uri));

//       request.headers['Authorization'] = 'Bearer $_bearerToken';
//       request.fields.addAll(fields);

//       for (final file in files) {
//         final mimeType = mime(file.file.path);
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             file.key,
//             file.file.path,
//             contentType: mimeType != null ? MediaType.parse(mimeType) : null,
//           ),
//         );
//       }

//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);

//       return _buildResponse(response, uri);
//     } catch (_) {
//       return Response(
//           statusCode: -1,
//           statusText:
//               AppLocalizations.of(Get.context!)!.cant_connect_to_the_internet);
//     }
//   }
}

// ========================== MODELS ==========================

class MultipartBody {
  final String key;
  final File file;

  MultipartBody(this.key, this.file);
}
