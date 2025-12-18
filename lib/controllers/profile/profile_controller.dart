import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';

import 'package:al_wasyeah/models/profile_info_model/bank_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profile_model.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_list_model.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';
import 'package:al_wasyeah/utils/download_util.dart'; // Import DownloadUtil explicitly if not in utils.dart
import '../../view/screen/screen.dart';

class ProfileController extends GetxController {
  ///+========================1st Profile=====================

  Rx<RxStatus> status = RxStatus.loading().obs;
  Rxn<MaritalModel> selectedMarried = Rxn();
  Rxn<ProfessionModel> selectedProfession = Rxn();
  Rxn<CountryModel> selectedCountry = Rxn();
  Rxn<GenderModel> selectedGender = Rxn();
  Rxn<BankModel> selectedBank = Rxn();
  Rxn<WealthModel> selectedWealth = Rxn();

  RxList<MaritalModel> maritalList = <MaritalModel>[].obs;
  RxList<ProfessionModel> professionList = <ProfessionModel>[].obs;
  RxList<GenderModel> genderList = <GenderModel>[].obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  RxList<BankModel> bankList = <BankModel>[].obs;
  RxList<WealthModel> wealthList = <WealthModel>[].obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> districtController = TextEditingController().obs;
  Rx<TextEditingController> nidController = TextEditingController().obs;
  Rx<TextEditingController> passportController = TextEditingController().obs;

  RxBool isDownloadingNid = false.obs;
  RxDouble nidDownloadProgress = 0.0.obs;

  Future<void> downloadNidFile() async {
    log(profileModel.value.userProfile?.nidPaperUrl ?? '');
    if (profileModel.value.userProfile?.nidPaperUrl == null) {
      return;
    }
    isDownloadingNid(true);
    nidDownloadProgress(0.0);

    final String fileName =
        'NID_${profileModel.value.userProfile?.firstName ?? "User"}_${profileModel.value.userProfile?.lastName ?? ""}_${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';

    DownloadUtil().downloadFile(
      //'${ApiConstants.imageUrl}${profileModel.value.userProfile?.nidFile}',
      'https://research.nhm.org/pdfs/10840/10840-002.pdf',
      fileName,
      (progress) {
        nidDownloadProgress(progress);
        if (progress >= 100) {
          isDownloadingNid(false);
        }
      },
    ).catchError((e) {
      isDownloadingNid(false);
      print('Download failed: $e');
    });
  }

  final List<String> nationality = [
    'Bangaldeshi'.tr,
    'Pakisthani'.tr,
    "Indian".tr,
  ];

  final List<String> banks = [
    'Islami Bank'.tr,
    'Al Arafa Bank'.tr,
    'Sonali Bank'.tr,
  ];

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
    {
      'name': 'Philippines',
      'flag': 'PH'
    }, // Philippines (significant Muslim population)
  ];

  List<SpouseItemS> addSpouseList = [];
  List<ChildrenInfo> addChildrenInfoList = [];

  Future<void> submitUserProfile({
    // User Profile
    required int userProfileId,
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
    required int nid,
    String? nidPaperPath,
    required String passportNo,
    String? passportPaperPath,
    required String passportExpDate,
    required int maritalStatusId,
    required int professionId,
    required int countryCode,
    int? multipleCitizenCode,
    int? multipleCitizenPassportNo,
    String? tin,
    String? tinPaperPath,
    required String nationality,
    required String mobile,
    required String gender,
    required String religion,
    required String district,
    required String presentAddress,
    required String permanentAddress,
    String? profilePicturePath,
    int? overseasCountryCode,
    String? overseasVillage,
    String? signInSource,
    String? isActive,
    int userTypeId = 0,
    int insertBy = 0,
    String? insertAt,
    int updateBy = 0,

    // Parent Info
    required String fatherName,
    required int fatherProfessionId,
    required int fatherNationalityId,
    required String fatherNID,
    String? fatherNIDPath,
    required String fatherWhatsAppNumber,
    required bool fatherExisting,
    required String motherName,
    required int motherProfessionId,
    required int motherNationalityId,
    required String motherNID,
    String? motherNIDPath,
    required String motherWhatsAppNumber,
    required bool motherExisting,

    // Social Media
    String? facebookLink,
    String? linkDinLink,
    String? instagramLink,
    String? whatsAppLink,

    // Spouse Info (list)
    required List<SpouseItem> spouses,
    // Child Info
    required List<ChildItem> children,
    // Sibling Info
    required List<SiblingItem> siblings,
    // Bank Info
    required List<BankInfoItem> banks,
    // Wealth Info
    required List<WealthItem> wealths,
    // Share Market Info
    required List<ShareMarketItem> shares,
    // Receivable Info
    required List<ReceivableItem> receivables,
    // Payable Info
    required List<PayableItem> payables,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/user/profile/upload');

    // Helper to map file path to url string
    String fileUrl(String? path) => path != null && path.isNotEmpty
        ? "/images/${File(path).path.split('/').last}"
        : "";

    Map<String, dynamic> body = {
      "userProfile": {
        "userProfileId": userProfileId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "dob": dob,
        "nid": nid,
        "nidPaperUrl": fileUrl(nidPaperPath),
        "passportNo": passportNo,
        "passportPaperUrl": fileUrl(passportPaperPath),
        "passportExpDate": passportExpDate,
        "maritalStatusId": maritalStatusId,
        "professionId": professionId,
        "countryCode": countryCode,
        "multipleCitizenCode": multipleCitizenCode,
        "multipleCitizenPassportNo": multipleCitizenPassportNo,
        "tin": tin ?? "",
        "tinPaperUrl": fileUrl(tinPaperPath),
        "nationality": nationality,
        "mobile": mobile,
        "gender": gender,
        "religion": religion,
        "district": district,
        "presentAddress": presentAddress,
        "permanentAddress": permanentAddress,
        "profilePictureUrl": fileUrl(profilePicturePath),
        "overseasCountryCode": overseasCountryCode,
        "overseasVillage": overseasVillage,
        "signInSource": signInSource,
        "isActive": isActive,
        "userTypeId": userTypeId,
        "insertBy": insertBy,
        "insertAt": insertAt,
        "updateBy": updateBy,
      },
      "socialMediaLink": {
        "facebookLink": facebookLink ?? "",
        "linkDinLink": linkDinLink ?? "",
        "instagramLink": instagramLink ?? "",
        "whatsAppLink": whatsAppLink ?? "",
      },
      "parentInfo": {
        "fatherName": fatherName,
        "fatherProfessionId": fatherProfessionId,
        "fatherNationalityId": fatherNationalityId,
        "fatherNID": fatherNID,
        "fatherNIDUrl": fileUrl(fatherNIDPath),
        "fatherWhatsAppNumber": fatherWhatsAppNumber,
        "fatherExisting": fatherExisting,
        "motherName": motherName,
        "motherProfessionId": motherProfessionId,
        "motherNationalityId": motherNationalityId,
        "motherNID": motherNID,
        "motherNIDUrl": fileUrl(motherNIDPath),
        "motherWhatsAppNumber": motherWhatsAppNumber,
        "motherExisting": motherExisting,
      },
      "spouseInfo": spouses
          .map((s) => {
                "spouseId": s.spouseId,
                "spouseName": s.spouseName,
                "professionId": s.professionId,
                "nationalityId": s.nationalityId,
                "nid": s.nid,
                "nidPaperUrl": fileUrl(s.nidPaperPath),
                "passport": s.passport,
                "passportPaperUrl": fileUrl(s.passportPaperPath),
                "mobile": s.mobile,
                "email": s.email,
                "existing": s.existing,
                "userId": s.userId,
              })
          .toList(),

      "childInfo": children
          .map((c) => {
                "childId": c.childId,
                "childName": c.childName,
                "genderId": c.genderId,
                "professionId": c.professionId,
                "nationalityId": c.nationalityId,
                "dob": c.dob,
                "nid": c.nid,
                "nidPaperUrl": fileUrl(c.nidPaperPath),
                "mobile": c.mobile,
                "email": c.email,
                "existing": c.existing,
                "userId": c.userId,
              })
          .toList(),

      "siblingInfo": siblings
          .map((s) => {
                "siblingId": s.siblingId,
                "siblingName": s.siblingName,
                "genderId": s.genderId,
                "professionId": s.professionId,
                "nationalityId": s.nationalityId,
                "nid": s.nid,
                "dob": s.dob,
                "existing": s.existing,
                "nidPaperUrl": fileUrl(s.nidPaperPath),
                "whatsAppNumber": s.whatsAppNumber,
                "email": s.email,
                "mobile": s.mobile,
                "socialMediaLink": s.socialMediaLink,
                "userId": s.userId,
              })
          .toList(),

      "bankInfo": banks
          .map((b) => {
                "userBankInfoId": b.userBankInfoId,
                "userId": b.userId,
                "bankId": b.bankId,
                "branchId": b.branchId,
                "bankAccNo": b.bankAccNo,
                "accBalance": b.accBalance,
              })
          .toList(),

      "wealthInfo": wealths
          .map((w) => {
                "userId": w.userId,
                "wealthId": w.wealthId,
                "documentTypeId": w.documentTypeId,
                "documentPaperUrl": fileUrl(w.documentPaperPath),
                "amount": w.amount,
                "location": w.location,
                "note": w.note,
              })
          .toList(),

      "shareMarketInfo": shares
          .map((s) => {
                "userShareMarketId": s.userShareMarketId,
                "userId": s.userId,
                "brokerHouseName": s.brokerHouseName,
                "accName": s.accName,
                "accNumber": s.accNumber,
                "shareCompanyName": s.shareCompanyName,
                "shareQuality": s.shareQuality,
                "buyingAmount": s.buyingAmount,
              })
          .toList(),

      "receivableInfo": receivables
          .map((r) => {
                "recId": r.recId,
                "userId": r.userId,
                "receivableAmount": r.receivableAmount,
                "receivablePerson": r.receivablePerson,
                "receivablePersonMobile": r.receivablePersonMobile,
              })
          .toList(),

      "payableInfo": payables
          .map((p) => {
                "payId": p.payId,
                "userId": p.userId,
                "payableAmount": p.payableAmount,
                "payablePerson": p.payablePerson,
                "payablePersonMobile": p.payablePersonMobile,
              })
          .toList(),
      // Similarly for siblings, bankInfo, wealthInfo, shareMarketInfo, receivableInfo, payableInfo
    };

    try {
      final token = await PrefsHelper.getString(AppConstants.bearerToken);
      final resp = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        ToastMessageHelper.successMessageShowToster(data['message']);
        // Get.toNamed(AppRoutes.allBottomBarScreen);
        print("Submission success: ${resp.body}");
      } else {
        final data = jsonDecode(resp.body);
        ToastMessageHelper.errorMessageShowToster(data['message'] ?? "Error");
        print("Error: ${resp.statusCode} ${resp.body}");
      }
    } catch (e) {
      print("Exception during upload: $e");
      // handleSocket/timeout etc
    }
  }

  Future<void> getMaritalList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.maritalList,
      );
      maritalList(maritalListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getGenderList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.genderList,
      );

      genderList(genderListModelFromJson(jsonEncode(response.body)));
      log("Gender list: ${genderList.toJson()}");
    } catch (e, s) {
      log("Gender List Error: $e\nStacktrace: $s");
    }
  }

  Future<void> getProfessionList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.professionList,
      );
      professionList(professionListFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getCountryList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.countryList,
      );
      countryList(countryListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getBankList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.bankList,
      );
      bankList(bankListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getWealthList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.wealthList,
      );
      wealthList(wealthListModelFromJson(jsonEncode(response.body)));
    } catch (e) {}
  }

  Future<void> getProfile() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.getProfile,
      );

      profileModel(profileModelFromJson(jsonEncode(response.body)));
      selectedMarried(maritalList.firstWhere((element) =>
          element.maritalId ==
          profileModel.value.userProfile!.maritalStatusId));
      firstNameController.value.text =
          profileModel.value.userProfile!.firstName ?? "";
      lastNameController.value.text =
          profileModel.value.userProfile!.lastName ?? "";
      selectedCountry.value = countryList.firstWhere((element) =>
          element.countryId == profileModel.value.userProfile!.countryCode);
      districtController.value.text =
          profileModel.value.userProfile!.district ?? "";
      log("----****${profileModel.value.userProfile!.nid.toString()}");
      nidController.value.text = profileModel.value.userProfile!.nid.toString();
      passportController.value.text =
          profileModel.value.userProfile!.passportNo ?? "";
      selectedProfession.value = professionList.firstWhere((element) =>
          element.professionId == profileModel.value.userProfile!.professionId);
      selectedCountry.value = countryList.firstWhere((element) =>
          element.countryId == profileModel.value.userProfile!.countryCode);
      selectedGender.value = genderList.firstWhere((element) =>
          element.genderId ==
          int.parse(profileModel.value.userProfile!.gender.toString()));

      selectedBank(
        bankList.firstWhere(
          (element) => profileModel.value.bankInfo!.any(
            (bank) => bank.bankId == element.bankId,
          ),
        ),
      );

      selectedWealth(
        wealthList.firstWhere(
          (element) => profileModel.value.wealthInfo!.any(
            (wealth) => wealth.wealthId == element.wealthId,
          ),
        ),
      );
    } catch (e, s) {
      log("Error: $e\nStacktrace: $s");
    }
  }

  getProfilePageData() async {
    try {
      status(RxStatus.loading());
      await getMaritalList();
      await getProfessionList();
      await getCountryList();
      await getGenderList();
      await getBankList();
      await getWealthList();
      await getProfile();
      status(RxStatus.success());
    } catch (e) {
      status(RxStatus.error());
    }
  }

  @override
  void onInit() async {
    getProfilePageData();
    super.onInit();
  }
}

class SpouseItem {
  final int spouseId;
  final String spouseName;
  final int professionId;
  final int nationalityId;
  final String nid;
  final String? nidPaperPath;
  final String passport;
  final String? passportPaperPath;
  final String mobile;
  final String email;
  final bool existing;
  final int userId;
  final String? spouseNIDFile;
  final String? spousePassportFile;

  SpouseItem({
    required this.spouseId,
    required this.spouseName,
    required this.professionId,
    required this.nationalityId,
    required this.nid,
    this.nidPaperPath,
    required this.passport,
    this.passportPaperPath,
    required this.mobile,
    required this.email,
    required this.existing,
    required this.userId,
    this.spouseNIDFile,
    this.spousePassportFile,
  });

  factory SpouseItem.fromJson(Map<String, dynamic> json) {
    return SpouseItem(
      spouseId: json['spouseId'] ?? 0,
      spouseName: json['spouseName'] ?? '',
      professionId: json['professionId'] ?? 0,
      nationalityId: json['nationalityId'] ?? 0,
      nid: json['nid'] ?? '',
      nidPaperPath: json['nidPaperUrl'],
      passport: json['passport'] ?? '',
      passportPaperPath: json['passportPaperUrl'],
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      existing: json['existing'] ?? false,
      userId: json['userId'] ?? 0,
      spouseNIDFile: json['spouseNIDFile'],
      spousePassportFile: json['spousePassportFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "spouseId": spouseId,
      "spouseName": spouseName,
      "professionId": professionId,
      "nationalityId": nationalityId,
      "nid": nid,
      "nidPaperUrl": nidPaperPath,
      "passport": passport,
      "passportPaperUrl": passportPaperPath,
      "mobile": mobile,
      "email": email,
      "existing": existing,
      "userId": userId,
      "spouseNIDFile": spouseNIDFile,
      "spousePassportFile": spousePassportFile,
    };
  }
}

class ChildItem {
  final int childId;
  final String childName;
  final int genderId;
  final int professionId;
  final int nationalityId;
  final String dob;
  final String nid;
  final String? nidPaperPath;
  final String mobile;
  final String email;
  final bool existing;
  final int userId;
  final String? nidFile;

  ChildItem({
    required this.childId,
    required this.childName,
    required this.genderId,
    required this.professionId,
    required this.nationalityId,
    required this.dob,
    required this.nid,
    this.nidPaperPath,
    required this.mobile,
    required this.email,
    required this.existing,
    required this.userId,
    this.nidFile,
  });

  factory ChildItem.fromJson(Map<String, dynamic> json) {
    return ChildItem(
      childId: json['childId'] ?? 0,
      childName: json['childName'] ?? '',
      genderId: json['genderId'] ?? 0,
      professionId: json['professionId'] ?? 0,
      nationalityId: json['nationalityId'] ?? 0,
      dob: json['dob'] ?? '',
      nid: json['nid'] ?? '',
      nidPaperPath: json['nidPaperUrl'],
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      existing: json['existing'] ?? false,
      userId: json['userId'] ?? 0,
      nidFile: json['nidFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "childId": childId,
      "childName": childName,
      "genderId": genderId,
      "professionId": professionId,
      "nationalityId": nationalityId,
      "dob": dob,
      "nid": nid,
      "nidPaperUrl": nidPaperPath,
      "mobile": mobile,
      "email": email,
      "existing": existing,
      "userId": userId,
      "nidFile": nidFile,
    };
  }
}

class SiblingItem {
  final int siblingId;
  final String siblingName;
  final int genderId;
  final int professionId;
  final int nationalityId;
  final String nid;
  final String dob;
  final bool existing;
  final String? nidPaperPath;
  final String whatsAppNumber;
  final String email;
  final String mobile;
  final String socialMediaLink;
  final int userId;
  final String? nidFile;

  SiblingItem({
    required this.siblingId,
    required this.siblingName,
    required this.genderId,
    required this.professionId,
    required this.nationalityId,
    required this.nid,
    required this.dob,
    required this.existing,
    this.nidPaperPath,
    required this.whatsAppNumber,
    required this.email,
    required this.mobile,
    required this.socialMediaLink,
    required this.userId,
    this.nidFile,
  });

  factory SiblingItem.fromJson(Map<String, dynamic> json) {
    return SiblingItem(
      siblingId: json['siblingId'] ?? 0,
      siblingName: json['siblingName'] ?? '',
      genderId: json['genderId'] ?? 0,
      professionId: json['professionId'] ?? 0,
      nationalityId: json['nationalityId'] ?? 0,
      nid: json['nid'] ?? '',
      dob: json['dob'] ?? '',
      existing: json['existing'] ?? false,
      nidPaperPath: json['nidPaperUrl'],
      whatsAppNumber: json['whatsAppNumber'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      socialMediaLink: json['socialMediaLink'] ?? '',
      userId: json['userId'] ?? 0,
      nidFile: json['nidFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "siblingId": siblingId,
      "siblingName": siblingName,
      "genderId": genderId,
      "professionId": professionId,
      "nationalityId": nationalityId,
      "nid": nid,
      "dob": dob,
      "existing": existing,
      "nidPaperUrl": nidPaperPath,
      "whatsAppNumber": whatsAppNumber,
      "email": email,
      "mobile": mobile,
      "socialMediaLink": socialMediaLink,
      "userId": userId,
      "nidFile": nidFile,
    };
  }
}

class BankInfoItem {
  final int userBankInfoId;
  final int userId;
  final String bankId;
  final String branchId;
  final String bankAccNo;
  final double accBalance;

  BankInfoItem({
    required this.userBankInfoId,
    required this.userId,
    required this.bankId,
    required this.branchId,
    required this.bankAccNo,
    required this.accBalance,
  });

  factory BankInfoItem.fromJson(Map<String, dynamic> json) {
    return BankInfoItem(
      userBankInfoId: json['userBankInfoId'] ?? 0,
      userId: json['userId'] ?? 0,
      bankId: json['bankId'] ?? '',
      branchId: json['branchId'] ?? '',
      bankAccNo: json['bankAccNo'] ?? '',
      accBalance: (json['accBalance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userBankInfoId": userBankInfoId,
      "userId": userId,
      "bankId": bankId,
      "branchId": branchId,
      "bankAccNo": bankAccNo,
      "accBalance": accBalance,
    };
  }
}

class WealthItem {
  final int userId;
  final int wealthId;
  final int documentTypeId;
  final String? documentPaperPath;
  final String amount;
  final String location;
  final String note;
  final String? documentFile;

  WealthItem({
    required this.userId,
    required this.wealthId,
    required this.documentTypeId,
    this.documentPaperPath,
    required this.amount,
    required this.location,
    required this.note,
    this.documentFile,
  });

  factory WealthItem.fromJson(Map<String, dynamic> json) {
    return WealthItem(
      userId: json['userId'] ?? 0,
      wealthId: json['wealthId'] ?? 0,
      documentTypeId: json['documentTypeId'] ?? 0,
      documentPaperPath: json['documentPaperUrl'],
      amount: json['amount'] ?? '',
      location: json['location'] ?? '',
      note: json['note'] ?? '',
      documentFile: json['documentFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "wealthId": wealthId,
      "documentTypeId": documentTypeId,
      "documentPaperUrl": documentPaperPath,
      "amount": amount,
      "location": location,
      "note": note,
      "documentFile": documentFile,
    };
  }
}

class ShareMarketItem {
  final int userShareMarketId;
  final int userId;
  final String brokerHouseName;
  final String accName;
  final String accNumber;
  final String shareCompanyName;
  final String shareQuality;
  final String buyingAmount;

  ShareMarketItem({
    required this.userShareMarketId,
    required this.userId,
    required this.brokerHouseName,
    required this.accName,
    required this.accNumber,
    required this.shareCompanyName,
    required this.shareQuality,
    required this.buyingAmount,
  });

  factory ShareMarketItem.fromJson(Map<String, dynamic> json) {
    return ShareMarketItem(
      userShareMarketId: json['userShareMarketId'] ?? 0,
      userId: json['userId'] ?? 0,
      brokerHouseName: json['brokerHouseName'] ?? '',
      accName: json['accName'] ?? '',
      accNumber: json['accNumber'] ?? '',
      shareCompanyName: json['shareCompanyName'] ?? '',
      shareQuality: json['shareQuality'] ?? '',
      buyingAmount: json['buyingAmount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userShareMarketId": userShareMarketId,
      "userId": userId,
      "brokerHouseName": brokerHouseName,
      "accName": accName,
      "accNumber": accNumber,
      "shareCompanyName": shareCompanyName,
      "shareQuality": shareQuality,
      "buyingAmount": buyingAmount,
    };
  }
}

class ReceivableItem {
  final int recId;
  final int userId;
  final double receivableAmount;
  final String receivablePerson;
  final String receivablePersonMobile;

  ReceivableItem({
    required this.recId,
    required this.userId,
    required this.receivableAmount,
    required this.receivablePerson,
    required this.receivablePersonMobile,
  });

  factory ReceivableItem.fromJson(Map<String, dynamic> json) {
    return ReceivableItem(
      recId: json['recId'] ?? 0,
      userId: json['userId'] ?? 0,
      receivableAmount: (json['receivableAmount'] ?? 0).toDouble(),
      receivablePerson: json['receivablePerson'] ?? '',
      receivablePersonMobile: json['receivablePersonMobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "recId": recId,
      "userId": userId,
      "receivableAmount": receivableAmount,
      "receivablePerson": receivablePerson,
      "receivablePersonMobile": receivablePersonMobile,
    };
  }
}

class PayableItem {
  final int payId;
  final int userId;
  final double payableAmount;
  final String payablePerson;
  final String payablePersonMobile;

  PayableItem({
    required this.payId,
    required this.userId,
    required this.payableAmount,
    required this.payablePerson,
    required this.payablePersonMobile,
  });

  factory PayableItem.fromJson(Map<String, dynamic> json) {
    return PayableItem(
      payId: json['payId'] ?? 0,
      userId: json['userId'] ?? 0,
      payableAmount: (json['payableAmount'] ?? 0).toDouble(),
      payablePerson: json['payablePerson'] ?? '',
      payablePersonMobile: json['payablePersonMobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "payId": payId,
      "userId": userId,
      "payableAmount": payableAmount,
      "payablePerson": payablePerson,
      "payablePersonMobile": payablePersonMobile,
    };
  }
}
