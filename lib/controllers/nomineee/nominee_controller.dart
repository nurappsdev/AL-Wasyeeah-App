
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constant.dart';

class NomineeController extends GetxController{


  ///==================get nominee===========================
  RxBool isNominee= false.obs;
  RxList<NomineetedResponseModel> nomineeData = <NomineetedResponseModel>[].obs;
  getNomineeData() async{
    isNominee(true);
    var response = await ApiClient.getData(ApiConstants.nomineeEndPoint);
    print("nomineeData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      nomineeData.value = List<NomineetedResponseModel>.from(response.body.map((x)=> NomineetedResponseModel.fromJson(x)));
      isNominee(false);
    }else{
      isNominee(false);
    }
  }



  ///==================get nominee access control===========================
  RxBool isNomineeAccess= false.obs;
  RxList<AccessControllResponseModel> accessControllResponseModel = <AccessControllResponseModel>[].obs;
  getNomineeAccessData({String? nominee1Witness2}) async{
    isNominee(true);
    var response = await ApiClient.getData("${ApiConstants.accessControlEndPoint}${nominee1Witness2}");
    print("nomineeData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      accessControllResponseModel.value = List<AccessControllResponseModel>.from(response.body.map((x)=> AccessControllResponseModel.fromJson(x)));
      isNomineeAccess(false);
    }else{
      isNomineeAccess(false);
    }
  }





  ///==================get access Feature List ===========================
  RxBool isAccessFeature= false.obs;
  RxList<GetAccessFeatureModel> getAccessFeatureModel = <GetAccessFeatureModel>[].obs;
  getAccessFeatureData() async{
    isAccessFeature(true);
    var response = await ApiClient.getData("${ApiConstants.accessFeatureEndPoint}");
    print("feature list data  ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      getAccessFeatureModel.value = List<GetAccessFeatureModel>.from(response.body.map((x)=> GetAccessFeatureModel.fromJson(x)));
      isAccessFeature(false);
    }else{
      isAccessFeature(false);
    }
  }



  ///==================get select Feature List ===========================
  RxBool isSelectFeature= false.obs;
  RxList<SelectFeatureModel> selectFeatureModel = <SelectFeatureModel>[].obs;
  getSelectFeatureData({String? requestKey}) async{
    isAccessFeature(true);
    var response = await ApiClient.getData("${ApiConstants.accessSelectEndPoint}?requestKey=${requestKey}&trace=false");
    print("select list data  ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      selectFeatureModel.value = List<SelectFeatureModel>.from(response.body.map((x)=> SelectFeatureModel.fromJson(x)));
      isAccessFeature(false);
    }else{
      isAccessFeature(false);
    }
  }

  ///==================get Question===========================
  RxBool isNomineeYou= false.obs;
  RxList<NomineetedResponseModel> nomineetedYouData = <NomineetedResponseModel>[].obs;
  getNomineetedData() async{
    isNomineeYou(true);
    var response = await ApiClient.getData(ApiConstants.nomineetedYouPoint);
    print("nomineetedYouData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      nomineetedYouData.value = List<NomineetedResponseModel>.from(response.body.map((x)=> NomineetedResponseModel.fromJson(x)));
      isNomineeYou(false);
    }else{
      isNomineeYou(false);
    }
  }


  final TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;
  var nominessData = {}.obs;

  Future<void> searchNominee() async {
    final email = searchController.text.trim();
    if (email.isEmpty) return;

    isLoading.value = true;

    final url = Uri.parse(
      '${ApiConstants.baseUrl}/user/search-witness-nominee?email=$email&isWitness=false',
    );
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("response.body---------------${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        nominessData.value = data;
      } else {
        Get.snackbar("Error", "This is not right email");
        nominessData.value = {};
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      nominessData.value = {};
    } finally {
      isLoading.value = false;
    }
  }


  ///==================Save nominee Up===========================
  // bool isNomineeTrue = true;
  // RxBool addNomineeLoading = false.obs;
  // Future<void> addNominee({
  //   required String userName,
  //   required String mobileNo,
  //   required String email,
  //   required String relationWithUser,
  //   required String dob,
  //   required String presentAddress,
  //   required String permanentAddress,
  //
  // }) async {
  //   addNomineeLoading(true);
  //   String token = await PrefsHelper.getString(AppConstants.bearerToken);
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',};
  //   var body = {
  //     "name": userName,
  //     "mobile": mobileNo,
  //     "email": email,
  //     "relationWithUser": relationWithUser,
  //     "dob": dob,
  //     "presentAddress": presentAddress,
  //     "permanentAddress": permanentAddress
  //   };
  //   var response = await ApiClient.postData(
  //  isNomineeTrue ? ApiConstants.addNomineePoint: ApiConstants.addWitnessEndPoint,
  //     jsonEncode(body),
  //     headers: headers,
  //   );
  //   print("log in-----------------${response.body}");
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     ToastMessageHelper.successMessageShowToster("Nominee Add Successfully");
  //     Get.toNamed(AppRoutes.addNomineeScreen,preventDuplicates: false);
  //     // Get.off(() => StepNavigationWithPageView(), preventDuplicates: false);
  //     //Get.off(() => HomeScreen(), preventDuplicates: false);
  //     addNomineeLoading(false);
  //
  //   } else {
  //     addNomineeLoading(false);
  //    ToastMessageHelper.errorMessageShowToster('Added failed. Please try again.');
  //
  //   }
  // }

  RxBool addNomineeLoading = false.obs;

  Future<void> addNomineeAndWitness({
    required String userName,
    required String mobileNo,
    required String email,
    required String relationWithUser,
    required String dob,
    required String presentAddress,
    required String permanentAddress,
    bool isNomineeTrue = true,
  }) async {
    addNomineeLoading(true);
    try {
      final token = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        "name": userName,
        "mobile": mobileNo,
        "email": email,
        "relationWithUser": relationWithUser,
        "dob": dob,
        "presentAddress": presentAddress,
        "permanentAddress": permanentAddress,
      });

      final endpoint = isNomineeTrue
          ? ApiConstants.addNomineePoint
          : ApiConstants.addWitnessEndPoint;

      final response = await ApiClient.postData(endpoint, body, headers: headers);

      print("Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.successMessageShowToster(
          isNomineeTrue ? "Nominee Added Successfully" : "Witness Added Successfully",
        );
        isNomineeTrue ? Get.toNamed(AppRoutes.addNomineeScreen, preventDuplicates: false):Get.toNamed(AppRoutes.addWitnessesScreen, preventDuplicates: false);
      } else {
        ToastMessageHelper.errorMessageShowToster('Add failed. Please try again.');
      }
    } catch (e) {
      ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
    } finally {
      addNomineeLoading(false);
    }
  }

}