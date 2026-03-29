import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:al_wasyeah/models/menus/user_menus_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/app_constant.dart';

class HomeController extends GetxController {
  final Rx<RxStatus> salatTimeStatus = RxStatus.loading().obs;
  final Rx<RxStatus> getMenusStatus = RxStatus.loading().obs;

  // Scroller for prayer times
  late ScrollController scrollController;
  Worker? _prayerWorker;

  @override
  onInit() {
    super.onInit();

    scrollController = ScrollController();

    // Watch for current prayer changes to auto-scroll
    _prayerWorker = ever(currentPrayer, (_) {
      scrollToCurrentPrayer();
    });

    getsalatTimeHandle();
    getMenus();
  }

  void scrollToCurrentPrayer() {
    if (!scrollController.hasClients) return;
    if (prayerTimes.isEmpty) return;

    final prayerList = prayerTimes.keys.toList();
    final index = prayerList.indexOf(currentPrayer.value);

    if (index == -1) return;

    // Exact width calculation based on 0.6.sw + 32.w (margin 16.w * 2)
    final double itemWidth = (0.6.sw) + (32.w);
    final double offset = index * itemWidth;

    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  RxList<UserMenus> userMenus = <UserMenus>[].obs;
  Rxn<SalatTimeResponseModel?> salatTimeModel =
      Rxn<SalatTimeResponseModel?>(null);

  RxMap<String, String> prayerTimes = <String, String>{}.obs;
  RxString upcomingPrayer = "".obs;
  RxString currentPrayer = "".obs;
  RxString previousPrayer = "".obs;
  RxString currentTime = "".obs;
  Rx<Duration?> timeLeft = Rx<Duration?>(null);
  RxString remainingTimeStr = "".obs;
  Timer? _prayerTimer;

  @override
  void onClose() {
    _prayerTimer?.cancel();
    _prayerWorker?.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      // 1. Check service
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
        return null; // let UI decide what to do
      }

      // 2. Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return null;
      }

      // 3. Get location
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> getMenus() async {
    getMenusStatus(RxStatus.loading());

    try {
      var response = await ApiClient.getData(
        ApiConstants.getMenus,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = userMenusFromJson(json.encode(response.body));
        if (data.isNotEmpty) {
          userMenus(data);
          getMenusStatus(RxStatus.success());
        } else {
          getMenusStatus(RxStatus.empty());
        }
      } else {
        getMenusStatus(RxStatus.error(response.body));
      }
    } catch (e, s) {
      log("Error is : ${e}");
      log("Stack trace is : ${s}");
      getMenusStatus(RxStatus.error(e.toString()));
    }
  }

  Future<void> getsalatTimeHandle() async {
    salatTimeStatus(RxStatus.loading());

    try {
      final position = await _getCurrentLocation();
      if (position == null) {
        // show dialog asking user to enable location
        return;
      }

      final String lat = position.latitude.toString();
      final String long = position.longitude.toString();
      var response = await ApiClient.getData(
        ApiConstants.salatTimeEndPoint(lat, long),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body != null) {
          final model =
              salatTimeResponseModelFromJson(json.encode(response.body));
          salatTimeModel(model);

          prayerTimes.value = {
            'Fajr': model.fajr ?? '',
            'Dhuhr': model.dhuhr ?? '',
            'Asr': model.asr ?? '',
            'Maghrib': model.maghrib ?? '',
            'Isha': model.isha ?? '',
          };

          startPrayerTimer();
          salatTimeStatus(RxStatus.success());
          Future.delayed(const Duration(milliseconds: 300), () {
            update(); // optional if needed
          });
        }
      }
    } catch (e, s) {
      log("Error is : ${e}");
      log("Stack trace is : ${s}");
      salatTimeStatus(RxStatus.error(e.toString()));
    }
  }

  void startPrayerTimer() {
    _prayerTimer?.cancel();
    _updatePrayerStatus();
    _prayerTimer =
        Timer.periodic(Duration(seconds: 1), (_) => _updatePrayerStatus());
  }

  void _updatePrayerStatus() {
    if (prayerTimes.isEmpty) {
      final now = DateTime.now();
      currentTime.value =
          DateFormat('hh:mm:ss a', Get.locale!.languageCode).format(now);
      if (Get.locale!.languageCode == 'bn') {
        currentTime.value = currentTime.value
            .replaceAll('AM', 'পূর্বাহ্ন')
            .replaceAll('PM', 'অপরাহ্ন');
      }
      remainingTimeStr.value = "--:--:--";
      return;
    }

    final now = DateTime.now();
    currentTime.value =
        DateFormat('hh:mm:ss a', Get.locale!.languageCode).format(now);
    if (Get.locale!.languageCode == 'bn') {
      currentTime.value = currentTime.value
          .replaceAll('AM', 'পূর্বাহ্ন')
          .replaceAll('PM', 'অপরাহ্ন');
    }

    List<MapEntry<String, DateTime>> times = [];

    for (var entry in prayerTimes.entries) {
      if (entry.value.isNotEmpty) {
        try {
          final dt24 = DateFormat("HH:mm").parse(entry.value);
          final dt = DateTime(
            now.year,
            now.month,
            now.day,
            dt24.hour,
            dt24.minute,
          );
          times.add(MapEntry(entry.key, dt));
        } catch (e) {
          // ignore parsing error
        }
      }
    }

    if (times.isEmpty) return;

    times.sort((a, b) => a.value.compareTo(b.value));

    String? current;
    String? upcoming;
    String? previous;
    DateTime? nextTime;

    for (int i = 0; i < times.length; i++) {
      if (now.isBefore(times[i].value)) {
        upcoming = times[i].key;
        nextTime = times[i].value;
        previous = i > 0 ? times[i - 1].key : "Isha";
        current = i > 0 ? times[i - 1].key : "Isha";
        break;
      }
    }

    if (upcoming == null) {
      current = "Isha";
      previous = "Maghrib";
      upcoming = "Fajr";
      final tomorrow = now.add(Duration(days: 1));
      nextTime = DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        int.parse(prayerTimes["Fajr"]!.split(":")[0]),
        int.parse(prayerTimes["Fajr"]!.split(":")[1]),
      );
    }

    currentPrayer.value = current!;
    previousPrayer.value = previous!;
    upcomingPrayer.value = upcoming;

    if (nextTime != null) {
      final diff = nextTime.difference(now);
      timeLeft.value = diff;

      // Convert Duration to DateTime for formatting
      final baseDate = DateTime(0).add(diff); // base reference
      var formattedRemaining =
          DateFormat('hh:mm:ss a', Get.locale!.languageCode).format(baseDate);

      if (Get.locale!.languageCode == 'bn') {
        formattedRemaining = formattedRemaining
            .replaceAll('AM', 'পূর্বাহ্ন')
            .replaceAll('PM', 'অপরাহ্ন');
      }

      remainingTimeStr.value = formattedRemaining;
    } else {
      remainingTimeStr.value = "--:--:--";
    }
  }

  String formatTime(String time24) {
    if (time24.isEmpty) return "";
    try {
      final dt = DateFormat(
        "HH:mm",
      ).parse(time24);
      var formattedTime =
          DateFormat("hh:mm a", Get.locale!.languageCode).format(dt);
      if (Get.locale!.languageCode == 'bn') {
        formattedTime = formattedTime
            .replaceAll('AM', 'পূর্বাহ্ন')
            .replaceAll('PM', 'অপরাহ্ন');
      }
      return formattedTime;
    } catch (e) {
      return time24;
    }
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
