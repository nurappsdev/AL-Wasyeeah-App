import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/access_phanel/zakat_property_wasyyah_model.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constant.dart';
import '../access_phanel/ContextsService.dart';
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


///==================get Question===========================
RxBool isDelNomineeYou= false.obs;
getWitnessDeleteData({String? requestKey}) async{
  isDelNomineeYou(true);
  var response = await ApiClient.getData("${ApiConstants.witnessDeletePoint}?requestKey=${requestKey}");
  print("deleteData data ------------${response.body}");
  if(response.statusCode == 200 || response.statusCode == 201){

    ToastMessageHelper.successMessageShowToster(
      "REMOVE THIS WITNESS FROM YOUR SIDE SUCCESSFULLY!!",
    );
    getWitnessData();
    isDelNomineeYou(false);
  } else if(response.body == 500){
    ToastMessageHelper.errorMessageShowToster("500 Internal Server Error");
  }else{
    isDelNomineeYou(false);
    ToastMessageHelper.errorMessageShowToster("Try Again");
  }
}





RxBool isZakatPropertyWasiyyah = false.obs;
Rx<ZakatPropertyWasiyyahModel?> contextsData = Rx<ZakatPropertyWasiyyahModel?>(null);

/// 🔥 DIRECT API CALL INSIDE CONTROLLER
Future<void> fetchContextsData(String requestKey) async {
  try {
    isZakatPropertyWasiyyah.value = true;


    var response = await ApiClient.getData("${ApiConstants.baseUrl}/getContextsData?requestKey=$requestKey",);
    print("deleteData data ------------${response.body}");

    if (response.statusCode != 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      contextsData.value = ZakatPropertyWasiyyahModel.fromJson(data);
    } else {
      throw Exception(
          "Request Failed. Status code: ${response.statusCode}");
    }
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isZakatPropertyWasiyyah.value = false;
  }
}










final isLoadings = false.obs;
final hasContextsData = false.obs;

final zakat = <String, dynamic>{}.obs;
final propertyResult = <dynamic>[].obs;
final wasiyyahContent = <dynamic>[].obs;

Future<void> getContextsData(String requestKey) async {
  String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

  try {
    isLoadings.value = true;
    hasContextsData.value = false;

    final uri = Uri.parse(
      '${ApiConstants.baseUrl}/getContextsData?requestKey=$requestKey',
    );

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
    );

    if (response.statusCode == 200) {
      // ✅ UTF-8 decode (Bangla safe)
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = jsonDecode(decodedBody);

      /// 🔴 যদি API empty object দেয়
      if (data.isEmpty) {
        hasContextsData.value = false;
        return;
      }

      // zakat
      zakat.value = data['zakat'] ?? {};

      // propertyResult (string JSON হলে)
      propertyResult.value = data['propertyResult'] != null
          ? jsonDecode(data['propertyResult'])
          : [];

      // wasiyyahContent
      wasiyyahContent.value = data['wasiyyahContent'] ?? [];

      /// ✅ data valid
      hasContextsData.value = true;
    } else {
      /// ❌ requestKey match না করলে
      hasContextsData.value = false;
    }
  } catch (e) {
    hasContextsData.value = false;
  } finally {
    isLoadings.value = false;
  }
}


}