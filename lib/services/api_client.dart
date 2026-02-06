import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:al_wasyeah/controllers/auths/auth_controller.dart';
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'api_constants.dart';

class ApiClient extends GetxService {
  static const int timeoutInSeconds = 30;
  static bool _isLoggingOut = false;

  static final http.Client _client = http.Client();

  // ========================== GLOBAL 401 HANDLING ==========================
  static void _handleUnauthorized() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    // Clear token
    await AuthController.clearToken();

    // Navigate to login screen
    Future.microtask(() {
      Get.offAllNamed(AppRoutes.loginScreen);
      _isLoggingOut = false;
    });
  }

  // ========================== BUILD RESPONSE ==========================
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

    log('====> API Response: [${response.statusCode}] ${ApiConstants.baseUrl + uri}\nBody: $body');

    // Handle 401
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

  // ========================== RESOLVE HEADERS ==========================
  static Future<Map<String, String>> _resolveHeaders({
    Map<String, String>? headers,
    bool includeContentType = true,
  }) async {
    final token = AuthController.getToken() ?? '';

    final resolved = <String, String>{};
    if (headers != null) resolved.addAll(headers);

    if (includeContentType && !resolved.containsKey('Content-Type')) {
      resolved['Content-Type'] = 'application/json';
    }

    if (token.isNotEmpty && !resolved.containsKey('Authorization')) {
      resolved['Authorization'] = 'Bearer $token';
    }

    return resolved;
  }

  // ========================== GET ==========================
  static Future<Response> get(String uri,
      {Map<String, String>? headers}) async {
    try {
      final resolvedHeaders = await _resolveHeaders(headers: headers);
      final response = await _client
          .get(Uri.parse(ApiConstants.baseUrl + uri), headers: resolvedHeaders)
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
  static Future<Response> post(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final resolvedHeaders = await _resolveHeaders(headers: headers);
      log('====> API Request: [POST] ${ApiConstants.baseUrl + uri}\nHeaders: $resolvedHeaders\nBody: $body');

      final response = await _client
          .post(Uri.parse(ApiConstants.baseUrl + uri),
              headers: resolvedHeaders, body: jsonEncode(body))
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
  static Future<Response> put(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final resolvedHeaders = await _resolveHeaders(headers: headers);
      final response = await _client
          .put(Uri.parse(ApiConstants.baseUrl + uri),
              headers: resolvedHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } catch (_) {
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    }
  }

  // ========================== PATCH ==========================
  static Future<Response> patch(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final resolvedHeaders = await _resolveHeaders(headers: headers);
      final response = await _client
          .patch(Uri.parse(ApiConstants.baseUrl + uri),
              headers: resolvedHeaders, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } catch (_) {
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    }
  }

  // ========================== DELETE ==========================
  static Future<Response> delete(String uri,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      final resolvedHeaders = await _resolveHeaders(headers: headers);
      final response = await _client
          .delete(Uri.parse(ApiConstants.baseUrl + uri),
              headers: resolvedHeaders,
              body: body != null ? jsonEncode(body) : null)
          .timeout(const Duration(seconds: timeoutInSeconds));

      return _buildResponse(response, uri);
    } catch (_) {
      return const Response(
          statusCode: -1, statusText: "Can't connect to the internet!");
    }
  }

  // ========================== MULTIPART POST ==========================
  static Future<Response> postMultipart(
      String uri, Map<String, String> fields,
      {required List<MultipartBody> files}) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse(ApiConstants.baseUrl + uri));

      final resolvedHeaders = await _resolveHeaders(includeContentType: false);
      request.headers.addAll(resolvedHeaders);
      request.fields.addAll(fields);

      for (final file in files) {
        final mimeType = mime(file.file.path);
        request.files.add(await http.MultipartFile.fromPath(
          file.key,
          file.file.path,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ));
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

// ========================== MULTIPART MODEL ==========================
class MultipartBody {
  final String key;
  final File file;

  MultipartBody(this.key, this.file);
}

