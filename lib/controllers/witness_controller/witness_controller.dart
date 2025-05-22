import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constant.dart';
class WitnessController extends GetxController{

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.clear();
  }
  ///==================get Witness===========================
  RxBool isWitness= false.obs;
  RxList<GetWitnessResponseModel> witnessData = <GetWitnessResponseModel>[].obs;
  getWitnessData() async{
    isWitness(true);
    var response = await ApiClient.getData(ApiConstants.witnessEndPoint);
    print("nomineeData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      witnessData.value = List<GetWitnessResponseModel>.from(response.body.map((x)=> GetWitnessResponseModel.fromJson(x)));
      isWitness(false);
    }else{
      isWitness(false);
    }
  }


  ///==================get nominee===========================
  RxBool isWitnessesYou= false.obs;
  RxList<GetWitnessResponseModel> witnessesYouData = <GetWitnessResponseModel>[].obs;
  getWitnessesYouData() async{
    isWitnessesYou(true);
    var response = await ApiClient.getData(ApiConstants.witnessesYouEndPoint);
    print("witnessesYouData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      witnessesYouData.value = List<GetWitnessResponseModel>.from(response.body.map((x)=> GetWitnessResponseModel.fromJson(x)));
      isWitnessesYou(false);
    }else{
      isWitnessesYou(false);
    }
  }


  final TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  var witnesssData = {}.obs;

  Future<void> searchWitness() async {
    final email = searchController.text.trim();
    if (email.isEmpty) return;

    isLoading.value = true;

    final url = Uri.parse(
      '${ApiConstants.baseUrl}/user/search-witness-nominee?email=$email&isWitness=true',
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
        witnesssData.value = data;
      } else {
        Get.snackbar("Error", "This is not right email");
        witnesssData.value = {};
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      witnesssData.value = {};
    } finally {
      isLoading.value = false;
    }
  }

}