import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
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
  late final ProfileController profileController;

  @override
  onInit() {
    super.onInit();
    log("Home controller onInit is called.");
    profileController = Get.put(ProfileController());
    getsalatTimeHandle();
  }

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
        ApiConstants.salatTimeAPI(lat, long),
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
      remainingTimeStr.value = "--:--:--";
      return;
    }

    final now = DateTime.now();
    currentTime.value =
        DateFormat('hh:mm:ss a', Get.locale!.languageCode).format(now);

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

    // Determine current, previous, next
    for (int i = 0; i < times.length; i++) {
      if (now.isBefore(times[i].value)) {
        upcoming = times[i].key;
        nextTime = times[i].value;
        previous = i > 0 ? times[i - 1].key : "Isha";
        current = i > 0 ? times[i - 1].key : "Isha";
        break;
      }
    }

    // If after Isha (no upcoming today)
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

      final hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      final seconds = diff.inSeconds % 60;

      remainingTimeStr.value =
          "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
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
      return DateFormat("hh:mm a", Get.locale!.languageCode).format(dt);
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
