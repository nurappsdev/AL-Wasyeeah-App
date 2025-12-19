import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../helpers/prefs_helper.dart';
import 'api_constants.dart';

class ApiClient extends GetxService {
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
      Get.offAllNamed(AppRoutes.loginScreen);
      _isLoggingOut = false;
    });
  }

  static Response _buildResponse(http.Response response, String uri) {
    dynamic body;

    try {
      body = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (_) {
      body = response.body;
    }

    final statusText = body is Map && body['message'] != null
        ? body['message'].toString()
        : response.reasonPhrase;

    log('====> API Response: [${response.statusCode}] ${ApiConstants.baseUrl + uri}\n$body');

    // 🔴 GLOBAL 401 HANDLING
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
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    } on TimeoutException {
      return const Response(statusCode: -1, statusText: 'Request timeout');
    } catch (e) {
      return Response(statusCode: -1, statusText: e.toString());
    }
  }

  // ========================== POST ==========================

  static Future<Response> postData(
    String uri,
    Map<String, dynamic> body, {
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
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    } on TimeoutException {
      return const Response(statusCode: -1, statusText: 'Request timeout');
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
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
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
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
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
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    }
  }

  // ========================== MULTIPART POST ==========================

  static Future<Response> postMultipartData(
    String uri,
    Map<String, String> fields, {
    required List<MultipartBody> files,
  }) async {
    try {
      _bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      final request =
          http.MultipartRequest('POST', Uri.parse(ApiConstants.baseUrl + uri));

      request.headers['Authorization'] = 'Bearer $_bearerToken';
      request.fields.addAll(fields);

      for (final file in files) {
        final mimeType = mime(file.file.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            file.key,
            file.file.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      return _buildResponse(response, uri);
    } catch (_) {
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    }
  }
}

// ========================== MODELS ==========================

class MultipartBody {
  final String key;
  final File file;

  MultipartBody(this.key, this.file);
}
