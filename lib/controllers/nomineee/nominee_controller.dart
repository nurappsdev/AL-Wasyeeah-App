
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../services/services.dart';

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

}