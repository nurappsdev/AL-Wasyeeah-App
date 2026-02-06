import 'package:get/get.dart';
import '../nomineee/nominee_controller.dart';

class NomineeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NomineeController>(() => NomineeController());
  }
}
