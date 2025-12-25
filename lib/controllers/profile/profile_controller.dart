import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:al_wasyeah/models/profile_info_model/bank_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profile_model.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_list_model.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:al_wasyeah/helpers/file_download_util.dart';
import 'profile_enum.dart';
import 'spouse_form.dart';

class ProfileController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentStep = 0.obs;
  Rx<RxStatus> status = RxStatus.loading().obs;
  Rxn<MaritalModel> selectedMarried = Rxn();
  Rxn<ProfessionModel> selectedProfession = Rxn();
  Rxn<CountryModel> selectedCountry = Rxn();
  Rxn<CountryModel> selectedMultiCitizenCountry = Rxn();
  Rxn<GenderModel> selectedGender = Rxn();
  Rxn<BankModel> selectedBank = Rxn();
  Rxn<WealthModel> selectedWealth = Rxn();
  Rxn<CountryModel> selectedOverseasCountry = Rxn();
  Rxn<ProfessionModel> selectedFatherProfession = Rxn();
  Rxn<CountryModel> selectedFatherCountry = Rxn();
  Rxn<ProfessionModel> selectedMotherProfession = Rxn();
  Rxn<CountryModel> selectedMotherCountry = Rxn();

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
  Rx<TextEditingController> citizenshipPassportOrNIDController =
      TextEditingController().obs;
  Rx<TextEditingController> tinController = TextEditingController().obs;
  Rx<TextEditingController> fatherNameController = TextEditingController().obs;
  Rx<TextEditingController> motherNameController = TextEditingController().obs;
  Rx<TextEditingController> fatherPassOrNIDController =
      TextEditingController().obs;
  Rx<TextEditingController> motherPassOrNIDController =
      TextEditingController().obs;

  Rx<TextEditingController> multiCitizenPassportController =
      TextEditingController().obs;

  Rx<TextEditingController> presentZipCodeController =
      TextEditingController().obs;
  Rx<TextEditingController> presentVillageController =
      TextEditingController().obs;
  Rx<TextEditingController> presentRoadController = TextEditingController().obs;

  Rx<TextEditingController> permanentZipCodeController =
      TextEditingController().obs;
  Rx<TextEditingController> permanentVillageController =
      TextEditingController().obs;
  Rx<TextEditingController> permanentRoadController =
      TextEditingController().obs;
  Rx<TextEditingController> overseasVillageController =
      TextEditingController().obs;

  // Enum for download types
  // Enum for download types
  RxMap<ProfileDownloadType, bool> isDownloadingMap =
      <ProfileDownloadType, bool>{}.obs;
  RxMap<ProfileDownloadType, double> downloadProgressMap =
      <ProfileDownloadType, double>{}.obs;

  RxMap<ProfilePickerType, PickedFileResult> pickedFileMap =
      <ProfilePickerType, PickedFileResult>{}.obs;

  RxBool isPresentAddressAsPermanentAddress = false.obs;
  RxBool isFatherAlive = false.obs, isMotherAlive = false.obs;

  final step1formKey = GlobalKey<FormState>();
  final step2formKey = GlobalKey<FormState>();
  @override
  void onInit() async {
    getProfilePageData();
    super.onInit();
  }

  void onStepTapped(int step) {
    currentStep(step);
    pageController.animateToPage(
      step,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void pickFile(ProfilePickerType type) async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      pickedFileMap[type] = result;
    }
  }

  Future<bool> _downloadGenericFile({
    required String? urlPath,
    required String filePrefix,
    required ProfileDownloadType type,
  }) async {
    if (urlPath == null) {
      return false;
    }

    isDownloadingMap[type] = true;
    downloadProgressMap[type] = 0.0;

    final completer = Completer<bool>();

    final String fileName =
        '${filePrefix}_${profileModel.value.userProfile?.firstName ?? "User"}_'
        '${profileModel.value.userProfile?.lastName ?? ""}_'
        '${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';

    final String filePath = '${ApiConstants.imageUrl}$urlPath';
    log("$filePrefix File Path: $filePath");

    FileDownloadUtil.downloadFile(
      filePath,
      fileName,
      (progress) {
        downloadProgressMap[type] = progress;

        if (progress >= 100) {
          isDownloadingMap[type] = false;
          log("Download $filePrefix Successful");
          completer.complete(true);
        }
      },
    ).catchError((e) {
      isDownloadingMap[type] = false;
      log('Download $filePrefix failed: $e');
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });

    return completer.future;
  }

  Future<bool> downloadNidFile() async {
    return _downloadGenericFile(
      urlPath: profileModel.value.userProfile?.nidPaperUrl,
      filePrefix: 'NID',
      type: ProfileDownloadType.nid,
    );
  }

  Future<bool> downloadTinFile() async {
    return _downloadGenericFile(
      urlPath: profileModel.value.userProfile?.tinPaperUrl,
      filePrefix: 'TIN',
      type: ProfileDownloadType.tin,
    );
  }

  Future<bool> downloadMultiCitizenFile() async {
    return _downloadGenericFile(
      urlPath: profileModel.value.userProfile?.passportPaperUrl,
      filePrefix: 'MultiCitizen',
      type: ProfileDownloadType.multiCitizen,
    );
  }

  // Spouse File Logic
  void pickSpouseFile(SpouseForm form, {required bool isNid}) async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      if (isNid) {
        form.selectedNidFile.value = result;
      } else {
        form.selectedPassportFile.value = result;
      }
    }
  }

  Future<void> downloadSpouseFile(SpouseForm form,
      {required bool isNid}) async {
    String? urlPath = isNid ? form.nidUrl : form.passportUrl;
    if (urlPath == null) return;

    RxBool isDownloading =
        isNid ? form.isDownloadingNid : form.isDownloadingPassport;
    RxDouble progress =
        isNid ? form.nidDownloadProgress : form.passportDownloadProgress;
    String prefix = isNid ? "Spouse_NID" : "Spouse_Passport";

    isDownloading.value = true;
    progress.value = 0.0;

    final String fileName =
        '${prefix}_${form.name.text}_${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';
    final String filePath = '${ApiConstants.imageUrl}$urlPath';

    await FileDownloadUtil.downloadFile(
      filePath,
      fileName,
      (prog) {
        progress.value = prog;
        if (prog >= 100) {
          isDownloading.value = false;
        }
      },
    ).catchError((e) {
      isDownloading.value = false;
    });
  }

  // Spouse List Management
  RxList<SpouseForm> spouseList = <SpouseForm>[].obs;

  // Children List Management
  // Keeping original list for now as user only requested Spouse refactor,
  // but logically this should also be refactored later.
  List<ChildrenInfo> addChildrenInfoList = [];

  void addSpouse() {
    spouseList.add(SpouseForm());
  }

  void removeSpouse(int index) {
    if (index >= 0 && index < spouseList.length) {
      final item = spouseList[index];
      // If needed we can call API to delete if it's an existing item
      item.dispose();
      spouseList.removeAt(index);
    }
  }

  Future<void> getMaritalList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.maritalList,
      );
      maritalList(maritalListModelFromJson(jsonEncode(response.body)));
    } catch (e, s) {
      log("Marital List Error: $e\nStacktrace: $s");
    }
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
      // first name
      firstNameController.value.text =
          profileModel.value.userProfile!.firstName ?? "";
      // last name
      lastNameController.value.text =
          profileModel.value.userProfile!.lastName ?? "";
      // marital status
      selectedMarried.value = maritalList.firstWhere((element) =>
          element.maritalId == profileModel.value.userProfile!.maritalStatusId);
      // country
      selectedCountry.value = countryList.firstWhere((element) =>
          element.countryId == profileModel.value.userProfile!.countryCode);
      // district
      districtController.value.text =
          profileModel.value.userProfile!.district ?? "";
      // nid
      nidController.value.text = profileModel.value.userProfile!.nid.toString();
      // passport
      citizenshipPassportOrNIDController.value.text =
          profileModel.value.userProfile!.passportNo ?? "";
      selectedProfession.value = professionList.firstWhere((element) =>
          element.professionId == profileModel.value.userProfile!.professionId);
      // country
      selectedCountry.value = countryList.firstWhere((element) =>
          element.countryId == profileModel.value.userProfile!.countryCode);
      // gender
      selectedGender.value = genderList.firstWhere((element) =>
          element.genderId ==
          int.parse(profileModel.value.userProfile!.gender.toString()));
      // tin number
      tinController.value.text = profileModel.value.userProfile!.tin ?? "";
      // multi citizen passport
      multiCitizenPassportController.value.text =
          profileModel.value.userProfile!.multipleCitizenPassportNo ?? "";
      // present zip code
      presentZipCodeController.value.text =
          profileModel.value.userProfile!.presentAddress?.split(',')[0] ?? "";
      // present village
      presentVillageController.value.text =
          profileModel.value.userProfile!.presentAddress?.split(',')[1] ?? "";
      presentRoadController.value.text =
          profileModel.value.userProfile!.presentAddress?.split(',')[2] ?? "";

      // overseas country
      selectedOverseasCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.userProfile!.overseasCountryCode);

      // overseas village
      overseasVillageController.value.text =
          profileModel.value.userProfile!.overseasVillage ?? "";

      // father name
      fatherNameController.value.text =
          profileModel.value.parentInfo?.fatherName ?? "";
      // father profession
      selectedFatherProfession.value = professionList.firstWhere((element) =>
          element.professionId ==
          profileModel.value.parentInfo?.fatherProfessionId);
      // father country
      selectedFatherCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.parentInfo?.fatherNationalityId);
      // father passport or nid
      fatherPassOrNIDController.value.text =
          profileModel.value.parentInfo?.fatherNid.toString() ?? "";
      // father alive dead
      isFatherAlive.value =
          profileModel.value.parentInfo?.fatherExisting ?? false;
      // mother name
      motherNameController.value.text =
          profileModel.value.parentInfo?.motherName ?? "";

      // mother profession
      selectedMotherProfession.value = professionList.firstWhere((element) =>
          element.professionId ==
          profileModel.value.parentInfo?.motherProfessionId);
      // mother country
      selectedMotherCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.parentInfo?.motherNationalityId);
      // mother passport or nid
      motherPassOrNIDController.value.text =
          profileModel.value.parentInfo?.motherNid.toString() ?? "";
      // mother alive dead
      isMotherAlive.value =
          profileModel.value.parentInfo?.motherExisting ?? false;
      // Spouse
      spouseList.clear();
      if (profileModel.value.spouseInfo != null) {
        for (var spouse in profileModel.value.spouseInfo!) {
          spouseList.add(SpouseForm(
            spouseId: spouse.spouseId,
            userId: spouse.userId,
            existing: spouse.existing,
            nameVal: spouse.spouseName,
            nidVal: spouse.nid,
            passportVal:
                spouse.passport != null ? spouse.passport.toString() : '',
            mobileVal: spouse.mobile,
            emailVal: spouse.email,
            nidUrl: spouse.nidPaperUrl,
            passportUrl: spouse.passportPaperUrl != null
                ? spouse.passportPaperUrl.toString()
                : null, // Assuming this is dynamic
            isAliveVal:
                true, // Assuming alive by default or need a field for it
          ));
          // Set selection models
          if (spouseList.last.profession.value == null &&
              spouse.professionId != null) {
            spouseList.last.profession.value = professionList
                .firstWhereOrNull((p) => p.professionId == spouse.professionId);
          }
          if (spouseList.last.nationality.value == null &&
              spouse.nationalityId != null) {
            spouseList.last.nationality.value = countryList
                .firstWhereOrNull((c) => c.countryId == spouse.nationalityId);
          }
        }
      }

      // 1st
      try {
        if (profileModel.value.userProfile!.multipleCitizenCode != null) {
          selectedMultiCitizenCountry.value = countryList.firstWhere(
              (element) =>
                  element.countryId ==
                  profileModel.value.userProfile!.multipleCitizenCode);
        }
      } catch (e, s) {
        log("Error: $e\nStacktrace: $s");
      }

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
}
