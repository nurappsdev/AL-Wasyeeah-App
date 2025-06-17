
import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constant.dart';

class WasyyahController extends GetxController {
  var isWasyyah = false.obs;
  var wasyyahYouData = <GetWasyyahResponseModel>[].obs;

  @override
  void onInit() {
    getWasyyahData();
    super.onInit();
  }

  Future<void> fetchWasyyahData() async {
    isWasyyah.value = true;

    try {
      final response = await http.get(Uri.parse("${ApiConstants.baseUrl}${ApiConstants.wasyyahYouDataYouEndPoint}"));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        wasyyahYouData.clear();
        if (decoded is List) {
          wasyyahYouData.addAll(decoded.map((e) => GetWasyyahResponseModel.fromJson(e)));
        } else {
          wasyyahYouData.add(GetWasyyahResponseModel.fromJson(decoded));
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isWasyyah.value = false;
    }
  }


  getWasyyahData() async {
    isWasyyah(true);

    try {
      // 1️⃣ টোকেন PrefsHelper থেকে আনুন
      final token = await PrefsHelper.getString(AppConstants.bearerToken);

      // 2️⃣ হেডার তৈরি করুন
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // 3️⃣ API কল করুন
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.wasyyahYouDataYouEndPoint}"),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = json.decode(decodedBody);

        wasyyahYouData.value = jsonData
            .map((item) => GetWasyyahResponseModel.fromJson(item))
            .toList();

        print("✅ Data Loaded: ${wasyyahYouData.length} items");
      } else {
        print("❌ Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception in getWasyyahData: $e");
    }

    isWasyyah(false);
  }

}