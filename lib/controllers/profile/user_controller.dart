import 'dart:async';
import 'dart:convert';

import 'package:al_wasyeah/models/profile_info_model/profile_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/app_constant.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class UserController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getsalatTimeHandle();
    getUserProfileData();
  }

  RxBool isLoadingUserProfile = false.obs;
  Rxn<ProfileModel> userProfile = Rxn<ProfileModel>();

  Future<void> getUserProfileData() async {
    isLoadingUserProfile(true);

    try {
      var response = await ApiClient.getData(ApiConstants.getProfile);
      print("UserProfile Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        userProfile(profileModelFromJson(jsonEncode(response.body)));
      }
    } catch (e) {
      print("Error loading user profile: $e");
    } finally {
      isLoadingUserProfile(false);
    }
  }

  RxBool salatTimeLoading = false.obs;
  Rxn<GetSalatTimeResponseModel> getSalatTimeResponseModel =
      Rxn<GetSalatTimeResponseModel>();

  Future<void> getsalatTimeHandle() async {
    salatTimeLoading(true);

    try {
      String lat = await PrefsHelper.getString(AppConstants.latitude);
      String long = await PrefsHelper.getString(AppConstants.longitude);
      var response = await ApiClient.getData(
        ApiConstants.salatTimeAPI(lat, long),
      );
      print("UserProfile Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("long ${long}");
        if (response.body != null) {
          getSalatTimeResponseModel.value =
              GetSalatTimeResponseModel.fromJson(response.body);
        }
        prayerTimes.value = {
          AppLocalizations.of(Get.context!)!.fajr:
              getSalatTimeResponseModel.value?.fajr ?? '',
          AppLocalizations.of(Get.context!)!.sunrise:
              getSalatTimeResponseModel.value?.sunrise ?? '',
          AppLocalizations.of(Get.context!)!.dhuhr:
              getSalatTimeResponseModel.value?.dhuhr ?? '',
          AppLocalizations.of(Get.context!)!.asr:
              getSalatTimeResponseModel.value?.asr ?? '',
          AppLocalizations.of(Get.context!)!.maghrib:
              getSalatTimeResponseModel.value?.maghrib ?? '',
          AppLocalizations.of(Get.context!)!.isha:
              getSalatTimeResponseModel.value?.isha ?? '',
        };

        _calculateNextPrayer();
      }
    } catch (e) {
      print("Error loading user profile: $e");
    } finally {
      salatTimeLoading(false);
    }
  }

  var upcomingPrayer = ''.obs;
  var timeLeft = Rxn<Duration>();
  var prayerTimes = <String, String>{}.obs;

  // void _calculateNextPrayer() {
  //   final now = DateTime.now();
  //   final today = DateFormat('yyyy-MM-dd').format(now);
  //
  //   for (var entry in prayerTimes.entries) {
  //     if (entry.value.isEmpty) continue;
  //
  //     try {
  //       final time = DateTime.parse("$today ${entry.value}:00");
  //       if (time.isAfter(now)) {
  //         timeLeft.value = time.difference(now);
  //         upcomingPrayer.value = entry.key;
  //         return;
  //       }
  //     } catch (_) {}
  //   }
  // }

  void _calculateNextPrayer() {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    final tomorrow =
        DateFormat('yyyy-MM-dd').format(now.add(Duration(days: 1)));

    bool found = false;

    for (var entry in prayerTimes.entries) {
      if (entry.value.isEmpty) continue;

      try {
        final time = DateTime.parse("$today ${entry.value}:00");
        if (time.isAfter(now)) {
          timeLeft.value = time.difference(now);
          upcomingPrayer.value = entry.key;
          found = true;
          return;
        }
      } catch (_) {}
    }

    // If nothing left today, fallback to first prayer tomorrow
    if (!found) {
      for (var entry in prayerTimes.entries) {
        if (entry.value.isEmpty) continue;

        try {
          final time = DateTime.parse("$tomorrow ${entry.value}:00");
          timeLeft.value = time.difference(now);
          upcomingPrayer.value = entry.key;
          return;
        } catch (_) {}
      }
    }
  }

  void startPrayerTimer() {
    Timer.periodic(Duration(seconds: 1), (_) {
      _calculateNextPrayer();
      upcomingPrayer.refresh();
    });
  }

  RxBool forPassLoading = false.obs;
  Future<void> changePass(
      String oldPassword, String newPassword, String confirmPassword) async {
    forPassLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword
    };
    var response = await ApiClient.postData(
        "${ApiConstants.changePassAPI}", body,
        headers: headers);
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.successMessageShowToster(
          response.body['message'].toString());
      forPassLoading(false);
    } else {
      ToastMessageHelper.errorMessageShowToster(
          response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      forPassLoading(false);
    }
  }
}
