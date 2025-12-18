import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:al_wasyeah/helpers/file_download_util.dart'; // Import DownloadUtil explicitly if not in utils.dart
import '../../view/screen/screen.dart';

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
  Rx<TextEditingController> tinController = TextEditingController().obs;

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

  RxBool isDownloadingNid = false.obs;
  RxDouble nidDownloadProgress = 0.0.obs;
  Rxn<PickedFileResult> pickedNIDFile = Rxn();
  Rxn<PickedFileResult> pickedTinFile = Rxn();
  Rxn<PickedFileResult> pickedMultiCitizenFile = Rxn();

  RxBool isDownloadingTin = false.obs;
  RxDouble tinDownloadProgress = 0.0.obs;

  RxBool isDownloadingMultiCitizen = false.obs;
  RxDouble multiCitizenDownloadProgress = 0.0.obs;

  RxBool isPresentAddressAsPermanentAddress = false.obs;

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

  void pickNidFile() async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      pickedNIDFile(result);
    }
  }

  Future<void> downloadNidFile() async {
    log(profileModel.value.userProfile?.nidPaperUrl ?? '');
    if (profileModel.value.userProfile?.nidPaperUrl == null) {
      return;
    }
    isDownloadingNid(true);
    nidDownloadProgress(0.0);

    final String fileName =
        'NID_${profileModel.value.userProfile?.firstName ?? "User"}_${profileModel.value.userProfile?.lastName ?? ""}_${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';

    FileDownloadUtil().downloadFile(
      '${ApiConstants.imageUrl}${profileModel.value.userProfile?.nidFile}',
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

  void pickTinFile() async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      pickedTinFile(result);
    }
  }

  Future<void> downloadTinFile() async {
    if (profileModel.value.userProfile?.tinPaperUrl == null) {
      return;
    }
    isDownloadingTin(true);
    tinDownloadProgress(0.0);

    final String fileName =
        'TIN_${profileModel.value.userProfile?.firstName ?? "User"}_${profileModel.value.userProfile?.lastName ?? ""}_${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf'; // Adjust extension if needed

    FileDownloadUtil().downloadFile(
      '${ApiConstants.imageUrl}${profileModel.value.userProfile?.tinPaperUrl}', // Use correct URL path

      fileName,
      (progress) {
        tinDownloadProgress(progress);
        if (progress >= 100) {
          isDownloadingTin(false);
        }
      },
    ).catchError((e) {
      isDownloadingTin(false);
      print('Download failed: $e');
    });
  }

  void pickMultiCitizenFile() async {
    var result = await FilePickerUtil.pickSingleFile();
    if (result != null) {
      pickedMultiCitizenFile(result);
    }
  }

  Future<void> downloadMultiCitizenFile() async {
    if (profileModel.value.userProfile?.passportPaperUrl == null) {
      return;
    }
    isDownloadingMultiCitizen(true);
    multiCitizenDownloadProgress(0.0);

    final String fileName =
        'MultiCitizen_${profileModel.value.userProfile?.firstName ?? "User"}_${profileModel.value.userProfile?.lastName ?? ""}_${DateFormat("yyyyMMdd_HHmm").format(DateTime.now())}.pdf';

    FileDownloadUtil().downloadFile(
      '${ApiConstants.imageUrl}${profileModel.value.userProfile?.passportPaperUrl}',
      fileName,
      (progress) {
        multiCitizenDownloadProgress(progress);
        if (progress >= 100) {
          isDownloadingMultiCitizen(false);
        }
      },
    ).catchError((e) {
      isDownloadingMultiCitizen(false);
      print('Download failed: $e');
    });
  }

  List<SpouseItemS> addSpouseList = [];
  List<ChildrenInfo> addChildrenInfoList = [];

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
      passportController.value.text =
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
      // permanent zip code
      permanentZipCodeController.value.text =
          profileModel.value.userProfile!.permanentAddress?.split(',')[0] ?? "";

      // permanent village
      permanentVillageController.value.text =
          profileModel.value.userProfile!.permanentAddress?.split(',')[1] ?? "";

      // permanent road
      permanentRoadController.value.text =
          profileModel.value.userProfile!.permanentAddress?.split(',')[2] ?? "";

      // overseas country
      selectedOverseasCountry.value = countryList.firstWhere((element) =>
          element.countryId ==
          profileModel.value.userProfile!.overseasCountryCode);

      // overseas village
      overseasVillageController.value.text =
          profileModel.value.userProfile!.overseasVillage ?? "";

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
