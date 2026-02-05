import 'package:al_wasyeah/services/translation/strings/bn_string.dart';
import 'package:al_wasyeah/services/translation/strings/en_string.dart';
import 'package:get/get.dart';


class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enString,
        'bn_BD': bnString,
      };
}