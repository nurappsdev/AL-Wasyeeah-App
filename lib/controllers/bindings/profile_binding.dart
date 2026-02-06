import 'package:get/get.dart';
import '../profile/profile_controller.dart';
import '../profile/user_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
