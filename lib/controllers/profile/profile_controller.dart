
import 'package:get/get.dart';

class ProfileController extends GetxController{


///+========================1st Profile=====================
  RxString selectedGender = ''.obs;
  RxString selectedMarried = ''.obs;
  RxString selectedProfession = ''.obs;

  final List<String> gender = ['Male'.tr, 'FeMale'.tr, 'Others'.tr];
  final List<String> maritalStatus = ['Married'.tr, 'Un Married'.tr,];
  final List<String> profession = ['Business'.tr, 'Doctor'.tr, "Engineers".tr, "Others".tr];
}