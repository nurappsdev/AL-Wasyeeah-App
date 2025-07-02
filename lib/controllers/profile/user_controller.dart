
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/app_constant.dart';

class UserController extends GetxController{
  @override
  onInit(){
    super.onInit();
    getUserProfileData();
    getLocation();
    getsalatTimeHandle();
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


  RxString location = 'Getting location...'.obs;
  RxString longitude = ''.obs;
  RxString latitude = ''.obs;
  void getLocation() async {
    try {
      Position position = await determinePosition();
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
        location.value = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
    } catch (e) {
        location.value = 'Error: ${e.toString()}';
    }
  }


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Get current location
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }



  RxBool salatTimeLoading = false.obs;
  Rxn<GetSalatTimeResponseModel> getSalatTimeResponseModel = Rxn<GetSalatTimeResponseModel>();

  Future<void> getsalatTimeHandle() async {
    salatTimeLoading(true);

    try {
      var response = await ApiClient.getData(ApiConstants.salatTimeAPI(longitude.value, latitude.value),);
      print("UserProfile Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body != null) {
          getSalatTimeResponseModel.value = GetSalatTimeResponseModel.fromJson(response.body);
        }
      }
    } catch (e) {
      print("Error loading user profile: $e");
    } finally {
      salatTimeLoading(false);
    }
  }

}