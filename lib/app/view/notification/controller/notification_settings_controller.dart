import 'package:get/get.dart';
import 'package:wasiyyat/app/core/services/shared_pref/prefs_service.dart';

class NotificationSettingsController extends GetxController {
  static const String _prefKeyGeneralNotification = 'general_notifications_enabled';

  final RxBool isGeneralNotificationEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await PrefsHelper.getBool(_prefKeyGeneralNotification);
    isGeneralNotificationEnabled.value = enabled;
  }

  Future<void> toggleGeneralNotification(bool value) async {
    isGeneralNotificationEnabled.value = value;
    await PrefsHelper.setBool(_prefKeyGeneralNotification, value);
  }
}
