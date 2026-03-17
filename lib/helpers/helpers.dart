import 'package:get/get.dart';
import 'package:intl/intl.dart';
export 'toast_message_helper.dart';
export 'app_routes.dart';

extension NumberLocalization on dynamic {
  dynamic toLocal() {
    if (this == null) return '';

    final locale = Get.locale?.languageCode ?? 'en';

    final formatted = NumberFormat.decimalPattern(locale).format(this);

    return formatted;
  }
}
