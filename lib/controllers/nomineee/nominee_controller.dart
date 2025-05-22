
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constant.dart';

class NomineeController extends GetxController{


  ///==================get nominee===========================
  RxBool isNominee= false.obs;
  RxList<NomineeResponseModel> nomineeData = <NomineeResponseModel>[].obs;
  getNomineeData() async{
    isNominee(true);
    var response = await ApiClient.getData(ApiConstants.nomineeEndPoint);
    print("nomineeData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      nomineeData.value = List<NomineeResponseModel>.from(response.body.map((x)=> NomineeResponseModel.fromJson(x)));
      isNominee(false);
    }else{
      isNominee(false);
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



}