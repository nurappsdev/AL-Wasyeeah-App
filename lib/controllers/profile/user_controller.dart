
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/app_constant.dart';

class UserController extends GetxController{
  @override
  onInit(){
    super.onInit();
    getsalatTimeHandle();
    getUserProfileData();
  }
  RxBool isLoadingUserProfile = false.obs;
  Rxn<GetUserResponseModel> userProfile = Rxn<GetUserResponseModel>();

  Future<void> getUserProfileData() async {
    isLoadingUserProfile(true);

    try {
      var response = await ApiClient.getData(ApiConstants.userProfileEndPoint);
      print("UserProfile Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body['userProfile'] != null) {
          userProfile.value = GetUserResponseModel.fromJson(response.body['userProfile']);
        }
      }
    } catch (e) {
      print("Error loading user profile: $e");
    } finally {
      isLoadingUserProfile(false);
    }
  }



  RxBool salatTimeLoading = false.obs;
  Rxn<GetSalatTimeResponseModel> getSalatTimeResponseModel = Rxn<GetSalatTimeResponseModel>();

  Future<void> getsalatTimeHandle() async {
    salatTimeLoading(true);

    try {

     String lat = await PrefsHelper.getString(AppConstants.latitude);
     String long = await PrefsHelper.getString(AppConstants.longitude);
      var response = await ApiClient.getData(ApiConstants.salatTimeAPI(lat, long),);
      print("UserProfile Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("long ${long}");
        if (response.body != null) {
          getSalatTimeResponseModel.value = GetSalatTimeResponseModel.fromJson(response.body);
        }
        prayerTimes.value = {
          'Fajr': getSalatTimeResponseModel.value?.fajr ?? '',
          'Sunrise': getSalatTimeResponseModel.value?.sunrise ?? '',
          'Dhuhr': getSalatTimeResponseModel.value?.dhuhr ?? '',
          'Asr': getSalatTimeResponseModel.value?.asr ?? '',
          'Maghrib': getSalatTimeResponseModel.value?.maghrib ?? '',
          'Isha': getSalatTimeResponseModel.value?.isha ?? '',
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
    final tomorrow = DateFormat('yyyy-MM-dd').format(now.add(Duration(days: 1)));

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




}