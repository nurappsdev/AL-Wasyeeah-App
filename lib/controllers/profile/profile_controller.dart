
import 'package:get/get.dart';

class ProfileController extends GetxController{


///+========================1st Profile=====================
  RxString selectedGender = ''.obs;
  RxString selectedMarried = ''.obs;
  RxString selectedProfession = ''.obs;
  RxString selectedNationality = ''.obs;
  RxString selectedBank = ''.obs;

  final List<String> gender = ['Male'.tr, 'FeMale'.tr, 'Others'.tr];
  final List<String> maritalStatus = ['Married'.tr, 'Un Married'.tr,];
  final List<String> profession = ['Business'.tr, 'Doctor'.tr, "Engineers".tr,"Housewife".tr, "Others".tr];
  final List<String> nationality = ['Bangaldeshi'.tr, 'Pakisthani'.tr, "Indian".tr,];


  final List<String> banks = ['Islami Bank'.tr, 'Al Arafa Bank'.tr,'Sonali Bank'.tr,];

  final List<Map<String, String>> muslimCountriesInWorld = [
    {'name': 'Palestine', 'flag': 'PS'}, // Palestine
    {'name': 'Lebanon', 'flag': 'LB'}, // Lebanon
    {'name': 'Jordan', 'flag': 'JO'}, // Jordan
    {'name': 'Syria', 'flag': 'SY'}, // Syria
    {'name': 'Saudi Arabia', 'flag': 'SA'}, // Saudi Arabia
    {'name': 'United Arab Emirates', 'flag': 'AE'}, // UAE
    {'name': 'Oman', 'flag': 'OM'}, // Oman
    {'name': 'Qatar', 'flag': 'QA'}, // Qatar
    {'name': 'Bahrain', 'flag': 'BH'}, // Bahrain
    {'name': 'Kuwait', 'flag': 'KW'}, // Kuwait
    {'name': 'Iraq', 'flag': 'IQ'}, // Iraq
    {'name': 'Turkey', 'flag': 'TR'}, // Turkey
    {'name': 'Afghanistan', 'flag': 'AF'}, // Afghanistan
    {'name': 'Pakistan', 'flag': 'PK'}, // Pakistan
    {'name': 'Indonesia', 'flag': 'ID'}, // Indonesia
    {'name': 'Malaysia', 'flag': 'MY'}, // Malaysia
    {'name': 'Brunei', 'flag': 'BN'}, // Brunei
    {'name': 'Kazakhstan', 'flag': 'KZ'}, // Kazakhstan
    {'name': 'Turkmenistan', 'flag': 'TM'}, // Turkmenistan
    {'name': 'Uzbekistan', 'flag': 'UZ'}, // Uzbekistan
    {'name': 'Kyrgyzstan', 'flag': 'KG'}, // Kyrgyzstan
    {'name': 'Tajikistan', 'flag': 'TJ'}, // Tajikistan
    {'name': 'Maldives', 'flag': 'MV'}, // Maldives
    {'name': 'Algeria', 'flag': 'DZ'}, // Algeria
    {'name': 'Egypt', 'flag': 'EG'}, // Egypt
    {'name': 'Morocco', 'flag': 'MA'}, // Morocco
    {'name': 'Tunisia', 'flag': 'TN'}, // Tunisia
    {'name': 'Libya', 'flag': 'LY'}, // Libya
    {'name': 'Sudan', 'flag': 'SD'}, // Sudan
    {'name': 'Somalia', 'flag': 'SO'}, // Somalia
    {'name': 'Nigeria', 'flag': 'NG'}, // Nigeria
    {'name': 'Senegal', 'flag': 'SN'}, // Senegal
    {'name': 'Mali', 'flag': 'ML'}, // Mali
    {'name': 'Chad', 'flag': 'TD'}, // Chad
    {'name': 'Mauritania', 'flag': 'MR'}, // Mauritania
    {'name': 'Gambia', 'flag': 'GM'}, // Gambia
    {'name': 'Comoros', 'flag': 'KM'}, // Comoros
    {'name': 'Sierra Leone', 'flag': 'SL'}, // Sierra Leone
    {'name': 'Guinea', 'flag': 'GN'}, // Guinea
    {'name': 'Indonesia', 'flag': 'ID'}, // Indonesia
    {'name': 'Bangladesh', 'flag': 'BD'}, // Bangladesh
    {'name': 'India', 'flag': 'IN'}, // India (significant Muslim population)
    {'name': 'Russia', 'flag': 'RU'}, // Russia (significant Muslim population)
    {'name': 'Philippines', 'flag': 'PH'}, // Philippines (significant Muslim population)
  ];
  String selectedCountry = 'Bangladesh';
}