
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../services/services.dart';

class WasyyahController extends GetxController{

  onInit(){
    super.onInit();
  getWasyyahData();

  }
  ///==================get nominee===========================
  RxBool isWasyyah= false.obs;
  RxList<GetWasyyahResponseModel> wasyyahYouData = <GetWasyyahResponseModel>[].obs;
  getWasyyahData() async{
    isWasyyah(true);
    var response = await ApiClient.getData(ApiConstants.wasyyahYouDataYouEndPoint);
    print("witnessesYouData data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      wasyyahYouData.value = List<GetWasyyahResponseModel>.from(response.body.map((x)=> GetWasyyahResponseModel.fromJson(x)));
      isWasyyah(false);
    }else{
      isWasyyah(false);
    }
  }



}