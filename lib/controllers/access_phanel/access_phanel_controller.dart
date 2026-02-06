
import 'package:get/get.dart';

import '../../models/access_phanel/zakat_property_wasyyah_model.dart';
import 'ContextsService.dart';

class AccessPhanelController extends GetxController {
  final ContextsService _service = ContextsService();

  RxBool isLoading = false.obs;
  Rx<ZakatPropertyWasiyyahModel?> contextsData = Rx<ZakatPropertyWasiyyahModel?>(null);

  Future<void> fetchContextsData(String requestKey) async {
    try {
      isLoading.value = true;
      final result = await _service.getContextsData(requestKey);
      contextsData.value = result;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

