// import 'dart:convert';
//
// import 'package:al_wasyeah/helpers/helpers.dart';
// import 'package:get/get.dart';
//
// import '../../helpers/prefs_helper.dart';
// import '../../models/models.dart';
// import '../../services/services.dart';
// import 'package:http/http.dart' as http;
//
// import '../../utils/app_constant.dart';
//
// class WasyyahController extends GetxController {
//
//   @override
//   void onInit() {
//     getWasyyahData();
//     super.onInit();
//   }
//
//   var isWasyyah = false.obs;
//   var wasyyahYouData = <GetWasyyahResponseModel>[].obs;
//   var isUpdateWasseya = false.obs;
//   var isLoading = false.obs;
//
//   getWasyyahData() async {
//     isWasyyah(true);
//
//     try {
//       // 1️⃣ টোকেন PrefsHelper থেকে আনুন
//       final token = await PrefsHelper.getString(AppConstants.bearerToken);
//
//       // 2️⃣ হেডার তৈরি করুন
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//
//       // 3️⃣ API কল করুন
//       final response = await http.get(
//         Uri.parse("${ApiConstants.baseUrl}${ApiConstants.wasyyahYouDataYouEndPoint}"),
//         headers: headers,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final decodedBody = utf8.decode(response.bodyBytes);
//         final List<dynamic> jsonData = json.decode(decodedBody);
//
//         wasyyahYouData.value = jsonData
//             .map((item) => GetWasyyahResponseModel.fromJson(item))
//             .toList();
//
//         print("✅ Data Loaded: ${wasyyahYouData.length} items");
//       } else {
//         print("❌ Failed with status: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception in getWasyyahData: $e");
//     }
//
//     isWasyyah(false);
//   }
//
//   Future<void> updateWasyyahData({
//     required int orderSeq,
//     required String visible,
//     required String title,
//     required String requestKey,
//     required String content,
//   }) async {
//     isUpdateWasseya(true);
//
//     try {
//       final url = Uri.parse("${ApiConstants.baseUrl}/user/saveWasiyyah");
//       String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $bearerToken',
//       };
//
//       final body = jsonEncode({
//         "orderSeq": orderSeq,
//         "visible": visible,
//         "title": title,
//         "requestKey": requestKey,
//         "content": content,
//       });
//
//       final response = await http.post(url, headers: headers, body: body);
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ToastMessageHelper.successMessageShowToster("RECORD INSERTED SUCCESSFULLY!!");
//         getWasyyahData();
//         Get.back();
//         update();
//       } else {
//         ToastMessageHelper.errorMessageShowToster("error, try again");
//       }
//     } catch (e) {
//       print("❗ Exception: $e");
//       ToastMessageHelper.errorMessageShowToster("Network error occurred");
//     } finally {
//       isUpdateWasseya(false);
//     }
//   }
//
//   ///-----------------need drag and drop--------------------------
//   void swapOnly(int oldIndex, int newIndex) {
//     if (oldIndex == newIndex) return;
//
//     final temp = wasyyahYouData[oldIndex];
//     wasyyahYouData[oldIndex] = wasyyahYouData[newIndex];
//     wasyyahYouData[newIndex] = temp;
//
//     wasyyahYouData.refresh();
//   }
//
//   // Main method for updating order sequence
//   Future<bool> updateAllOrderSeqHttp() async {
//     isLoading.value = true;
//
//     // Store original orderSeq values for rollback
//     final originalOrderSeqs = <int>[];
//     for (var item in wasyyahYouData) {
//       originalOrderSeqs.add(item.orderSeq ?? 0);
//     }
//
//     try {
//       // Step 1: Update local orderSeqs
//       for (int i = 0; i < wasyyahYouData.length; i++) {
//         wasyyahYouData[i].orderSeq = i + 1;
//       }
//       wasyyahYouData.refresh();
//
//       // Step 2: Create payload - CORRECTED VERSION
//       final payload = {
//         "data": wasyyahYouData
//             .map((item) => {
//           "requestKey": item.requestKey,
//           "order": item.orderSeq,
//         })
//             .toList(),
//       };
//
//       print("📤 Sending payload: ${jsonEncode(payload)}");
//
//       // Step 3: Send to backend
//       final uri = Uri.parse("${ApiConstants.baseUrl}/user/changeOrder");
//       String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//       final response = await http.post(
//         uri,
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $bearerToken',
//         },
//         body: jsonEncode(payload),
//       ).timeout(Duration(seconds: 30));
//
//       if (response.statusCode == 200) {
//         print("✅ Order updated successfully");
//         ToastMessageHelper.successMessageShowToster("Order updated successfully!");
//         return true;
//       } else {
//         // Rollback original orderSeq values
//         for (int i = 0; i < wasyyahYouData.length; i++) {
//           wasyyahYouData[i].orderSeq = originalOrderSeqs[i];
//         }
//         wasyyahYouData.refresh();
//
//         print("❌ Order update failed: ${response.statusCode}");
//         print("Response body: ${response.body}");
//         Get.snackbar("Error", "Failed to update order. Status: ${response.statusCode}");
//         return false;
//       }
//     } catch (e) {
//       // Rollback original orderSeq values
//       for (int i = 0; i < wasyyahYouData.length; i++) {
//         wasyyahYouData[i].orderSeq = originalOrderSeqs[i];
//       }
//       wasyyahYouData.refresh();
//
//       print("❌ Error updating order: $e");
//       Get.snackbar("Error", "Network error occurred");
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Simple version without rollback (your original working version)
//   Future<void> updateAllOrderSeqHttpSimple() async {
//     // Step 1: Update local orderSeqs
//     for (int i = 0; i < wasyyahYouData.length; i++) {
//       wasyyahYouData[i].orderSeq = i + 1;
//     }
//     wasyyahYouData.refresh();
//
//     // Step 2: Create payload
//     final payload = {
//       "data": wasyyahYouData
//           .map((e) => {
//         "requestKey": e.requestKey,
//         "order": e.orderSeq,
//       })
//           .toList(),
//     };
//
//     // Step 3: Send to backend
//     final uri = Uri.parse("${ApiConstants.baseUrl}/user/changeOrder");
//     String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//     try {
//       final response = await http.post(
//         uri,
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $bearerToken',
//         },
//         body: jsonEncode(payload),
//       );
//
//       if (response.statusCode == 200) {
//         print("✅ Order updated successfully");
//         ToastMessageHelper.successMessageShowToster("Order updated!");
//       } else {
//         print("❌ Order update failed: ${response.statusCode}");
//         print(response.body);
//         ToastMessageHelper.errorMessageShowToster("Failed to update order");
//       }
//     } catch (e) {
//       print("❌ Error updating order: $e");
//       ToastMessageHelper.errorMessageShowToster("Network error");
//     }
//   }
//
//   // Method to call after drag & drop
//   Future<void> updateOrderAfterDragDrop() async {
//     final success = await updateAllOrderSeqHttp();
//     if (!success) {
//       // If failed, refresh data from server
//       print("🔄 Refreshing data from server due to update failure");
//       await getWasyyahData();
//     }
//   }
// }


import 'dart:convert';

import 'package:al_wasyeah/helpers/helpers.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constant.dart';

class WasyyahController extends GetxController {

  @override
  void onInit() {
    getWasyyahData();
    super.onInit();
  }

  var isWasyyah = false.obs;
  var wasyyahYouData = <GetWasyyahResponseModel>[].obs;
  var isUpdateWasseya = false.obs;
  var isLoading = false.obs;

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

  Future<void> updateWasyyahData({
    required int orderSeq,
    required String visible,
    required String title,
    required String requestKey,
    required String content,
  }) async {
    isUpdateWasseya(true);

    try {
      final url = Uri.parse("${ApiConstants.baseUrl}/user/saveWasiyyah");
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };

      final body = jsonEncode({
        "orderSeq": orderSeq,
        "visible": visible,
        "title": title,
        "requestKey": requestKey,
        "content": content,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        getWasyyahData();
        ToastMessageHelper.successMessageShowToster("RECORD INSERTED SUCCESSFULLY!!");
        update();
        isUpdateWasseya(false);
      } else {
        ToastMessageHelper.errorMessageShowToster("error, try again");
      }
    } catch (e) {
      print("❗ Exception: $e");
      ToastMessageHelper.errorMessageShowToster("Network error occurred");
    } finally {
      isUpdateWasseya(false);
    }
  }

///---------------view----------------------
  void contentVisible(GetWasyyahResponseModel item) async {
    final previousVisibility = item.visible;
    // Toggle visibility: if 'Y' then 'N', else 'Y'
    item.visible = item.visible == 'Y' ? 'N' : 'Y';

    try {
      await updateWasyyahData(
        orderSeq: item.orderSeq ?? 0,
        visible: item.visible ?? 'N',
        title: item.title ?? '',
        requestKey: item.requestKey ?? '',
        content: item.content ?? '',
      );
    } catch (e) {
      // If API call fails, revert visibility
      item.visible = previousVisibility;
      print('❌ Error updating visibility: $e');
      ToastMessageHelper.errorMessageShowToster("Failed to update visibility.");
    }
  }


  ///-----------------DRAG AND DROP WITH BACKEND UPDATE--------------------------
  var isDragDropLoading = false.obs;

  // Original swap method (for UI only)
  void swapOnly(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;

    final temp = wasyyahYouData[oldIndex];
    wasyyahYouData[oldIndex] = wasyyahYouData[newIndex];
    wasyyahYouData[newIndex] = temp;

    wasyyahYouData.refresh();
  }

  // MAIN DRAG DROP METHOD - Use this in your ReorderableListView
  Future<void> onReorderItems(int oldIndex, int newIndex) async {
    // Prevent multiple simultaneous reorders
    if (isDragDropLoading.value) return;

    print("🔄 Reordering from $oldIndex to $newIndex");

    // Step 1: Perform UI swap first
    if (newIndex > oldIndex) {
      newIndex -= 1; // ReorderableListView এর জন্য adjustment
    }

    if (oldIndex == newIndex) return;

    // Store original state for rollback
    final originalList = wasyyahYouData.toList();

    // Step 2: Update UI immediately
    final item = wasyyahYouData.removeAt(oldIndex);
    wasyyahYouData.insert(newIndex, item);
    wasyyahYouData.refresh();

    // Step 3: Update backend
    isDragDropLoading.value = true;

    try {
      final success = await updateAllOrderSeqHttp();

      if (success) {
        print("✅ Drag drop completed successfully");
        ToastMessageHelper.successMessageShowToster("Order updated!");
      } else {
        // Rollback UI on backend failure
        wasyyahYouData.clear();
        wasyyahYouData.addAll(originalList);
        wasyyahYouData.refresh();
        print("❌ Backend update failed, UI rolled back");
      }
    } catch (e) {
      // Rollback UI on exception
      wasyyahYouData.clear();
      wasyyahYouData.addAll(originalList);
      wasyyahYouData.refresh();
      print("❌ Exception during drag drop: $e");
    } finally {
      isDragDropLoading.value = false;
    }
  }

  // Alternative method for manual reorder (button-based)
  Future<void> moveItemUp(int index) async {
    if (index <= 0) return;
    await onReorderItems(index, index - 1);
  }

  Future<void> moveItemDown(int index) async {
    if (index >= wasyyahYouData.length - 1) return;
    await onReorderItems(index, index + 1);
  }

  // Main method for updating order sequence
  Future<bool> updateAllOrderSeqHttp() async {
    isLoading.value = true;

    // Store original orderSeq values for rollback
    final originalOrderSeqs = <int>[];
    for (var item in wasyyahYouData) {
      originalOrderSeqs.add(item.orderSeq ?? 0);
    }

    try {
      // Step 1: Update local orderSeqs
      for (int i = 0; i < wasyyahYouData.length; i++) {
        wasyyahYouData[i].orderSeq = i + 1;
      }
      wasyyahYouData.refresh();

      // Step 2: Create payload - CORRECTED VERSION
      final payload = {
        "data": wasyyahYouData
            .map((item) => {
          "requestKey": item.requestKey,
          "order": item.orderSeq ?? 1,
        })
            .toList(),
      };

      print("📤 Sending payload: ${jsonEncode(payload)}");

      // Step 3: Send to backend
      final uri = Uri.parse("${ApiConstants.baseUrl}/user/changeOrder");
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(payload),
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("✅ Order updated successfully");
        ToastMessageHelper.successMessageShowToster("Order updated successfully!");
        return true;
      } else {
        // Rollback original orderSeq values
        for (int i = 0; i < wasyyahYouData.length; i++) {
          wasyyahYouData[i].orderSeq = originalOrderSeqs[i];
        }
        wasyyahYouData.refresh();

        print("❌ Order update failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        Get.snackbar("Error", "Failed to update order. Status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Rollback original orderSeq values
      for (int i = 0; i < wasyyahYouData.length; i++) {
        wasyyahYouData[i].orderSeq = originalOrderSeqs[i];
      }
      wasyyahYouData.refresh();

      print("❌ Error updating order: $e");
      Get.snackbar("Error", "Network error occurred");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Simple version without rollback (your original working version)
  Future<void> updateAllOrderSeqHttpSimple() async {
    // Step 1: Update local orderSeqs
    for (int i = 0; i < wasyyahYouData.length; i++) {
      wasyyahYouData[i].orderSeq = i + 1;
    }
    wasyyahYouData.refresh();

    // Step 2: Create payload
    final payload = {
      "data": wasyyahYouData
          .map((e) => {
        "requestKey": e.requestKey,
        "order": e.orderSeq,
      })
          .toList(),
    };

    // Step 3: Send to backend
    final uri = Uri.parse("${ApiConstants.baseUrl}/user/changeOrder");
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print("✅ Order updated successfully");
        ToastMessageHelper.successMessageShowToster("Order updated!");
      } else {
        print("❌ Order update failed: ${response.statusCode}");
        print(response.body);
        ToastMessageHelper.errorMessageShowToster("Failed to update order");
      }
    } catch (e) {
      print("❌ Error updating order: $e");
      ToastMessageHelper.errorMessageShowToster("Network error");
    }
  }

  // Method to call after drag & drop
  Future<void> updateOrderAfterDragDrop() async {
    final success = await updateAllOrderSeqHttp();
    if (!success) {
      // If failed, refresh data from server
      print("🔄 Refreshing data from server due to update failure");
      await getWasyyahData();
    }
  }
}