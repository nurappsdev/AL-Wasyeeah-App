
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../services/services.dart';

class UserController extends GetxController{
  @override
  onInit(){
    super.onInit();
  getUserProfileData();

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
}