import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:al_wasyeah/app/view/menu/model/user_menus_model.dart';
import 'package:al_wasyeah/app/view/home/model/prayer_model.dart';
import 'package:al_wasyeah/app/view/home/model/salat_time_response_model.dart';
import 'package:al_wasyeah/app/core/services/api/api_service.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/services/shared_pref/prefs_service.dart';
import '../../../core/utils/app_constant.dart';

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
    if (prayerTimes.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      final prayerList = prayerTimes.keys.toList();
      final index = prayerList.indexOf(currentPrayer.value);

      if (index == -1) return;

      final double itemWidth = (0.6.sw) + (32.w); // card + margin
      final double offset = index * itemWidth;

      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    });
  }

  RxList<UserMenus> userMenus = <UserMenus>[].obs;
  Rxn<SalatTimeResponseModel?> salatTimeModel = Rxn<SalatTimeResponseModel?>(null);

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
      var response = await ApiService.getData(
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
      var response = await ApiService.getData(
        ApiConstants.salatTimeEndPoint(lat, long),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body != null) {
          final model = salatTimeResponseModelFromJson(json.encode(response.body));
          salatTimeModel(model);
          log("Prayer time data is : ${model.toJson()}");
          prayerTimes.value = {
            'Fajr': model.fajr ?? '',
            // "Sunrise": model.sunrise ?? '',
            'Dhuhr': model.dhuhr ?? '',
            'Asr': model.asr ?? '',
            'Maghrib': model.maghrib ?? '',
            'Isha': model.isha ?? '',
            // "Sunset": model.sunset ?? '',
          };

          startPrayerTimer();
          salatTimeStatus(RxStatus.success());
          scrollToCurrentPrayer();
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
    _prayerTimer = Timer.periodic(Duration(seconds: 1), (_) => _updatePrayerStatus());
  }

  void _updatePrayerStatus() {
    if (salatTimeModel.value == null) {
      final now = DateTime.now();
      currentTime.value = DateFormat('hh:mm:ss a', Get.locale!.languageCode).format(now);
      if (Get.locale!.languageCode == 'bn') {
        currentTime.value = currentTime.value.replaceAll('AM', 'পূর্বাহ্ন').replaceAll('PM', 'অপরাহ্ন');
      }
      remainingTimeStr.value = "--:--:--";
      return;
    }

    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm:ss a', Get.locale!.languageCode).format(now);
    if (Get.locale!.languageCode == 'bn') {
      currentTime.value = currentTime.value.replaceAll('AM', 'পূর্বাহ্ন').replaceAll('PM', 'অপরাহ্ন');
    }

    final model = salatTimeModel.value!;

    DateTime parseTime(String time, DateTime date) {
      final parts = time.split(':');
      return DateTime(date.year, date.month, date.day, int.parse(parts[0]), int.parse(parts[1]));
    }

    final today = now;
    final tomorrow = now.add(const Duration(days: 1));

    // Build the list of prayers as per user's pseudo logic example
    List<Prayer> prayers = [
      Prayer(
        name: 'Fajr',
        startTime: parseTime(model.fajr!, today),
        endTime: parseTime(model.sunrise!, today),
      ),
      Prayer(
        name: 'Dhuhr',
        startTime: parseTime(model.dhuhr!, today),
        endTime: parseTime(model.asr!, today),
      ),
      Prayer(
        name: 'Asr',
        startTime: parseTime(model.asr!, today),
        endTime: parseTime(model.maghrib!, today),
      ),
      Prayer(
        name: 'Maghrib',
        startTime: parseTime(model.maghrib!, today),
        endTime: parseTime(model.isha!, today),
      ),
      Prayer(
        name: 'Isha',
        startTime: parseTime(model.isha!, today),
        endTime: parseTime(model.fajr!, tomorrow),
      ),
    ];

    Prayer? current;
    Prayer? previous;
    Prayer? upcoming;

    final ishaStartTime = parseTime(model.isha!, today);
    final fajrStartTime = parseTime(model.fajr!, today);

    // Important Edge Case (Isha)
    // if now >= Isha OR now < Fajr current = Isha
    if (now.isAfter(ishaStartTime) || now.isAtSameMomentAs(ishaStartTime) || now.isBefore(fajrStartTime)) {
      current = prayers.last; // Isha
      previous = prayers[prayers.length - 2]; // Maghrib
      upcoming = prayers[0]; // Fajr
    } else {
      for (int i = 0; i < prayers.length; i++) {
        if ((now.isAfter(prayers[i].startTime) || now.isAtSameMomentAs(prayers[i].startTime)) && now.isBefore(prayers[i].endTime)) {
          current = prayers[i];
          previous = i > 0 ? prayers[i - 1] : prayers.last;
          upcoming = i < prayers.length - 1 ? prayers[i + 1] : prayers[0];
          break;
        }
      }
    }

    if (current == null) {
      // means you're between prayers
      for (int i = 0; i < prayers.length; i++) {
        if (now.isBefore(prayers[i].startTime)) {
          upcoming = prayers[i];
          previous = i > 0 ? prayers[i - 1] : prayers.last;
          current = null;
          break;
        }
      }
    }

    currentPrayer.value = current?.name ?? "";
    previousPrayer.value = previous?.name ?? "";
    upcomingPrayer.value = upcoming?.name ?? "";

    if (upcoming != null) {
      DateTime nextTime = upcoming.startTime;
      if (upcoming.name == 'Fajr' && now.isAfter(ishaStartTime)) {
        nextTime = parseTime(model.fajr!, tomorrow);
      } else if (upcoming.name == 'Fajr' && now.isBefore(fajrStartTime)) {
        nextTime = fajrStartTime;
      }

      final diff = nextTime.difference(now);
      timeLeft.value = diff;

      // Format remaining time as HH:mm:ss
      String h = diff.inHours.toString().padLeft(2, '0');
      String m = (diff.inMinutes % 60).toString().padLeft(2, '0');
      String s = (diff.inSeconds % 60).toString().padLeft(2, '0');
      remainingTimeStr.value = "$h:$m:$s";
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
      var formattedTime = DateFormat("hh:mm a", Get.locale!.languageCode).format(dt);
      if (Get.locale!.languageCode == 'bn') {
        formattedTime = formattedTime.replaceAll('AM', 'পূর্বাহ্ন').replaceAll('PM', 'অপরাহ্ন');
      }
      return formattedTime;
    } catch (e) {
      return time24;
    }
  }

  RxBool forPassLoading = false.obs;
  Future<void> changePass(String oldPassword, String newPassword, String confirmPassword) async {
    forPassLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $bearerToken'};
    var body = {"oldPassword": oldPassword, "newPassword": newPassword, "confirmPassword": confirmPassword};
    var response = await ApiService.postData("${ApiConstants.changePassAPI}", body, headers: headers);
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessage.successMessageShowToster(response.body['message'].toString());
      forPassLoading(false);
    } else {
      ToastMessage.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      forPassLoading(false);
    }
  }
}
